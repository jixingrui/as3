package azura.banshee.engine.a3d
{
	import away3d.materials.utils.IVideoPlayer;
	import away3d.materials.utils.SimpleVideoPlayer;
	import away3d.textures.Texture2DBase;
	import flash.display3D.Context3D;
	import flash.display3D.textures.TextureBase;
	import flash.display3D.textures.VideoTexture;
	import flash.events.Event;
	import flash.events.VideoTextureEvent;
	import flash.media.VideoStatus;
	
	
	
	public class NativeVideoTexture extends Texture2DBase 
	{
		private var texture:flash.display3D.textures.VideoTexture;
		private var _autoPlay:Boolean;
		private var _player:IVideoPlayer;
		
		
		
		public function NativeVideoTexture(source:String, loop:Boolean = true, autoPlay:Boolean = false, player:IVideoPlayer = null) 
		{
			try
			{
				_player = player || new SimpleVideoPlayer();
				_player.loop = loop;
				_player.source = source;
				_autoPlay = autoPlay;
			}
			catch (e:Error)
			{
				trace(e, e.getStackTrace());
			}
		}
		
		
		
		override protected function uploadContent(texture:TextureBase):void 
		{
			
		}
		
		
		
		override protected function createTexture(context:Context3D):TextureBase
		{
			try
			{
				trace("Context3D.supportsVideoTexture", Context3D.supportsVideoTexture)
				
				if (!Context3D.supportsVideoTexture)
				{
					throw new Error("flash.display3D.textures.VideoTexture not supported");
					return null;
				}
				
				texture = context.createVideoTexture();
				
				//    texture.attachNetStream(_player.ns);
				//	texture.attachNetStream(_player.source);
				texture.addEventListener(Event.TEXTURE_READY, onTextureReady);
				texture.addEventListener(VideoTextureEvent.RENDER_STATE, onRenderState);
				
				if (_autoPlay) _player.play();
			}
			catch (e:Error)
			{
				trace(e, e.getStackTrace());
			}
			
			return texture;
		}
		
		
		
		private function onTextureReady(e:Event):void
		{
			dispatchEvent(e)
		}
		
		
		
		private function onRenderState(e:VideoTextureEvent):void
		{
			if (e.status == VideoStatus.SOFTWARE)
			{
				trace("Indicates software video decoding works.")
			}
			if (e.status == VideoStatus.ACCELERATED)
			{
				trace("Indicates hardware-accelerated (GPU) video decoding works.")
			}
			if (e.status == VideoStatus.UNAVAILABLE)
			{
				trace("Indicates Video decoder is not available.")
			}
		}
		
		
		
		override public function dispose():void
		{
			if (_player) _player.dispose()
			
			if (texture) texture.dispose()
			
			super.dispose();
		}
		
		
		
		public function get player():IVideoPlayer 
		{
			return _player;
		}
	}
} 