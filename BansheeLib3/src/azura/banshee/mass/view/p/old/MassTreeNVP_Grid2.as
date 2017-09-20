package azura.banshee.mass.view.p.old
{
	import azura.banshee.mass.model.MassBox;
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.view.MassTreeNV2;
	import azura.banshee.mass.view.p.MassTreeNVP2;
	import azura.banshee.mass.view.p.MassTreeVP2;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.ui.grid.GridI2;
	import azura.common.ui.grid.GridMotor2;
	
	public class MassTreeNVP_Grid2 extends MassTreeNVP2 implements GridI2
	{
		
		private var motor:GridMotor2;
		private var firstChild:MassTreeNVP_GridItem2;
		
		public function MassTreeNVP_Grid2(parentZbox:Zbox3, parentNode:MassTreeNVP2, model:MassTreeN, tree:MassTreeVP2)
		{
			super(parentZbox, parentNode, model, tree);
			zbox.clip=true;
			relativePosition();
		}
				
		public function notifyChildUpdate(child:MassTreeNVP_GridItem2):void{
			if(child==firstChild){
				if(motor.width!=zbox.width||motor.height!=zbox.height){
					motor.resize(zbox.width,zbox.height,firstChild.zbox.width,firstChild.zbox.height);
				}
			}
		}
		
		override protected function newChild(childData:MassTreeN):MassTreeNV2{
			var box:MassBox=childData.box;
			if(box.isState || box.isHlist||box.isVlist||box.isDrag||box.isZoom)
				throw new Error();
			
			var newChild:MassTreeNVP_GridItem2= new MassTreeNVP_GridItem2(zbox,this,childData,tree as MassTreeVP2);
			if(firstChild==null){
				firstChild=newChild;
				var down_right:Boolean=model.box.isVlist;
				motor=new GridMotor2(this,this.zbox.width,this.zbox.height,newChild.zbox.width,newChild.zbox.height,down_right);
				
				var dg:DragGrid=new DragGrid();
				dg.motor=motor;
				zbox.addGesture(dg);
			}else{
				newChild.zbox.width=firstChild.zbox.width;
				newChild.zbox.height=firstChild.zbox.height;
			}
			motor.addItem(newChild);
			return newChild;
		}
		
		public function gridMoveShell(x:Number, y:Number):void
		{
			for each(var c:MassTreeNVP_GridItem2 in childList){
				c.zbox.move(x+c.dx,y+c.dy);
			}
		}
		
		override public function notifyDispose():void{
			super.notifyDispose();
			motor.clear();
		}
		
		public function showHead(value:Boolean):void
		{
		}
		
		public function showTail(value:Boolean):void
		{
		}
		
		public function set gridPageSize(value:int):void
		{
		}
		
		public function set gridPageCount(value:int):void
		{
		}
		
		public function set gridAtPage(idx:int):void
		{
		}
	}
}