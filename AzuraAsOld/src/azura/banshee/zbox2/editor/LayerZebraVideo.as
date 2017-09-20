package azura.banshee.zbox2.editor
{
	import azura.banshee.zbox2.zebra.Zvideo;
	
	import flash.filesystem.File;
	
	public class LayerZebraVideo
	{
		public var ec:EditorCanvas;
		public var video:Zvideo;
//		public var player:Image;
		
//		private var _netConnection:NetConnection;
//		private var _netStream:NetStream;
//		private var _texture:Texture;
		
		public function activate(ec:EditorCanvas):void
		{
			this.ec=ec;
			
			video=new Zvideo(ec.space);
//			video.
			
//			_netConnection = new NetConnection();
//			_netConnection.connect(null);
//			_netStream = new NetStream(_netConnection);
//			_netStream.client=new NsClientSilent();
//			Texture.fromNetStream(_netStream, 1, function(texture:Texture):void
//			{
//				_texture=texture;
//				player=new Image(texture);
//				ec.starling.root.addChild(player);
//			});
		}
		
		public function showVideo(file:File):void{
			video.play(file.nativePath);
//			_netStream.play(file.nativePath);
			
//			var data:ZintBuffer=FileUtil.read(file);
//			_netStream.play(null);
//			_netStream.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
//			_netStream.appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN);
//			_netStream.appendBytes(data);
		}
		
//		private function onNetStatus(event:NetStatusEvent):void{
//			trace(event.info,this);
//		}
		
		public function deactivate():void{
//			player.dispose();
//			ec.starling.root.removeChild(player);
//			player=null;
			//			actor.zbox.dispose();
			//			ec.space.view.removeGesture(rotator);
		}
		
	}
}