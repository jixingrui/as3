package azura.banshee.mass.trigger
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;
	import azura.touch.gesture.GhoverI;
	
	public class TouchHover implements GhoverI
	{
		public var action:MassAction;
		public var from:MassTreeN;
		
		public function hover():Boolean
		{
			trace("hover",from.path,this);
//			from.act(action);
			from.tree.act(action);
			return false;
		}
		
	}
}