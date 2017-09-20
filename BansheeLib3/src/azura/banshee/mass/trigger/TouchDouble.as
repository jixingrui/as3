package azura.banshee.mass.trigger
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;
	import azura.touch.gesture.GdoubleI;
	
	public class TouchDouble implements GdoubleI
	{
		public var action:MassAction;
		public var from:MassTreeN;
		
		public function doubleClick():Boolean
		{
//			trace("double",node.model.path,this);
//			from.act(action);
			from.tree.act(action);
			return false;
		}
	}
}