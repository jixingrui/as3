package azura.banshee.mass.trigger.v3
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.v3.ActorI;
	import azura.touch.gesture.GsingleI;
	
	public class TouchSingle implements GsingleI
	{
		public var action:MassAction;
		public var actor:ActorI;
		
		public function singleClick(x:Number, y:Number):Boolean
		{
			actor.act(action,true);
			action.host.tree.showVisible();
//			action.host.parent.showVisible();
			return true;
		}
	}
}