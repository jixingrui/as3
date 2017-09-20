package
{
	import assets.Config_Ice;
	
	import azura.common.util.Fork;
	import azura.maze4.service.WooPack;
	import azura.zombie.service.ZombieConn;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	import maze.ClientManager;
	
	[SWF(frameRate="60")]
	public class ZombieShooter extends Sprite
	{
		private var config:Config_Ice;
		private var shell:ClientManager=new ClientManager();
		private var conn:ZombieConn;
		private var fork:Fork=new Fork(onForkReady,"ice","image");
		
		public function ZombieShooter()
		{
			addShutdownHook();
			setScreenSize100();
			addChild(shell);
			
			config=new Config_Ice();
			config.onReady.addOnce(configLoaded);			
		}
		
		private function configLoaded():void{
			conn=new ZombieConn(config);
			conn.onZombieReady.add(zombieReady);
			//			conn.connect();
			
			shell.configReady(config);
			shell.onEnterRoomClient.add(enterRoom);
			shell.canvas.onGoAlong.add(goAlongNotice);
			shell.canvas.onSpeak.add(onSpeakNotice);
		}
		
		private function goAlongNotice(path:Vector.<Point>):void{
			conn.zombie.ice.sendPath(path);
		}
		
		private function onSpeakNotice(soundData:ByteArray):void{
			conn.zombie.ice.sendPublic(soundData);
		}
		
		private function zombieReady():void{
			conn.zombie.shell=shell;
			conn.zombie.uploadMaze(shell.mazeData);
			conn.zombie.onIceReady.add(iceReady);
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
			conn.zombie.ice.enterRoom(roomUID,shell.shooterPosList[0].woo,shell.canvas.rmWalk.base.zMax+shell.canvas.rmWalk.base.shrinkZ);
			for each(var z:WooPack in shell.zombiePosList){
				//				trace("new zombie angle=",z.woo.angle,this);
				if(z.woo.name=="zombieDown")
					conn.zombie.newZombie(shell.mc5Zombie1,z.woo.x,z.woo.y,z.woo.angle);
				else if(z.woo.name=="zombieUp")
					conn.zombie.newZombie(shell.mc5Zombie2,z.woo.x,z.woo.y,z.woo.angle);
			}
			//			var z:WooPack=shell.zombiePosList[1];
			//			conn.zombie.newZombie(shell.mc5Zombie,z.woo.x,z.woo.y,z.woo.angle);
			//			conn.zombie.newZombie(shell.mc5Zombie,shell.zombieWoo.woo.x,shell.zombieWoo.woo.y,shell.zombieWoo.woo.angle);
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
		
		private function setScreenSize100():void{
			var w:int=Capabilities.screenResolutionX;
			var h:int=Capabilities.screenResolutionY;
			stage.nativeWindow.width=w;
			stage.nativeWindow.height=h;
			stage.nativeWindow.x=0;
			stage.nativeWindow.y=0;
		}
		
		private function setScreenSize80():void{
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