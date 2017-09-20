package azura.banshee.zebra.editor.zforest
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.Zebra3;
	import azura.banshee.zebra.editor.ztree.Ztree3;
	
	public class ZforestC3 extends Zbox3Container
	{
		public var zforest:Zforest3=new Zforest3();
		
		private var bg:ZebraC3;
		public var footLayer:Zbox3Container;
		public var assLayer:Zbox3Container;
		public var headLayer:Zbox3Container;
		
		public var ztreeList:Vector.<ZebraC3>=new Vector.<ZebraC3>();
		
		private var selectedIdx:int=-1;
		
		public function ZforestC3(parent:Zbox3)
		{
			super(parent);
			
			bg=new ZebraC3(this.zbox);
			
			footLayer=new Zbox3Container(this.zbox);
			assLayer=new Zbox3Container(this.zbox);
			headLayer=new Zbox3Container(this.zbox);
			
			footLayer.zbox.notifyLoadingTreeLoaded();
			assLayer.zbox.notifyLoadingTreeLoaded();
			headLayer.zbox.notifyLoadingTreeLoaded();
		}
		
		public function select(idx:int):void{
			selectedIdx=idx;
//			selectedZtree.
		}
		
		public function get selectedZtree():ZebraC3{
			if(selectedIdx>=0)
				return ztreeList[selectedIdx];
			else
				return null;
		}
		
		public function feedZebra(zebra:Zebra3):void{
			selectedZtree.feedZebra(zebra);
		}
		
		public function insert():Ztree3{
			var zt:Ztree3=new Ztree3();
			zforest.ztreeList.insertAt(selectedIdx+1,zt);
			reload();
			return zt;
		}
		
		public function reload():void{
			clear();
			
			bg.feedZebra(zforest.land);
//			assLayer.data=zforest.mask;
			
			for each(var zitem:Ztree3 in zforest.ztreeList){
				var zn:ZebraC3=new ZebraC3(assLayer.zbox);
				zn.feedZebra(zitem.zebra);
//				zn.zbox.move(zitem.zebra.x,zitem.zebra.y);
				ztreeList.push(zn);
			}
		}
		
		public function clear():void{
			bg.zbox.clear();
			footLayer.zbox.clear();
			assLayer.zbox.clear();
			headLayer.zbox.clear();
			ztreeList=new Vector.<ZebraC3>();
		}
		
//		internal function clearItems():void{
//			while(itemList.length>0){
//				itemList.pop().dispose();
//			}
//		}
	}
}