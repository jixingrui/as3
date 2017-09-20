package azura.banshee.zbox3
{
	import azura.banshee.zbox3.container.Zbox3ControllerI;

	public class Zbox3 extends Zbox3Scale
	{
		public function Zbox3(key:PrivateLock, parent:Zbox3)
		{
			super(key, parent);
		}
		
		public function get parent():Zbox3{
			return super.parent_ as Zbox3;
		}
		
		private function getChildList():Vector.<Zbox3ControllerI>{
			var result:Vector.<Zbox3ControllerI>=new Vector.<Zbox3ControllerI>();
			for each(var c:Zbox3 in childList){
				result.push(c.controller);
			}
			return result;
		}
		
		override public function newChild():Zbox3{
			return new Zbox3(space.key,this);
		}
	}
}