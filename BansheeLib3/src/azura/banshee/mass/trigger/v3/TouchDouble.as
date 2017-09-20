package azura.banshee.mass.trigger.v3
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.v3.ActorI;
	import azura.touch.gesture.GdoubleI;
	
	public class TouchDouble implements GdoubleI
	{
		public var actor:ActorI;
		public var action:MassAction;
		
		public function doubleClick():Boolean
		{
			actor.act(action,true);
			action.host.tree.showVisible();
			//			action.host.parent.showVisible();
			return false;
		}
	}
}