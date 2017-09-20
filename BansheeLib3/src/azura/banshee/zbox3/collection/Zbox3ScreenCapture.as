package azura.banshee.zbox3.collection
{
	import azura.banshee.engine.Statics;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.algorithm.FastMath;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.CameraRoll;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.PNGEncoder;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Stage;
	
	public class Zbox3ScreenCapture
	{		
		public var onSaved:Signal=new Signal();
		private var cr:CameraRoll;
		private var ffr:FileReference;
		
		public function saveZbox(zbox:Zbox3):void{
			var large:BitmapData=Stage(Starling.current.stage).drawToBitmapData();
			var scale:Number=zbox.scaleGlobal*zbox.space.scaleView;
			
			var cut:Rectangle=new Rectangle();
			cut.width=zbox.width*scale;
			cut.height=zbox.height*scale;
			cut.x=zbox.xGlobal-cut.width/2+Statics.stage.stageWidth/2;
			cut.y=zbox.yGlobal-cut.height/2+Statics.stage.stageHeight/2;
			var small:BitmapData=new BitmapData(cut.width,cut.height);
			small.copyPixels(large,cut,new Point(0,0));
			
			save(small);
		}
		
		private function save(bd:BitmapData):void{
			if(CameraRoll.supportsAddBitmapData){
				cr=new CameraRoll();
				cr.addEventListener(Event.COMPLETE,notifySaved);
				cr.addBitmapData(bd);
			}else{
				var enc:PNGEncoder=new PNGEncoder();
				var data:ByteArray=enc.encode(bd);
				ffr=new FileReference();
				ffr.addEventListener(Event.COMPLETE,notifySaved);
				ffr.save(data,"zexia_"+FastMath.random(0,int.MAX_VALUE)+".png");
			}
		}
		
		private function notifySaved(event:Event):void{
			if(cr!=null){
				cr.removeEventListener(Event.COMPLETE,notifySaved);
				cr=null;
			}else{
				ffr.removeEventListener(Event.COMPLETE,notifySaved);
				ffr=null;
			}
			onSaved.dispatch();
		}
	}
}