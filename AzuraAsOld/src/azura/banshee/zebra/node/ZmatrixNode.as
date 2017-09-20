package azura.banshee.zebra.node
{
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.Zmatrix;
	import azura.banshee.zebra.i.ZebraBranchNodeI;
	import azura.banshee.zebra.i.ZmatrixOpI;
	import azura.banshee.zebra.zmotion.ZhlineOp;
	import azura.banshee.zebra.zmotion.Zline;
	import azura.banshee.zebra.zmotion.ZlineSp;
	import azura.banshee.zebra.zmotion.ZmatrixOp;
	import azura.banshee.zebra.zmotion.ZvlineOp;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.Zshard;
	
	import flash.geom.Rectangle;
	
	public class ZmatrixNode extends ZboxOld implements ZebraBranchNodeI
	{
		private var zUp:int;
		private var _angle:int;
		private var sprite:Zshard;
		
		private var ret:Function;
		private var op:ZmatrixOpI;
		private var opFuture:ZmatrixOpI;		
		
		public function ZmatrixNode(parent:ZboxOld) {
			super(parent);
			this.sprite=new Zshard(this);
		}
		
		public function get boundingBox():Rectangle{
			return op.boundingBox;
		}
		
		/**
		 * 
		 * This happens at init time.
		 * 
		 */
		public function load(value:Zebra,ret:Function):void
		{
//			trace("load",this);
			var _data:Zmatrix = value.branch as Zmatrix;
			this.ret=ret;
			
			var rows:Vector.<ZlineSp>=new Vector.<ZlineSp>();
			for each(var l:Zline in _data.lineList){
				var lop:ZlineSp=new ZlineSp(sprite,l,zUp);
				rows.push(lop);
			}
			
			if(opFuture!=null){
				opFuture.dispose();
				opFuture=null;				
			}
			
			if(_data.type==Zmatrix.zmatrix){
				opFuture=new ZmatrixOp(rows,value.fps);
			}else if(_data.type==Zmatrix.zhline){
				opFuture=new ZhlineOp(rows[0],value.fps);
			}else if(_data.type==Zmatrix.zvline){
				opFuture=new ZvlineOp(rows[0]);
			}else{
				throw new Error("ZmotionOp: unknown format");
			}
			
			opFuture.scale=scaleGlobal;
			opFuture.load(_angle,opLoaded);
		}
		
		private function opLoaded(loaded:ZmatrixOpI):void{
//			trace("loaded",this);
			if(loaded!=opFuture)
				throw new Error();
			
			if(op!=null)
				op.dispose();
			op=opFuture;
			opFuture=null;
			
			if(ret!=null){
				ret.call(null,this);
				ret=null;				
			}
		}
		
		public function show():void{
//			trace("show",this);
			op.show();
		}
		
		public function set fps(value:int):void{
			if(op!=null)
				op.fps=value;
			if(opFuture!=null)
				opFuture.fps=value;
		}
		
		override protected function scaleChange(scaleGlobal:Number):void{
			if(op!=null)
				op.scale=scaleGlobal;
			if(opFuture!=null)
				opFuture.scale=scaleGlobal;
		}
		
		public function look(viewLocal:Rectangle):void
		{
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
		public function set angle(value:Number):void
		{
			_angle=value;
			if(op!=null)
				op.angle=_angle;
			if(opFuture!=null){
				opFuture.angle=_angle;
			}
		}
		
		override public function dispose():void
		{
			if(op!=null){
				op.dispose();
				op=null;
			}
			if(opFuture!=null){
				opFuture.dispose();
				opFuture=null;
			}
			super.dispose();
		}
		
	}
}