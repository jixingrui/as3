package azura.banshee.mass.trigger
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;
	import azura.touch.gesture.GsingleI;
	
	public class TouchSingle implements GsingleI
	{
		public var action:MassAction;
		public var from:MassTreeN;
		
		public function singleClick(x:Number, y:Number):Boolean
		{
//			trace("single",node.model.path,this);
//			from.act(action);
			from.tree.act(action);
			return true;
		}
	}
}