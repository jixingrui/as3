package azura.banshee.mass.trigger.v3
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.v3.ActorI;
	import azura.touch.gesture.GhoverI;
	
	public class TouchHover implements GhoverI
	{
		public var actor:ActorI;
		public var action:MassAction;
		
		public function hover():Boolean
		{
			actor.act(action,true);
			action.host.tree.showVisible();
			//			action.host.parent.showVisible();
			return false;
		}
		
	}
}