package azura.banshee.zebra.editor
{
	import azura.banshee.zbox2.editor.EditorCanvas;
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.common.algorithm.mover.FPS;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.algorithm.mover.TimerLevel;
	import azura.touch.gesture.GmoveI;
	import azura.touch.gesture.GsingleI;
	
	import com.greensock.TweenMax;
	
	import flash.geom.Point;
	
	public class LayerZebraWalker implements GsingleI,GmoveI,MotorI
	{
		public var ec:EditorCanvas;
		public var map:ZebraC2;
		//		public var ft:TimerFps;
		
		private var motor:MotorByFps2;
		
		public var personX:Number=0;
		public var personY:Number=0;
		
		public function LayerZebraWalker(){
			motor=new MotorByFps2(this);
		}
		
//		private var _x:Number=0;
		public function get x():Number
		{
			return personX+handX;
		}
		public function set x(value:Number):void
		{
//			_x = value;
			trace("x=",x,this);
			if(ec!=null)
				ec.space.look(x,y);
		}
		
//		private var _y:Number=0;
		public function get y():Number
		{
			return personY+handY;
		}
		public function set y(value:Number):void
		{
//			_y = value;
			if(ec!=null)
				ec.space.look(x,y);
		}
		
		public function activate(ec:EditorCanvas):void
		{
			this.ec=ec;
			ec.ruler.zbox.visible=false;
			map=new ZebraC2(ec.space);
			ec.space.addGesture(this);
		}
		
		private var handX:Number=0;
		private var handY:Number=0;
		
		public function handMove(x:Number, y:Number):void
		{
			//			ec.space.look(x,y);
			handX=x;
			handY=y;
			tweenTo(personX+x,personY+y);
			//			trace(FPS.getFps(),this);
		}
		
		public function singleClick(x:Number, y:Number):Boolean
		{
			trace("click",x,y,this);
			//			tryLook(
			//			ec.space.look(x,y);
			goAlong(personX+x,personY+y);
			return false;
		}
		
		private function tweenTo(x:Number,y:Number):void{
			TweenMax.to(this,1,{x:x,y:y});
//			TweenMax.to(this,1,{y:y});
		}
		
		public function goAlong(x:Number,y:Number):void{
			var track:Vector.<Point>=new Vector.<Point>();
			var dest:Point=new Point(x,y);
			track.push(dest);
			motor.goAlong(track);
		}
		
		public function jumpTo(x:int, y:int):void
		{
			personX=x;
			personY=y;
			if(ec!=null)
			ec.space.look(x+handX,y+handY);
//			tweenTo(this.x,this.y);
			//			trace("walk to",x,y,this);
			//			tweenTo(
			//			ec.space.look(x,y);
		}
		
		public function turnTo(angle:int):int
		{
			return 0;
		}
		
		public function go():void
		{
		}
		
		public function stop():void
		{
		}
		
		public function showZebra(zebra:Zebra2Old):void{
			map.zbox.move(0,0);
			map.feed(zebra);
		}
		
		public function deactivate():void{
			ec.space.removeGesture(this);
			map.zbox.dispose();
		}
		
	}
}