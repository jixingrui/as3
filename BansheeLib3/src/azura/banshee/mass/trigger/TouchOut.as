package azura.banshee.mass.trigger
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;
	import azura.touch.gesture.GoutI;
	
	public class TouchOut implements GoutI
	{
		public var action:MassAction;
		public var from:MassTreeN;
		
		public function out():Boolean
		{
			trace("out",from.path,this);
//			from.act(action);
			from.tree.act(action);
			return false;
		}
		
	}
}