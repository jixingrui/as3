package azura.banshee.zebra.editor.zforest
{
	import azura.banshee.zebra.editor.ztree.Ztree2;
	import azura.banshee.zebra.node.ZmaskNode;
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zforest.Zforest;
	import azura.banshee.zforest.Ztree;
	
	public class ZforestC2 extends Zbox2Container
	{
		public var zforest:Zforest2=new Zforest2();
		
		private var bg:ZebraC2;
		public var footLayer:Zbox2Container;
		public var assLayer:Zbox2Container;
		public var headLayer:Zbox2Container;
		
		public var ztreeList:Vector.<ZebraC2>=new Vector.<ZebraC2>();
		
		public function ZforestC2(parent:Zbox2)
		{
			super(parent);
			
			bg=new ZebraC2(this.zbox);
			
			footLayer=new Zbox2Container(this.zbox);
			
			assLayer=new Zbox2Container(this.zbox);
//			assLayer.sortEnabled=true;
			
			headLayer=new Zbox2Container(this.zbox);
		}
		
//		public function get zforest():Zforest
//		{
//			return zforest_;
//		}
//		
//		public function set zforest(value:Zforest):void
//		{
//			zforest_ = value;
////			reload();
//		}
		
		public function reload():void{
			clear();
			
			bg.feed(zforest.land);
//			assLayer.data=zforest.mask;
			
			for each(var zitem:Ztree2 in zforest.ztreeList){
				var zn:ZebraC2=new ZebraC2(assLayer.zbox);
				zn.feed(zitem.zebra);
//				zn.zbox.move(zitem.zebra.x,zitem.zebra.y);
				ztreeList.push(zn);
			}
		}
		
		public function clear():void{
			bg.zbox.clear();
			footLayer.zbox.clear();
			assLayer.zbox.clear();
			headLayer.zbox.clear();
			ztreeList=new Vector.<ZebraC2>();
		}
		
//		internal function clearItems():void{
//			while(itemList.length>0){
//				itemList.pop().dispose();
//			}
//		}
	}
}