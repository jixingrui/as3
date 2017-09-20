package zexia.common.pano
{
	import azura.common.algorithm.FastMath;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.CameraRoll;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.PNGEncoder;
	
	import zexia.common.AlertImage;
	
	public class ImageSaver
	{		
		private var cr:CameraRoll;
		private var alertSave:AlertImage;
		
		public function save(bd:BitmapData):void{
			if(CameraRoll.supportsAddBitmapData){
				if(cr==null)
					cr=new CameraRoll();
				cr.addEventListener(Event.COMPLETE,onSaved);
				cr.addBitmapData(bd);
			}else{
				var enc:PNGEncoder=new PNGEncoder();
				var data:ByteArray=enc.encode(bd);
				var ffr:FileReference=new FileReference();
				ffr.addEventListener(Event.COMPLETE,onSaved);
				ffr.save(data,"zexia_"+FastMath.random(0,int.MAX_VALUE)+".png");
			}
		}
		
		private function onSaved(event:Event):void{
			alertSave=new AlertImage();
			if(cr!=null){
//				alertSave.url="zzz/common/save/savedToAlbum.png";
				alertSave.url="zzz/p1p3/save/saved.png";
				cr.removeEventListener(Event.COMPLETE,onSaved);
			}else{
				alertSave.url="zzz/p1p3/save/saved.png";
			}
		}
	}
}