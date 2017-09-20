package azura.banshee.mass.model.v3
{
	import azura.banshee.zbox3.Zbox3;
	import azura.common.ui.list.motor.DragList;
	
	public class MassTreeNV3P extends MassTreeNV3
	{
		public function MassTreeNV3P(parentZbox:Zbox3, model:MassTreeN3)
		{
			super(parentZbox, model);
			if(model.box.isList)
				zbox.clip=true;
		}
		
		override protected function enableTouchList():void{
			var dragger:DragList=new DragList();
			dragger.H_V=model.box.isHlist;
			dragger.motor=MassTreeN3P(model).motor;
			zbox.addGesture(dragger);
		}
	}
}