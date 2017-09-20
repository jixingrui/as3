package
{
	import assets.Config_Ice;
	
	import azura.common.util.Fork;
	import azura.ice.service.Connection;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import maze.GameDisplay;
	import maze.ClientManager;
	
	[SWF(frameRate="60")]
	public class ZombieShooter extends Sprite
	{
		private var config:Config_Ice;
		private var shell:ClientManager=new ClientManager();
		private var conn:Connection;
		private var fork:Fork=new Fork(onForkReady,"ice","image");
		
		public function ZombieShooter()
		{
			addShutdownHook();
			setScreenSize();
			addChild(shell);
			
			config=new Config_Ice();
			config.onReady.addOnce(configLoaded);			
		}
		
		private function configLoaded():void{
			conn=new Connection(config);
			conn.onIceReady.add(iceReady);
			conn.connect();
			
			shell.configReady(config);
			shell.onEnterRoomClient.add(enterRoom);
		}
		
		public function iceReady():void{
			fork.ready("ice");
		}
		
		private var roomUID:String;
		public function enterRoom(uid:String):void{
			this.roomUID=uid;
			fork.ready("image");
		}
		
		private function onForkReady():void{
			conn.ice.enterRoom(roomUID);
		}
		
		//============= setup =============
		private function addShutdownHook():void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			function keyDown(ke:KeyboardEvent):void{
				if(ke.keyCode==Keyboard.ESCAPE){
					NativeApplication.nativeApplication.exit();
				}
			}
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