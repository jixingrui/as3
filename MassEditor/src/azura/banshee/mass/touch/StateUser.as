package azura.banshee.mass.touch
{
	import azura.banshee.mass.model.MassAction;
	import azura.touch.gesture.GhoverI;
	import azura.touch.gesture.GsingleI;
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.graphics.old.ZuiTreeNodeDisplayOld;
	
	public class StateUser implements GhoverI, GsingleI
	{
		public var display:ZuiTreeNodeDisplayOld;
		
		public function StateUser(display:ZuiTreeNodeDisplayOld){
			this.display=display;
		}
		
		public function hover():Boolean
		{
//			for each(var action:ZuiAction in display.model.actionList){
//				if(action.hover_out_select==0){
//					display.tree.changeStateId(action.targetStateId);
//				}
//			}
			return false;
		}
		
		public function out():Boolean
		{
//			for each(var action:ZuiAction in display.model.actionList){
//				if(action.hover_out_select==1){
//					display.tree.changeStateId(action.targetStateId);
//				}
//			}
			return false;
		}
		
		public function singleClick(x:Number,y:Number):Boolean{
//			for each(var action:ZuiAction in display.model.actionList){
//				if(action.hover_out_select==2){
//					display.tree.changeStateId(action.targetStateId);
//				}
//			}
//			trace("select",x,y,this);
			return false;
		}
	}
}