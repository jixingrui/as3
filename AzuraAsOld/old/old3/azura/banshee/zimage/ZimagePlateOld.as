package old.azura.banshee.zimage {
	
	import azura.banshee.zebra.i.ZimageOpI;
	import old.azura.banshee.zimage.i.ZrendererI;
	import old.azura.banshee.zimage.plate.ZplateOld;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid.Gal_Http2Old;
	
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	import azura.banshee.zebra.zimage.large.ZimageLargeOp;
	import azura.banshee.zebra.zimage.ZimageTinyOp;
	
	/**
	 * zMax=[0,1,2,3...7...]
	 * left,top,width,height (from center)
	 * tiny=[1,2,4,8...128]
	 * large=[256,512...]
	 * 
	 */
	public class ZimagePlateOld extends ZplateOld implements BytesI{
		
		private var bak:ZintBuffer;
		public var boundingBox:Rectangle=new Rectangle();
		public var tiny:ZimageTinyOp;
		public var large:ZimageLargeOp;
		private var op:ZimageOpI;
		
		private var inVisual:Boolean;
		
		private var _onLoaded:Signal=new Signal();
		
		public function ZimagePlateOld(parent:ZplateOld, renderer:ZrendererI)
		{
			super(parent, renderer);
//			tiny=new ZimageTinyOp(renderer);
//			large=new ZimageLargeOp(null);
		}
		
		public function get onLoaded():Signal
		{
			return _onLoaded;
		}
		
		public function set md5(value:String):void{
			clear();
			if(value==null||value.length!=32){
				return;				
			}
			
			new Gal_Http2Old(value).load(onDownloaded);
			function onDownloaded(gh:Gal_Http2Old):void{
				var zb:ZintBuffer=gh.value as ZintBuffer;
				zb.uncompress();
				fromBytes(zb);
			}
		}
				
		public function fromBytes(zb:ZintBuffer):void
		{
			bak=zb.clone();
			var zimage:String=zb.readUTF();
			boundingBox.x=zb.readZint();
			boundingBox.y=zb.readZint();
			boundingBox.width=zb.readZint();
			boundingBox.height=zb.readZint();
			
//			tiny.fromBytes(zb.readBytes_());
//			large.fromBytes(zb.readBytes_());
			
			checkZ();
			onLoaded.dispatch();
		}
		
		public function toBytes():ZintBuffer
		{
			return bak;
		}
		
		public function get imageRenderer():ZrendererI{
			return super.renderer as ZrendererI;
		}
		
		override protected function set zUpInternal(value:Number):void{
			clear();
			super.zUpInternal=value;
			checkZ(); 
		}
		
		private function checkZ():void{
			var value:int=zUpInternal;
			large.zUp=value;
			tiny.zUp=value-large.layerCount;				
			if(value<large.layerCount){
				op=large;
			}else if((value-large.layerCount)<tiny.layerCount){
				op=tiny;
			}else{
				op=null;
			}
			look_();
		}
		
		override protected function look_():void{
			
			if(op==null)
				return;
			
			var view:Rectangle=viewGlobal;
			//on the current layer
			var box:Rectangle=boundingBox.clone();
			box.x=(box.x+xGlobal)>>zUpInternal;
			box.y=(box.y+yGlobal)>>zUpInternal;
			box.width=box.width>>zUpInternal;
			box.height=box.height>>zUpInternal;
			//			trace();
			//			trace("viewGlobal:  "+view);
			//			trace("boundingBox: "+box);
			
			if(view.intersects(box)){
				//				trace("in visual");
				inVisual=true;
				
				view.x-=parent.xGlobal>>zUpInternal;
				view.y-=parent.yGlobal>>zUpInternal;
				
				op.look(view);
			}else if(inVisual){
				//				trace("out of visual");
				inVisual=false;
				op.clear();
			}
		}
		
		public function clear():void{
//			tiny.clear();
//			large.clear();
		}
	}
}