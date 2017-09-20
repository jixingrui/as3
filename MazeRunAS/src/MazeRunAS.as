package
{
	import assets.Config_Ice;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import maze.ClientManager;
	
	[SWF(frameRate="60")]
	public class MazeRunAS extends Sprite
	{
		private var config:Config_Ice;
		private var shell:ClientManager=new ClientManager();
		public function MazeRunAS()
		{
			addShutdownHook();
			setScreenSizeFull();
			addChild(shell);
			
			config=new Config_Ice();
			config.onReady.addOnce(configLoaded);
		}
		
		public function configLoaded():void{
			shell.configReady(config);
		}
		
		private function addShutdownHook():void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			function keyDown(ke:KeyboardEvent):void{
				if(ke.keyCode==Keyboard.ESCAPE){
					NativeApplication.nativeApplication.exit();
				}
			}
		}
		
		private function setScreenSizeFull():void{
			stage.nativeWindow.width=Capabilities.screenResolutionX;
			stage.nativeWindow.height=Capabilities.screenResolutionY;
			stage.nativeWindow.x=0;
			stage.nativeWindow.y=0;
		}
		
		private function setScreenSize():void{
			var w:int=Capabilities.screenResolutionX*0.8;
			var h:int=Capabilities.screenResolutionY*0.8;
			stage.nativeWindow.width=w;
			stage.nativeWindow.height=h;
			stage.nativeWindow.x=0;
			stage.nativeWindow.y=0;
			//			stage.nativeWindow.y=Capabilities.screenResolutionY*0.05;
		}
	}
}