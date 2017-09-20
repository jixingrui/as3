package maze
{
	import azura.avalon.zbase.bus.RoadMap;
	import azura.avalon.zbase.bus.WayFinder2;
	import azura.banshee.engine.starling_away.StarlingAtf2;
	import azura.banshee.zbox3.Zspace3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.collection.ZboxLine3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.engine.Zbox3ReplicaStarling;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zbox3.zebra.zmask.Zmask2;
	import azura.banshee.zbox3.zebra.zmask.ZmaskC3;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.pathfinding.PathFinder;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Bound;
	import azura.common.graphics.Draw;
	
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import maze.control.Clicker;
	import maze.tween.AngleStrider;
	import maze.tween.TweenPoint;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Sprite;
	
	public class GameDisplay
	{		
		private static var viewDist:int=100;
		
		//map display
		public var spaceGround:Zspace3;
		public var landLayer:Zbox3Container;
		public var landImage:ZebraC3;		
		public var zmask:Zmask2;
		public var groundLayer:ZmaskC3;
		
		public var spaceUI:Zspace3;
		public var uiLayer:Zbox3Container;
		
		//data
		public var rmWalk:RoadMap;
		public var bound:Bound=new Bound();
		
		public var onGoAlong:Signal=new Signal(Vector.<Point>);
		public var onSpeak:Signal=new Signal(ByteArray);
		
		public var wayFinder:WayFinder2;
		
		//navigation
		public var lookSpeed:int=0;
		public var walkSpeed:int=0;		
		
		
		public var tpView:TweenPoint=new TweenPoint();
		
		private var _hero:Char;
		
		public var front:Point=new Point();
		
		public var vDest:Point=new Point();
		
		private var clicker:Clicker;
		private var clickEnabled_:Boolean=false;
		
		public var id_Char:Dictionary=new Dictionary();
				
		public function GameDisplay()
		{
			tpView.onStep.add(look);
		}
		
		public function get hero():Char
		{
			return _hero;
		}

		public function set hero(value:Char):void
		{
			_hero = value;
			value.onMoveTick.add(heroMoved);
		}

		public function set clickEnabled(value:Boolean):void{
			if(clickEnabled_==value)
				return;
			clickEnabled_=value;
			if(value){
				uiLayer.zbox.addGesture(clicker);
			}else{
				uiLayer.zbox.removeGesture(clicker);
			}
		}
		
		public function heroMoved():void{
//			trace("hero moved",this);

			if(hero.asWalk==null){
				var angle:int=hero.actor.zbox.angle;
				front=FastMath.angle2Xy(angle,viewDist);
			}
			
			var dx:Number=front.x+hero.body.x;
			var dy:Number=front.y+hero.body.y;
			dx=(dx+spaceGround.xView)/2;
			dy=(dy+spaceGround.yView)/2;
			
			tpView.go(spaceGround.xView,spaceGround.yView,dx,dy);
		}
		
		//======== look =================
		public function look(x:Number,y:Number):void{
			if(spaceGround.xView==x&&spaceGround.yView==y)
				return;
			
			var wish:Point=new Point(x,y);
			var v:Point=bound.restrict(wish);
			spaceGround.look(v.x,v.y);
		}
		
		//========= walk =========
		
//		public function walkTowardsOld(x:Number,y:Number):void{
//			
//			front=new Point(x,y);
//			
//			var dx:Number=front.x+spaceGround.xView-hero.body.x;
//			var dy:Number=front.y+spaceGround.yView-hero.body.y;
//			
//			var normal:Point=FastMath.isoToNormal(dx,dy);
//			var angle:int=FastMath.xy2Angle(normal.x,normal.y);
//			
//			hero.actor.zbox.angle=angle;
//			hero.playAnim("go");
//			
//			if(hero.asWalk==null){
//				hero.asWalk=new AngleStrider(angle,walkSpeed);
//			}else{
//				var diff:int=Math.abs(hero.asWalk.angle-angle);
//				if(diff>=1){
//					hero.asWalk=new AngleStrider(angle,walkSpeed);	
//				}
//			}
//		}
		
//		public function walkTowards(x:Number,y:Number):void{
//			var xt:Number=x+spaceGround.xView;
//			var yt:Number=y+spaceGround.yView;
//			
//			var startPoint:Point=hero.body;
//			var endPoint:Point=new Point(xt,yt);
//			
//			var path:Vector.<Point>=new Vector.<Point>();
////			path.push(startPoint);
//			path.push(endPoint);
//			goAlong(path);
//		}
		
		public function goAlong(path:Vector.<Point>):void{
			onGoAlong.dispatch(path);
//			hero.goAlong(path);
		}
		
		//================== map ==================
		
		public function init(stage:Stage,root:Sprite):void
		{
			var replica:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(root);
			spaceGround=new Zspace3(replica);		
			landLayer=new Zbox3Container(spaceGround);
			
			landImage=new ZebraC3(landLayer.zbox);
			groundLayer=new ZmaskC3(spaceGround);
			
			spaceUI=new Zspace3(new Zbox3ReplicaStarling(root));
			uiLayer=new Zbox3Container(spaceUI);
//			spaceUI.addGesture(new Dragger(this));
			
			resize(stage.stageWidth,stage.stageHeight);			
		}
		
		public function initHero(char:Char):void{
			hero=char;
			hero.onMoveTick.add(heroMoved);
		}
		
		public function resize(w:int,h:int):void{
			spaceGround.look(0,0,w,h);
			spaceUI.look(0,0,w,h);
			uiLayer.zbox.width=w;
			uiLayer.zbox.height=h;
			
			bound.visualW=w;
			bound.visualH=h;
		}
		
		public function showLand(mc5:String):void{
			landImage.feedMc5(mc5);
			bound.landW=landImage.zebra.boundingBox.width;
			bound.landH=landImage.zebra.boundingBox.height;
			
			StarlingAtf2.syncMode=true;
			setTimeout(enableAsync,1000);
			function enableAsync():void{
				StarlingAtf2.syncMode=false;
			}
		}
		
		public function initBase(wb:ZintBuffer):void{
			rmWalk=new RoadMap();
			rmWalk.fromBytes(wb);
			wayFinder=new WayFinder2(rmWalk);
			clicker=new Clicker(this);
			clickEnabled=true;
//			uiLayer.zbox.addGesture(new Clicker(this));
		}
				
		//=========== draw ===============		
		public function drawPath(path:Vector.<Point>):void{
			clearCross();
			for (var i:int=0;i<path.length-1;i++){
				var line:ZboxLine3=new ZboxLine3(landLayer.zbox);
				line.paint(0xffff0000,2);
				line.draw(path[i].x,path[i].y,path[i+1].x,path[i+1].y);
				crossList.push(line);
			}
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
		
	}
}