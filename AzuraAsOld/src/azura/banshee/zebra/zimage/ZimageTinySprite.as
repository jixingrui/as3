package azura.banshee.zebra.zimage
{
	import azura.banshee.zebra.Zimage;
	import azura.banshee.zebra.atlas.Zatlas;
	import azura.banshee.zebra.atlas.Zframe;
	import azura.banshee.zebra.i.ZimageOpI;
	import azura.banshee.zebra.node.ZimageNode;
	import azura.banshee.zebra.zode.ZatlasOp;
	import azura.banshee.zebra.zode.ZframeOp;
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.banshee.zebra.zode.Zshard;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Rectangle;
	
	public class ZimageTinySprite extends Zshard implements ZimageOpI
	{
		private var op:ZatlasOp;
		
		private var _zUp:int;
		
		public function ZimageTinySprite(zimage:ZimageNode)
		{
			super(zimage);
			op=new ZatlasOp(zimage);
		}
		
		public function set data(atlas:Zatlas):void{
//			op.isLoaded=false;
//			op.isLoading=false;
//			op.clear();
			op.data=atlas;
			op.load(show);
		}
		
		public function get layerCount():int{
			return op.data.frameList.length;
		}
		
		public function get zUp():int
		{
			return _zUp;
		}
		
		public function set zUp(value:int):void
		{
			if(value<0||value>=layerCount){
				clear();
			}else if(zUp!=value){
				_zUp = value;
				clear();
//				show();
			}
		}
		
		private function show(atlas:ZatlasOp=null):void{			
			
//			trace("show",this);
			
			if(op.idle_loading_loaded!=2)
				return;
			
			var zf:Zframe=op.data.frameList[zUp];
			var zs:ZframeOp=new ZframeOp();
			zs.sheet=op.sheetList[zf.idxSheet];
			zs.subId=zUp.toString();
			zs.depth=zUp;
			zs.scale=FastMath.pow2x(zUp);
			zs.boundingBox=zf.boundingBox;
			zs.rectOnSheet=zf.rectOnSheet.clone();
			zs.driftX=-zf.anchor.x;
			zs.driftY=-zf.anchor.y;
			
			display(zs);
		}
		
		public function look(viewLocal:Rectangle):void {
			show();
		}
		
		override public function clear():void{
//			op.clear();
			super.clear();
		}
		
		override public function dispose():void{
			super.dispose();
		}
		
	}
}