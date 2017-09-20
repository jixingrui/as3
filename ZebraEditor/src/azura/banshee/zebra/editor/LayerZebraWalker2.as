package azura.banshee.zebra.editor
{
	import azura.banshee.zbox3.editor.EditorCanvas3;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.Zebra3;
	import azura.common.algorithm.mover.MotorI;
	import azura.touch.gesture.GmoveI;
	import azura.touch.gesture.GsingleI;
	
	import com.greensock.TweenMax;
	import azura.banshee.zbox3.editor.dish.MotorByFpsFast;
	
	public class LayerZebraWalker2 implements GsingleI,GmoveI,MotorI
	{
		public var ec:EditorCanvas3;
		public var map:ZebraC3;
		public var x:Number=0;
		public var y:Number=0;
		private var motor:MotorByFpsFast;
		
		private var tween:TweenMax;
		private var stop:Boolean=true;
		
		public function LayerZebraWalker2(){
			motor=new MotorByFpsFast(this);
		}
		
		public function activate(ec:EditorCanvas3):void
		{
			this.ec=ec;
			map=new ZebraC3(ec.space);
			ec.space.addGesture(this);
		}
		
		public function handMove(x:Number, y:Number):void
		{
			if(stop)
				return;
			motor.goTo(x,y);
		}
		
		public function singleClick(x:Number, y:Number):Boolean
		{
			stop=!stop;
			return false;
		}
		
		private function tweenTo(x:Number,y:Number):void{
			kill();
			tween=TweenMax.to(this,1,{x:x,y:y,onUpdate:update});
		}
		
		private function kill():void{
			if(tween!=null){
				tween.kill();
				tween=null;
			}
		}
		
		public function update():void{
			motor.goTo(x,y);
		}
		
		public function jumpTo(x:Number, y:Number):void
		{
			if(ec!=null)
				ec.space.look(x,y);
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
		
		public function clear():void{
			map.zbox.clear();
		}
		
		public function showZebra(zebra:Zebra3):void{
			map.zbox.move(0,0);
			map.feedZebra(zebra);
		}
		
		public function deactivate():void{
			ec.ruler.zbox.visible=true;
			ec.space.removeGesture(this);
			map.zbox.dispose();
			ec.space.look(0,0);
		}
		
	}
}