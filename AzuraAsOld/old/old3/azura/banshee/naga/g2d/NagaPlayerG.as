package old.azura.banshee.naga.g2d
{
	import azura.banshee.loaders.g2d.FrameLoaderG;
	import old.azura.banshee.naga.Frame;
	import old.azura.banshee.naga.NagaPlayer;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.osflash.signals.Signal;
	
	public class NagaPlayerG extends NagaPlayer
	{
		private static var empty:GTexture=GTextureFactory.createFromBitmapData("empty",new BitmapData(4,4,true,0xffff0000));//GTextureFactory.createFromColor('empty',0,1,1);
		
		private var loader:FrameLoaderG;
		public var image:FrameImageG;
		
		//		public var ed:EventDispatcher=new EventDispatcher();
		
		private var _onFrameReady:Signal=new Signal();
		
		public function NagaPlayerG()
		{
			super();
			image=new FrameImageG();
		}
		
		public function onClick(ret:Function):void{
			image.sprite.node.mouseEnabled=true;
			image.sprite.node.onMouseDown.add(ret);
		}
		
		public function get onFrameReady():Signal
		{
			return _onFrameReady;
		}
		
		override public function updateTexture():void{
			if(_source==null){
				image.sprite.texture=empty;
				return;
			}
			
			if(loader!=null)
			{
				loader.release(30000);//=============================
			}
			var f:Frame=_source.getFrame(currentRow,currentFrameIdx);
			new FrameLoaderG(f).load(loaded);
			function loaded(fl:FrameLoaderG):void{
				
				//				var tex:GTexture=GTexture(fl.value);
				//				trace("frame loaded: "+tex.getId());
				fl.hold();
				
				image.sprite.texture=fl.value;
				image.currentFrame=f;
				//				ed.dispatchEvent(new Event(Event.FRAME_CONSTRUCTED));
				loader=fl; 
				
				onFrameReady.dispatch();
				
			}
		}
		
		override public function jumpTo(x:int,y:int,h:int):void{
			image.xFoot=x;
			image.yFoot=y-h;
			image.depthFoot=y-h;
		}
		
		override public function dispose():void{
			super.dispose();
			onFrameReady.removeAll();
			if(image.sprite.node!=null && image.sprite.node.parent!=null)
				image.sprite.node.parent.removeChild(image.sprite.node);
			if(loader!=null){
				loader.release(40000);
				loader=null;
			}
		}
	}
}