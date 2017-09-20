package azura.banshee.zebra.zmotion
{
	import azura.banshee.zebra.i.ZmatrixOpI;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	import azura.common.algorithm.mover.Cycler;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ZmatrixOp implements ZmatrixOpI
	{
		private var node:ZboxOld;
		private var cycler:Cycler=new Cycler();
		
		private var _zUp:int=0;
		private var _angle:int=0;
		private var _row:int=-1;
		private var fps_:int;
		
		private var rowList:Vector.<ZlineSp>;
		private var ret:Function;
		
		private var line:ZlineSp;
		private var lineFuture:ZlineSp;
		
		public function ZmatrixOp(rowList:Vector.<ZlineSp>, fps:int)
		{
			if(rowList.length==0)
				throw new Error();
			
			this.rowList=rowList;
			fps_=fps;
			//			line=rowList[0];
		}
		
		public function set fps(value:int):void{
			fps_=value;
			cycler.fps=fps_;
		}
		
		public function get boundingBox():Rectangle{
			if(line!=null)
				return line.currentFrame.boundingBox;
			else
				return lineFuture.currentFrame.boundingBox;
		}
		
		private function getCurrentLine():ZlineSp{
			var rowCount:int=rowList.length;
			var row:int=(_angle+180/rowCount)%360/360*rowCount;
			if(_row!=row){
				_row=row;
			}
			return rowList[row];
		}
		
		public function set scale(value:Number):void{
			for each(var row:ZlineSp in rowList){
				row.scale=value;
			}
		}
		
		public function show():void{
//			trace("show",this);
			cycler.target=line;
		}
		
		/**
		 * 
		 * line will be selectively used, but won't be disposed unless the matrix is disposed
		 * Return is requested only for the first time.
		 * return: the user wants to know when this can display at all. Once ready to display anyting ,the user can start using this.
		 * before that,the user uses the old staff. after loaded, the old staff becomes this and this.line.
		 * 
		 */
		public function load(angle:int,ret_ZmatrixOp:Function):void{
//			trace("load",this);
			this.ret=ret_ZmatrixOp;
			this.angle=angle;
		}
		
		/**
		 * Also reponsible for loading
		 * 
		 */
		public function set angle(value:int):void
		{
			//			trace("set angle",this);
			var flat:Point=FastMath.angle2Xy(value);
			var top:Point=Neck.flatToTop(flat.x,flat.y,0);
			_angle=FastMath.xy2Angle(top.x,top.y);
			
			doLoad();
		}
		
		private function doLoad():void{
			var target:ZlineSp=getCurrentLine();
			if(target==lineFuture||target==line)
				return;
			
			if(lineFuture!=null)
				lineFuture.sleep();
			
			lineFuture=target;
			lineFuture.load(lineLoaded);			
		}
		
		/**
		 * only the currently requested line will report loaded 
		 * 
		 */
		public function lineLoaded(target:ZlineSp):void{
//			trace("loaded",this);
			if(target!=lineFuture)
				throw new Error();
			
			if(line!=null){
				lineFuture.framePercent=line.framePercent;
				line.sleep();
				line=null;
			}
			line=lineFuture;
			lineFuture=null;
			
			if(ret!=null){
				ret.call(null,this);
				ret=null;
			}else{
				show();
			}
		}
		
		public function get framePercent():int
		{
			if(line!=null)
				return line.framePercent;
			else
				return lineFuture.framePercent;
		}
		
		public function set framePercent(value:int):void
		{
			if(line!=null)
				line.framePercent=value;
			if(lineFuture!=null)
				lineFuture.framePercent=value;
		}
		
		public function dispose():void{
			cycler.dispose();
			for each(var row:ZlineSp in rowList){
				row.dispose();
			}
		}
	}
}