package maze
{
	import azura.banshee.animal.GalPack5;
	import azura.banshee.animal.Zanimal4;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.mover.EnterFrame;
	import azura.common.algorithm.mover.EnterFrameI;
	import azura.common.algorithm.mover.MotorI;
	
	import flash.geom.Point;
	import flash.net.dns.AAAARecord;
	import flash.utils.Dictionary;
	
	import maze.control.CharClicker;
	import maze.tween.AngleStrider;
	
	import org.osflash.signals.Signal;
	
	public class Char implements EnterFrameI,MotorI
	{
		public static var mc5_Zanimal4:Dictionary=new Dictionary();
		
		public var mc5:String;
		public var animal:Zanimal4;
		
		public var actor:ZebraC3;
		
		public var body:Point=new Point();
		private var _asWalk:AngleStrider;
		
		public var canvas:GameDisplay;
		
		public var onMoveTick:Signal=new Signal();
		
		public var motor:FpsWalker3;
		
		private var nextMotion:String;
		public var playingMotion:String;
		
		public var isHero:Boolean;
		
		public var id:int;
		
		public var now_cycle_stop:int;
		
		public function Char(canvas:GameDisplay)
		{
			this.canvas=canvas;
			actor=new ZebraC3(canvas.groundLayer.zbox);
			actor.zbox.addGesture(new CharClicker());
			actor.onCycleEnd.add(cycleEnd);
			EnterFrame.addListener(this);
			motor=new FpsWalker3(this);
		}
		
		public function get asWalk():AngleStrider
		{
			return _asWalk;
		}
		
		public function set asWalk(value:AngleStrider):void
		{
			_asWalk = value;
			if(value==null){
				motor.stop();
				motor.jumpStart(motor.currentPoint.x,motor.currentPoint.y);
			}
		}
		
		public function enterFrame():void{
			//			trace(motor.pathLength,this);
			if(asWalk==null)
				return;
			var next:Point=asWalk.next();
			bodyAt(next.x+body.x,next.y+body.y);
		}
		
		public function jumpStart(x:Number,y:Number):void{
			motor.jumpStart(x,y);
		}
		
		public function bodyAt(x:Number,y:Number):void{
			
			body.x=x;
			body.y=y;
			
			actor.zbox.sortValue=y;
			actor.zbox.move(x,y);
			
			onMoveTick.dispatch();
		}
		
		public function stopWalking():void{
			asWalk=null;
		}
		
		public function set mc5Animal(mc5:String):void{
			this.mc5=mc5;
			animal=mc5_Zanimal4[mc5];
			if(animal==null)
				throw new Error();
		}
		
		public static function load(gp:GalPack5):void{
			var a:Zanimal4=new Zanimal4();
			a.fromPack(gp);
			mc5_Zanimal4[gp.master]=a;
		}
		
		public function restartPath(path:Vector.<Point>):void{
			motor.jumpStart(body.x,body.y);
			motor.appendPath(path);
			var dest:Point=path[0];
			var angle:int=FastMath.xy2Angle(dest.x-body.x,dest.y-body.y);
			turnTo(angle);
		}
		
		public function restartPoint(p:Point):void{
			var path:Vector.<Point>=new Vector.<Point>();
			path.push(p);
			restartPath(path);
		}
		
		public function appendPoint(p:Point):void{
			//			go();
			motor.appendPoint(p);
		}
		
		//============= MotorI ================
		public function jumpTo(x:Number, y:Number):void
		{
			bodyAt(x,y);
		}
		
		public function turnTo(angle:int):int
		{
			//			trace("turn to",angle,this);
			actor.zbox.angle=angle;
			return angle;
		}
		
		//============= anim control ================
		
		public function go():void
		{
			//			trace("go",this);
			playMotion("go",0);
		}
		
		public function stop():void
		{
			//			trace("stop",this);
			if(playingMotion=="go"&&nextMotion==null)
				playMotion("stand",2);
			playNext(2);
		}
		
		public function cycleEnd():void{
			playNext(1);
		}
		
		public function playMotion(actionName:String, now_cycle_stop:int):void{
			//			trace("play motion",actionName,now_cycle_stop,this);
			
			if(playingMotion==null)
				now_cycle_stop=0;
			this.now_cycle_stop=now_cycle_stop;
			
			if(actionName==null)
				return;
			if(playingMotion==actionName)
				return;
			
			nextMotion=actionName;
			
			playNext(0);
		}
		
		private function playNext(now_cycle_stop:int):void{
			if(nextMotion==null)
				return;
			
			if(this.now_cycle_stop!=now_cycle_stop)
				return;
			
			//			if(this.isHero)
			//				return;
			
			if(nextMotion=="die"){
				actor.loop=false;
			}else{
				actor.loop=true;
			}
			
			playingMotion=nextMotion;
			nextMotion=null;
			
			//			trace("play motion ======= ",playingMotion,this);
			var mc5:String=animal.getShape(playingMotion).master;
			var change:Boolean=actor.feedMc5(mc5);
			if(change)
				actor.restartCycle();
			
		}
	}
}