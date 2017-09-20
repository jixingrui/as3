package azura.banshee.mass.model.v3
{
	import azura.common.ui.list.motor.ListMotor2;
	import azura.common.ui.list.motor.ListMotorItemI;
	import azura.common.ui.list.motor.ListMotorMotherI;
	
	public class MassTreeN3P extends MassTreeN3 implements ListMotorMotherI,ListMotorItemI
	{
		//if list
		public var motor:ListMotor2;
		
		public function MassTreeN3P(tree:MassTree3)
		{
			super(tree);
		}
		
		override public function makeV():MassTreeNV3{
			return new MassTreeNV3P(parent.v.zbox,this);
		}
		
		override public function initList():void{
			if(box.isList && motor==null){
				motor=new ListMotor2(this);
				for each(var cl:MassTreeN3P in childList){
					motor.addChild(cl);
				}
			}else if(box.isList==false && motor!=null){
				//				motor.dispose();
				//				motor=null;
			}
		}
		
		override public function set keptState(value:MassTreeN3):void{
			var cast:Boolean=keptState!=value;
//			if(parent.box.isList){
//				cast=value!=null && keptState!=value;
//			}else{
//				cast=keptState!=null && value!=null && keptState!=value;
//			}
			super.keptState=value;
			if(cast){
				value.castActivate();
			}
		}
		
		override protected function get shouldBeVisible():Boolean{
			
			if(isRoot==true)
				return true;
			if(parent.visible==false)
				return false;
			if(parent.box.isList)
				return listItemVisible;
			if(parent.keptState==this)
				return true;
			if(box.isState==false)
				return true;
			return false;
		}
		
		override protected function slapListItem(idx:int):void{
			motor.autoTo(idx);
		}
		
		override public function newChild():MassTreeN3{
			var child:MassTreeN3=new MassTreeN3P(tree);
			child.parent=this;
			childList.push(child);
			return child;
		}
		
		//===================== ListMotorMotherI ==================
		public function get shellLength():Number
		{
			if(box.isHlist)
				return width;
			else
				return height;
		}
		
		public function set hitHead(value:Boolean):void
		{
		}
		
		public function set hitTail(value:Boolean):void
		{
		}
		
		public function changeBoss(idx:int):void
		{
//			trace("change boss to",idx,this);
			if(idx<0){
				trace("Error: changeBoss to",idx,this);
				return;
			}
			
			keptState=childList[idx];
			tree.showVisible();
			tree.syncOut(keptState.path);
		}
		
		//======================= ListMotorItemI ==============
		public function get listItemLength():Number
		{
			if(parent.box.isHlist)
				return width;
			else
				return height;
		}
		
		public function notifyMove(pos:Number):void
		{
			if(parent.box.isHlist){
				x=pos;
				y=0;
			}else{
				x=0;
				y=pos;
			}
			updatePos();
		}
		
		private function updatePos():void{
			if(v!=null){
				v.zbox.move(x,y);
				v.zbox.visible=true;
			}
		}
		
		public var listItemVisible:Boolean;
		
		public function set listItemShow(value:Boolean):void
		{
//			trace("list item show",value,this);
			listItemVisible=value;
			showVisible();
			if(visible)
				v.zbox.visible=false;
			
			//			tree.syncOut(this.path);
		}
	}
}