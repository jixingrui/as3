package azura.banshee.mass.view.p.grid
{
	import azura.banshee.mass.model.MassBox;
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.view.MassTreeNV2;
	import azura.banshee.mass.view.p.MassTreeNVP2;
	import azura.banshee.mass.view.p.MassTreeVP2;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.ui.list.motor.DragList;
	import azura.common.ui.list.motor.ListMotor2;
	import azura.common.ui.list.motor.ListMotorMotherI;
	
	import flash.utils.Dictionary;
	
	public class MassTreeNVP_List3 extends MassTreeNVP2 implements ListMotorMotherI
	{
		private var motor:ListMotor2;
		private var name_idx:Dictionary=new Dictionary();
		
		public function MassTreeNVP_List3(parentZbox:Zbox3, parentNode:MassTreeNVP2, model:MassTreeN, tree:MassTreeVP2)
		{
			super(parentZbox, parentNode, model, tree);
			zbox.clip=true;
//			relativePosition();
			
			motor=new ListMotor2(this);
			var dragger:DragList=new DragList();
			dragger.H_V=H_V;
			dragger.motor=this.motor;
			zbox.addGesture(dragger);
			
			for(var i:int=0;i<model.childList.length;i++){
				var childData:MassTreeN=model.childList[i];
				var newChild:MassTreeNVP_ListItem3= new MassTreeNVP_ListItem3(zbox,this,childData,tree as MassTreeVP2,H_V);
				motor.addChild(newChild);
				name_idx[childData.path]=i;
			}
			
			if(model.keptState!=null)
				toBoss(model.keptState.path);
		}
		
		override protected function newChild(childData:MassTreeN):MassTreeNV2{
			//do nothing
			throw new Error();
			
			var box:MassBox=childData.box;
			if(box.isState||box.isDrag||box.isZoom)
				throw new Error();
			
			if(motor==null){
				trace("motor is null",this);
			}
			
			var newChild:MassTreeNVP_ListItem3= new MassTreeNVP_ListItem3(zbox,this,childData,tree as MassTreeVP2,H_V);
			motor.addChild(newChild);
			return newChild.view;
		}
		
		//do not show anything on initialize
		override public function showChildBoxList():void{
		}
		
		//do not manage state
		override public function updateFrame():void{
			loopFrame();
		}
		
		private function get H_V():Boolean{
			return this.model.box.isHlist;
		}
		
		public function get shellLength():Number
		{
			if(H_V)
				return zbox.width;
			else
				return zbox.height;
		}
		
		public function set hitHead(value:Boolean):void
		{
		}
		
		public function set hitTail(value:Boolean):void
		{
		}
		
		public function changeBoss(idx:int):void{
			trace("change boss",idx,this);
//			model.activateChildState(model.childList[idx]);
//			var path:String=model.activeState.path;
			//			tree.syncOut(path);
		}
		
		public function toBoss(path:String):void{
			trace("to boss",path,this);
			var idx:int=name_idx[path];
			motor.autoTo(idx);
		}
		
//		override public function notifyInitStates():void{
//			motor.autoTo(0);
//		}
		
//		override public function notifyClear():void{
//			motor.autoTo(0);
//		}
		
		override public function notifyDispose():void{
			super.notifyDispose();
			motor.clear();
		}
	}
}