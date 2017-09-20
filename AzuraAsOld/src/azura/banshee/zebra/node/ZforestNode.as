package azura.banshee.zebra.node
{
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zforest.Zforest;
	import azura.banshee.zforest.Ztree;
	
	import mx.states.OverrideBase;
	
	public class ZforestNode extends ZboxOld
	{
		public var zforest:Zforest=new Zforest();
		
		private var bg:ZebraNode;
		public var footLayer:ZboxOld;
		public var assLayer:ZmaskNode;
		public var headLayer:ZboxOld;
		
		public var ztreeList:Vector.<ZebraNode>=new Vector.<ZebraNode>();
		
		public function ZforestNode(parent:ZboxOld)
		{
			super(parent);
			
			bg=new ZebraNode(this);
			
			footLayer=new ZboxOld(this);
			
			assLayer=new ZmaskNode(this);
			assLayer.sortEnabled=true;
			
			headLayer=new ZboxOld(this);
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
			
			bg.zebra=zforest.land;
			assLayer.data=zforest.mask;
			
			for each(var zitem:Ztree in zforest.ztreeList){
				var zn:ZebraNode=new ZebraNode(assLayer);
				zn.zebra=zitem.zebra;
				zn.move(zitem.zebra.x,zitem.zebra.y);
				ztreeList.push(zn);
			}
		}
		
		override public function clear():void{
			bg.clear();
			footLayer.clear();
			assLayer.clear();
			headLayer.clear();
			ztreeList=new Vector.<ZebraNode>();
		}
		
//		internal function clearItems():void{
//			while(itemList.length>0){
//				itemList.pop().dispose();
//			}
//		}
	}
}