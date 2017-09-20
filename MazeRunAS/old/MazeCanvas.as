package maze
{
	import azura.avalon.zbase.bus.RoadMap;
	import azura.banshee.animal.GalPack5;
	import azura.banshee.animal.Zanimal4;
	import azura.banshee.engine.starling_away.StarlingAtf2;
	import azura.banshee.zbox3.Zspace3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.collection.ZboxLine3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.engine.Zbox3ReplicaStarling;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.mover.EnterFrame;
	import azura.common.algorithm.mover.EnterFrameI;
	import azura.common.algorithm.pathfinding.BhStrider;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	import azura.gallerid4.Gal4;
	import azura.karma.run.Karma;
	import azura.maze4.service.MazePack;
	import azura.maze4.service.WooPack;
	
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import maze.util.AngleStrider;
	import maze.util.Bound;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Sprite;
	
	import zmask.ZmaskC3;
	import zmask.data.Zmask2;
	
	import zz.karma.Maze.Room.K_Base;
	
	public class MazeCanvas implements EnterFrameI
	{
		public var onEnterRoomClient:Signal=new Signal(String);
		public var onBaseReady:Signal=new Signal(ZintBuffer);
		
		public var lookSpeed:int=0;
		public var walkSpeed:int=0;
		
		public var spaceGround:Zspace3;
		public var landLayer:Zbox3Container;
		public var landImage:ZebraC3;
		
		public var zmask:Zmask2;
		
		//		public var groundLayer:Zbox3Container;
		public var groundLayer:ZmaskC3;
		//		private var cross:ZboxBitmap3;
		private var shooterAnimal:Zanimal4=new Zanimal4();
		private var shooter:ZebraC3;
		
		public var spaceUI:Zspace3;
		public var uiLayer:Zbox3Container;
		
		//		public var mc5Char:String;
		
		public var rmWalk:RoadMap;
		
		//navigation
		public var bound:Bound=new Bound();
		public var body:Point=new Point();
		public var asWalk:AngleStrider;
		public var front:Point=new Point();
		
		//		public var tpView:TweenPoint;
		
		public function MazeCanvas()
		{
			//			TimerRoot.register(60,this);
			EnterFrame.addListener(this);
		}
		
		public function enterFrame():void{
			if(asWalk==null)
				return;
			
			var next:Point=asWalk.next();
			bodyAt(next.x+body.x,next.y+body.y);
//			trace("body at",body.x,body.y,this);
			var sLook:BhStrider=new BhStrider(spaceGround.xView,spaceGround.yView,body.x+front.x,body.y+front.y);
			//			var dist:Number=10*(front.y*0.7+front.x)/(front.y+front.x);
			sLook.next(lookSpeed);
			look(sLook.xNow,sLook.yNow);
		}
		
		//======== look =================
		public function look(x:int,y:int):void{
			if(spaceGround.xView==x&&spaceGround.yView==y)
				return;
			
//			trace("look",x,y,this);
			var wish:Point=new Point(x,y);
			var v:Point=bound.restrict(wish);
			spaceGround.look(v.x,v.y);
		}
		
		//========= walk =========
		public function jump(x:Number,y:Number):void{
			bodyAt(x,y);
			//			look(x,y);
		}
		
		public function stopWalking():void{
			asWalk=null;
			shooter.feedMc5(shooterAnimal.getShape("stand").master);
			//			trace("stand",this);
		}
		
		public function drawPoint(p:Point,size:int):void{
			var cross:ZboxBitmap3=new ZboxBitmap3(groundLayer.zbox);
			cross.fromBitmapData(Draw.circle(size,0x0000ff));
			cross.zbox.move(p.x,p.y);
		}
		
		private var crossList:Vector.<Zbox3Container>=new Vector.<Zbox3Container>();
		public function clearCross():void{
			while(crossList.length>0){
				var cross:Zbox3Container=crossList.shift();
				cross.zbox.dispose();
			}
		}
		public function drawCross(p:Point,color:int=0xff0000):void{
			var cross:ZboxBitmap3=new ZboxBitmap3(groundLayer.zbox);
			cross.fromBitmapData(Draw.cross(10,10,3,color));
			cross.zbox.move(p.x,p.y);
			crossList.push(cross);
		}
		
		public function showPath(path:Vector.<Point>):void{
			clearCross();
			for (var i:int=0;i<path.length-1;i++){
				//				trace("path point",p.x,p.y,this);
				var line:ZboxLine3=new ZboxLine3(landLayer.zbox);
				line.paint(0xffff0000,2);
				line.draw(path[i].x,path[i].y,path[i+1].x,path[i+1].y);
				crossList.push(line);
			}
		}
		
		public function walkTowards(x:Number,y:Number):void{
			
			front.x=x;
			front.y=y;
			
			var normal:Point=FastMath.isoToNormal(x,y);
			var angle:int=FastMath.xy2Angle(normal.x,normal.y);
//			trace("mouse",x,y,"normal",normal.x,normal.y,"angle",angle,this);
			
			shooter.zbox.angle=angle;
			shooter.feedMc5(shooterAnimal.getShape("go").master);
			//			trace("go",this);
			
			if(asWalk==null){
				asWalk=new AngleStrider(angle,walkSpeed);
//				trace("angle",asWalk.angle,this);
			}else{
				var diff:int=Math.abs(asWalk.angle-angle);
				if(diff>=1){
					asWalk=new AngleStrider(angle,walkSpeed);	
//					trace("angle",asWalk.angle,this);
				}
			}
		}
		
		public function bodyAt(x:Number,y:Number):void{
			
			if(rmWalk!=null && rmWalk.base.isRoad(x,y)==false){
				//				trace("hit wall",this);
				stopWalking();
				return;
			}
			
			//			cross.zbox.x=x;
			//			cross.zbox.y=y;
			
			//			shooter.zbox.x=x;
			//			shooter.zbox.y=y;
			shooter.zbox.sortValue=y;
			shooter.zbox.move(x,y);
			
			body.x=x;
			body.y=y;
			
			
		}
		//================== map ==================
		
		public function init(stage:Stage,root:Sprite):void
		{
			var replica:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(root);
			spaceGround=new Zspace3(replica);		
			landLayer=new Zbox3Container(spaceGround);
			landImage=new ZebraC3(landLayer.zbox);
			//			groundLayer=new Zbox3Container(spaceGround);
			groundLayer=new ZmaskC3(spaceGround);
			//			spaceGround.addGesture(new Clicker(this));
			
			spaceUI=new Zspace3(new Zbox3ReplicaStarling(root));
			uiLayer=new Zbox3Container(spaceUI);
			spaceUI.addGesture(new Dragger(this));
			
			resize(stage.stageWidth,stage.stageHeight);
			
		}
		
		public function resize(w:int,h:int):void{
			spaceGround.look(0,0,w,h);
			spaceUI.look(0,0,w,h);
			uiLayer.zbox.width=w;
			uiLayer.zbox.height=h;
			
			bound.visualW=w;
			bound.visualH=h;
		}
		
		public function loadChar(pack:GalPack5):void{
			shooterAnimal.fromPack(pack);
		}
		
		public function loadMaze(zb:ZintBuffer):void{
			var mp:MazePack=new MazePack();
			mp.fromBytes(zb);
			
			var woo:WooPack = mp.tagToWoo("entry");
			
			onEnterRoomClient.dispatch(woo.room.kr.name);
			
			var gp:GalPack5=new GalPack5().fromIndex(woo.room.kr.groundImage);
			landImage.onDisplay.add(onDisplay);
			landImage.feedMc5(gp.master);
			trace("map image size",landImage.zebra.boundingBox.width,landImage.zebra.boundingBox.height,this);
			
			bound.landW=landImage.zebra.boundingBox.width;
			bound.landH=landImage.zebra.boundingBox.height;
			
			//			cross=new ZboxBitmap3(groundLayer.zbox);
			shooter=new ZebraC3(groundLayer.zbox);
			var mc5:String=shooterAnimal.getShape("stand").master;
			shooter.feedMc5(mc5);
			bodyAt(woo.woo.x,woo.woo.y);
			spaceGround.look(woo.woo.x,woo.woo.y);
			
			var gpMask:GalPack5=new GalPack5().fromIndex(woo.room.kr.mask);
			var maskData:ZintBuffer=Gal4.readSync(gpMask.master);
			maskData.uncompress();
			var zm:Zmask2=new Zmask2();
			zm.fromBytes(maskData);
			groundLayer.data=zm;
			
			//			groundLayer.zbox.no
			
			function onDisplay():void{
				//				StarlingAtf2.syncMode=false;
				//				cross.fromBitmapData(Draw.cross(10,10));
				//				landImage.zbox.visible=false;
			}
			
			var name_base:Dictionary=new Dictionary();
			for each(var kb:Karma in woo.room.kr.baseList.getList()){
				var b:K_Base =new K_Base(MazePack.ksMaze);
				b.fromKarma(kb);
				name_base[b.name]=b.zbase;
			}
			
			var wb:ZintBuffer=name_base["walk"];
			if(wb==null)
				throw new Error();
			rmWalk=new RoadMap();
			rmWalk.fromBytes(wb.clone());
			
			onBaseReady.dispatch(wb);
			//			var shift:int=rmWalk.base.shrinkZ;
			//			for each(var g:NodeGroup in rmWalk.bus.groupList){
			//				for each(var w:WayDot45 in g.list){
			//					var p:Point=new Point();
			//					p.x=w.x<<shift;
			//					p.y=w.y<<shift;
			//					var size:int=4;
			//					if(w.type==GeoType.Junction)
			//						size=5;
			//					else if(w.type==GeoType.Tarminal)
			//						size=6;
			//					else if(w.type==GeoType.BottleNeck)
			//						size=4;
			//					drawPoint(p,size);
			//				}
			//			}
			
			spaceGround.addGesture(new Clicker(this));
			//			trace("walk range",rmWalk.base.width,rmWalk.base.height,this);
			
			setTimeout(enableAsync,1000);
		}
		
		private function enableAsync():void{
			StarlingAtf2.syncMode=false;
		}
	}
}