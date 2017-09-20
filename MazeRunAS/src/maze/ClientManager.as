package maze
{
	import assets.Config_Ice;
	
	import azura.avalon.zbase.bus.RoadMap;
	import azura.banshee.animal.GalPack5;
	import azura.banshee.engine.Statics;
	import azura.banshee.engine.starling_away.StarlingAway;
	import azura.banshee.engine.starling_away.StarlingLayer;
	import azura.banshee.zbox3.zebra.zmask.Zmask2;
	import azura.common.collections.ZintBuffer;
	import azura.common.loaders.FileLoader;
	import azura.common.util.Fork;
	import azura.gallerid4.Gal4;
	import azura.karma.def.KarmaSpace;
	import azura.karma.run.Karma;
	import azura.maze4.service.MazePack;
	import azura.maze4.service.WooPack;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	import zz.karma.Maze.Room.K_Base;
	
	public class ClientManager extends Sprite
	{
		public var config:Config_Ice;
		public var canvas:GameDisplay;
		
		public var id_Char:Dictionary=new Dictionary();
		
		public var idSelf:int;
		
		private var fork:Fork=new Fork(forkReady,"graphics","config");
		
		public var onEnterRoomClient:Signal=new Signal(String);
		//		public var onBaseReady:Signal=new Signal(ZintBuffer);
		
		public var mazeData:ZintBuffer;
		
		public var mc5Zombie1:String;
		public var mc5Shooter1:String;
		public var mc5Zombie2:String;
		public var mc5Shooter2:String;
		
		public var shooterPosList:Vector.<WooPack>;
		public var zombiePosList:Vector.<WooPack>;
		
		public function ClientManager()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void{
			Statics.stage=stage;
			StarlingAway.init(stage,this,stage3DLoaded);
		}
		
		private function stage3DLoaded():void{
			StarlingAway.addStarlingLayer(layerLoaded);
		}			
		
		private function layerLoaded(sl:StarlingLayer):void{
			canvas=new GameDisplay();
			canvas.init(stage,sl.root);
			fork.ready("graphics");
		}
		
		public function configReady(config:Config_Ice):void{
			this.config=config;
			fork.ready("config");
		}
		
		private function forkReady():void{
			loadKarma();
			canvas.walkSpeed=config.speedShooter;
			canvas.lookSpeed=config.speedShooter+1;
		}
		
		private function loadKarma():void{
			FileLoader.load(config.karma,onKarmaReady);
			function onKarmaReady(ba:ByteArray):void{
				var zb:ZintBuffer=new ZintBuffer(ba);
				var ks:KarmaSpace=new KarmaSpace();
				ks.fromBytes(zb);
				MazePack.ksMaze=ks;
				
				loadCharAll();
			}
		}
		
		private function loadCharAll():void{
			
			mc5Zombie1=loadChar(config.zombie1);
			mc5Shooter1=loadChar(config.shooter1);
			mc5Zombie2=loadChar(config.zombie2);
			mc5Shooter2=loadChar(config.shooter2);
			
			//			var char:Char=newChar(mc5Shooter);	
			//			canvas.initHero(char);
			
			loadMaze();
		}
		
		public function newChar(id:int,mc5Animal:String):Char{
			var char:Char=new Char(canvas);
			char.mc5Animal=mc5Animal;		
			id_Char[id]=char;
			return char;
		}
		
		private function loadChar(url:String):String{
			var file:File=File.applicationDirectory.resolvePath(url);
			var cp:GalPack5=new GalPack5().fromPack(file);			
			Char.load(cp);
			return cp.master;
		}
		
		private function loadMaze():void{
			var file:File=File.applicationDirectory.resolvePath(config.maze);
			var master:String=new GalPack5().fromPack(file).master;
			mazeData=Gal4.readSync(master);
			
			var mp:MazePack=new MazePack();
			mp.fromBytes(mazeData);
			
			//			 shooterWoo = mp.tagToWoo("shooterStart");
			shooterPosList=new Vector.<WooPack>();
			for (var ws:* in mp.tagToWoo("shooterStart")){
				shooterPosList.push(ws);
			}
			zombiePosList=new Vector.<WooPack>();
			for (var wz:* in mp.tagToWoo("zombieStart")){
				zombiePosList.push(wz);
			}
			//			 zombieWoo=mp.tagToWoo("zombieStart");
			
			var shooterWoo:WooPack=shooterPosList[0];
			var gp:GalPack5=new GalPack5().fromIndex(shooterWoo.room.kr.groundImage);
			canvas.showLand(gp.master);
			
			canvas.spaceGround.look(shooterWoo.woo.x,shooterWoo.woo.y);
			//			canvas.hero.actor.zbox.angle=shooterWoo.woo.angle;
			//			canvas.hero.bodyAt(shooterWoo.woo.x,shooterWoo.woo.y);
			//			canvas.hero.playAnim("stand");
			
			var gpMask:GalPack5=new GalPack5().fromIndex(shooterWoo.room.kr.mask);
			var maskData:ZintBuffer=Gal4.readSync(gpMask.master);
			maskData.uncompress();
			var zm:Zmask2=new Zmask2();
			zm.fromBytes(maskData);
			canvas.groundLayer.data=zm;
			
			
			var name_base:Dictionary=new Dictionary();
			for each(var kb:Karma in shooterWoo.room.kr.baseList.getList()){
				var b:K_Base =new K_Base(MazePack.ksMaze);
				b.fromKarma(kb);
				name_base[b.name]=b.zbase;
			}
			
			var wb:ZintBuffer=name_base["walk"];
			if(wb==null)
				throw new Error();
			
			canvas.initBase(wb.clone());
			
			onEnterRoomClient.dispatch(shooterWoo.room.kr.name);
			//			onBaseReady.dispatch(wb);
			
		}
	}
}