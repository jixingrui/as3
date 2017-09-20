package azura.avalon.maze3.ui.woo
{
	import azura.avalon.maze3.data.Mwoo;
	import azura.avalon.maze3.ui.woo.cargo.WooZebra;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zebra.box.AbBoxI;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.Zspace;
	
	public class WooObserver implements AbBoxI
	{
		public var target:Mwoo;
		public var node:ZebraNode;
		public function WooObserver(woo:Mwoo,dn:ZebraNode)
		{
			this.target=woo;
			this.node=dn;
		}
		
		public function get priority():int
		{
			return 0;
		}
		
		public function zboxTouched():Boolean
		{
			trace("click woo",target.name,"uid",target.uid,this);
			
			var zebra:Zebra=WooZebra(target.cargo.branch).zebra;
			
//			var parent:ZnodeRoot=LayerMaze3WooEdit.instance.root;
			
			var detail:ZebraNode=new ZebraNode(node.space);
			detail.zebra=zebra;
			
			detail.move(node.xGlobal,node.yGlobal);
			
//			detail.observer=new Closer(detail);
//			trace("click",this);
			return true;
		}
	}
}