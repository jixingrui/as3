package azura.banshee.mass.view.p
{
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.view.MassTreeNV2;
	import azura.banshee.mass.view.p.grid.MassTreeNVP_List3;
	import azura.banshee.zbox3.Zbox3;
	
	public class MassTreeNVP2 extends MassTreeNV2
	{
		public function MassTreeNVP2(parentZbox:Zbox3,parentNode:MassTreeNVP2,model:MassTreeN,tree:MassTreeVP2)
		{
			super(parentZbox,parentNode,model,tree);
		}
		
		override protected function newChild(childData:MassTreeN):MassTreeNV2{
			var childNV:MassTreeNV2;
			if(childData.box.isHlist || childData.box.isVlist){
				childNV=new MassTreeNVP_List3(zbox,this,childData,tree as MassTreeVP2);
			}else{
				childNV=new MassTreeNVP2(zbox,this,childData,tree as MassTreeVP2);
			}
			return childNV;
		}
		
	}
}