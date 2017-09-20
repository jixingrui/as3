package azura.banshee.mass.model.v3
{
	public class MassTreeN3E extends MassTreeN3
	{
		public function MassTreeN3E(tree:MassTree3)
		{
			super(tree);
		}
		
		override public function newChild():MassTreeN3{
			var child:MassTreeN3=new MassTreeN3E(tree);
			child.parent=this;
			childList.push(child);
			return child;
		}
		
		override public function makeV():MassTreeNV3{
			return new MassTreeNV3E(parent.v.zbox,this);
		}
		
		override protected function get shouldBeVisible():Boolean{
			
			if(isRoot==true)
				return true;
			if(parent.visible==false)
				return false;
			if(parent.box.isList)
				return true;
			if(parent.keptState==this)
				return true;
			if(box.isState==false)
				return true;
			return false;
		}
		
		public function clearKeep():void{
			if(keptStateV!=null)
				keptStateV.zbox.dispose();
			keptState=firstState;
			keptStateV=null;
		}
		
		public function greenBox():void{
			var ve:MassTreeNV3E=v as MassTreeNV3E;
			if(ve!=null)
				ve.greenBox();
		}
		
		public function blueBox():void{
			var ve:MassTreeNV3E=v as MassTreeNV3E;
			if(ve!=null)
				ve.blueBox();
		}
		
		public function closeE():void{
			var ve:MassTreeNV3E=v as MassTreeNV3E;
			if(ve!=null){
				ve.zbox.dispose();
			}
		}
	}
}