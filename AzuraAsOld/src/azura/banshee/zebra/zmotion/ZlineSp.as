package azura.banshee.zebra.zmotion
{
	import azura.banshee.zebra.atlas.Zatlas;
	import azura.banshee.zebra.atlas.Zframe;
	import azura.banshee.zebra.zode.ZatlasOp;
	import azura.banshee.zebra.zode.ZframeOp;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.banshee.zebra.zode.Zshard;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.mover.FramerI;
	import azura.gallerid3.Gallerid;
	
	import org.osflash.signals.Signal;
	
	public class ZlineSp implements FramerI
	{
		private var sprite:Zshard;
		
		public var currentFrameIdx:int=-1;
		private var _frameCount:int;
		
		private var _zUp:int=-1;
		private var layer:ZatlasOp;
		private var layerFuture:ZatlasOp;
		private var layerList:Vector.<ZatlasOp>=new Vector.<ZatlasOp>();
		
		private var ret:Function;
		
		public function ZlineSp(sprite:Zshard,data:Zline,zUp:int)
		{
			this.sprite=sprite;
			_frameCount=data.frames;
			this._zUp=zUp;
			
			for each(var layer:Zatlas in data.layerList){
				var op:ZatlasOp=new ZatlasOp(sprite.host);
				op.data=layer;
				layerList.push(op);
			}
		}
		
		/**
		 *
		 * always return unless sleeping
		 * 
		 */
		public function load(ret_ZlineOp:Function):void{
//			trace("load",this);
			this.ret=ret_ZlineOp;
			doLoad();
		}
		
		private function doLoad():void{
			var target:ZatlasOp=getCurrentLayer();
			if(target==layerFuture)
				return;
			
			if(target==layer){
				ret.call(null,this);
				return;
			}
			
			if(layerFuture!=null)
				layerFuture.sleep();
			
			layerFuture=target;
			layerFuture.load(layerLoaded);
		}
		
		public function layerLoaded(loaded:ZatlasOp):void{
//			trace("loaded",this);
			if(layer!=null)
				layer.sleep();
			layer=layerFuture;
			layerFuture=null;
			ret.call(null,this);
		}		
		
		private function getCurrentLayer():ZatlasOp{
			if(_zUp>=0&&_zUp<layerList.length)
				return layerList[_zUp];
			else
				return null;
		}
		
		public function sleep():void{
			//			sleeping=true;/
			if(layer!=null)
				layer.sleep();
			if(layerFuture!=null){
				layerFuture.sleep();
				layerFuture=null;
			}
		}
		
		/**
		 * 
		 * Will not initialize a loading
		 * the first set zUp happens before load
		 * 
		 */
		public function set scale(value:Number):void{
			trace("scale:todo",this);			
			
			var zUpNew:int=FastMath.log2(Math.floor(1/value));
			if(_zUp!=zUpNew){
				var target:ZatlasOp=getCurrentLayer();
				
			}
		}		
		
		//============= frame ================
		/**
		 * 
		 * Can call showFrame at any time. If not loaded, then nothing is shown. Will not cause loading.
		 * 
		 */
		public function showFrame(idxFrame:int=-1):void
		{
			if(currentFrameIdx==idxFrame)
				return;
			
			var cu:ZatlasOp=getCurrentLayer();
			
			if(idxFrame>=0)
				currentFrameIdx=idxFrame;
			
			//			trace("show frame",currentFrameIdx,this);
			//			if(idxFrameToShow==0)
			//				trace("000");
			
			if(currentFrameIdx<0)
				return;
			else if(currentFrameIdx>=frameCount)
				currentFrameIdx=0;
			
			if(cu==null || cu.idle_loading_loaded!=2)
				return;
			
			//============ display ============
			doDisplay();
		}
		
		private function doDisplay():void{
			var cu:ZatlasOp=getCurrentLayer();
			
			var frame:Zframe=cu.data.frameList[currentFrameIdx];			
			var zs:ZframeOp=new ZframeOp();
			zs.sheet=cu.sheetList[frame.idxSheet];
			zs.subId=currentFrameIdx.toString();
			zs.boundingBox=frame.boundingBox;
			zs.rectOnSheet=frame.rectOnSheet.clone();
			zs.scale=FastMath.pow2x(_zUp);
			zs.driftX=-frame.anchor.x*zs.scale;
			zs.driftY=-frame.anchor.y*zs.scale;			
			sprite.display(zs);
		}
		
		public function get nextFrameIdx():int{
			return currentFrameIdx+1;
		}
		
		public function get framePercent():int
		{
			return 100*currentFrameIdx/frameCount;
		}
		
		public function set framePercent(value:int):void
		{
			currentFrameIdx=value*frameCount/100;
		}
		
		public function get currentFrame():Zframe{
			var cl:ZatlasOp=getCurrentLayer();
			if(cl!=null){
				if(currentFrameIdx==-1)
					currentFrameIdx=0;
				return cl.data.frameList[currentFrameIdx];
			}
			else
				return null;
		}
		
		public function get frameCount():int
		{
			return _frameCount;
		}
		
		public function dispose():void{
			for each(var zao:ZatlasOp in layerList){
				zao.dispose();
			}
		}
	}
}
