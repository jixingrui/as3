package azura.banshee.mass.view.p
{
	import azura.banshee.mass.model.MassTree;
	import azura.banshee.mass.sdk.MassSdkI2;
	import azura.banshee.mass.view.MassTreeV2;
	import azura.banshee.zbox3.Zbox3;
	
	public class MassTreeVP2 extends MassTreeV2
	{
		
		public function MassTreeVP2(parent:Zbox3,data:MassTree,user:MassSdkI2)
		{
			super(parent,data,user);
			root=new MassTreeNVP2(parent,null,data.root,this);
			
//			trace("disign visual size",data.ss.designWidth,data.ss.designHeight,this);
		}
		
	}
}