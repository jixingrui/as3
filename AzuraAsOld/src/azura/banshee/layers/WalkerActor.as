package azura.banshee.layers
{
	import azura.banshee.ice.WalkerZ;
	import azura.banshee.zebra.zanimal.Zanimal;
	import azura.banshee.zebra.box.AbBoxI;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.algorithm.pathfinding.FpsWalkerOld;
	
	public class WalkerActor implements MotorI,AbBoxI
	{
		private var _walker:WalkerZ;
		public var motor:FpsWalkerOld;
		private var _animal:Zanimal;
		public var person:Person3;
		private var stand_go:Boolean=true;
		private var changed:Boolean=true;
		
		public function WalkerActor(){
			motor=new FpsWalkerOld(this);
		}
		
		public function get priority():int
		{
			return 0;
		}
		
		public function zboxTouched():Boolean
		{
			trace("click",this);
			return true;
		}
		
//		public function registerClick():void{
//			person.observer=this;
//		}
		
		public function get animal():Zanimal
		{
			return _animal;
		}
		
		public function set animal(value:Zanimal):void
		{
			_animal = value;
			checkMotion();
		}
		
		public function get walker():WalkerZ
		{
			return _walker;
		}
		
		public function set walker(value:WalkerZ):void
		{
			_walker = value;
			turnTo(value.angle);
		}
		
		public function jumpTo(x:Number, y:Number):void
		{
			//			trace("jump to",x,y,this);
			person.move(x,y);
		}
		
		public function turnTo(angle:int):int
		{
			walker.angle=angle;
			if(animal!=null)
				person.body.angle=angle;
			return angle;
		}
		
		public function stop():void
		{
			if(stand_go==false){
				stand_go=true;
				changed=true;				
			}
			checkMotion();
		}
		
		public function go():void
		{
			if(stand_go){
				stand_go=false;
				changed=true;
			}
			checkMotion();
		}
		
		private function checkMotion():void{
			if(animal!=null && changed){
				changed=false;
				if(stand_go)
					person.body.zebra=animal.getZebra("stand");
				else
					person.body.zebra=animal.getZebra("walk");
			}
			person.body.angle=walker.angle;				
		}
	}
}