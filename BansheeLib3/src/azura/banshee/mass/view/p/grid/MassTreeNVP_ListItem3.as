package azura.banshee.mass.view.p.grid
{
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.view.p.MassTreeNVP2;
	import azura.banshee.mass.view.p.MassTreeVP2;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.collections.BoxC;
	import azura.common.ui.list.motor.ListMotorItemI;
	
	public class MassTreeNVP_ListItem3 implements ListMotorItemI
	{
		
		private var parentZbox:Zbox3;
		private var parentNode:MassTreeNVP2;
		private var model:MassTreeN;
		private var tree:MassTreeVP2;
		internal var h_v:Boolean;
		
		public var view:MassTreeNVP2;
		private var box:BoxC;
		private var pos:Number=0;
		
		private var visible_:Boolean;
		
		public function MassTreeNVP_ListItem3(parentZbox:Zbox3,parentNode:MassTreeNVP2, 
											  model:MassTreeN, tree:MassTreeVP2, h_v:Boolean)
		{
			//			super(parentZbox, parentNode, model, tree);
			this.parentZbox=parentZbox;
			this.parentNode=parentNode;
			this.model=model;
			this.tree=tree;
			this.h_v=h_v;
			box=model.box.localizeBox(parentZbox.width,parentZbox.height);
			//			this.zbox.visible=false;
		}
		
		public function get listItemLength():Number
		{
			if(h_v)
				return box.bb.width;
			else
				return box.bb.height;
		}
		
		public function notifyMove(pos:Number):void
		{
			//			trace("item pos",pos,this);
			this.pos=pos;
			if(view==null)
				return;
			
			updatePos();
		}
		
		private function updatePos():void{
			if(h_v){
				view.zbox.move(pos,0);
			}else{
				view.zbox.move(0,pos);
			}			
		}
		
		public function set listItemShow(value:Boolean):void
		{
			if(visible_==value){
				trace("duplicate set visible",this);
				return;
			}
			visible_=value;
			//			trace("visible",value,this);
			if(value==true){
				view=new MassTreeNVP2(parentZbox,parentNode,model,tree);
				updatePos();
				view.model.castActivate();
			}else{
				view.zbox.dispose();
				view=null;
			}
			//			zbox.visible=value;
		}
	}
}