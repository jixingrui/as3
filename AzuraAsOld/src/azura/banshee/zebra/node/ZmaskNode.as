package azura.banshee.zebra.node
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.PyramidViewer;
	import azura.avalon.fi.view.PyramidViewerI;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zforest.zmask.Zmask;
	import azura.banshee.zforest.zmask.ZmaskTile;
	import azura.banshee.zforest.zmask.ZmaskTileOp;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class ZmaskNode extends ZboxOld implements PyramidViewerI
	{
		private var _data:Zmask;
		public var fi_ZmaskTileOp:Dictionary=new Dictionary();
		
		private var viewer:PyramidViewer;
		
		public function ZmaskNode(parent:ZboxOld)
		{
			super(parent);
			viewer=new PyramidViewer(this,true);
		}
		
		public function get data():Zmask
		{
			return _data;
		}
		
		public function set data(value:Zmask):void
		{
			if(_data!=null){
				viewer.clear();
			}
			
			_data = value;
			viewer.z=_data.zMax;
			var vg:Rectangle=space.viewGlobal;
			vg.x/=256;
			vg.y/=256;
			vg.width/=256;
			vg.height/=256;
			viewer.look(vg);
		}
		
		public function pyramidView(targets:FiSet, deltaIn:FiSet, deltaOut:FiSet):void
		{
			var fi:FoldIndex;
			var tile:ZmaskTile;
			var op:ZmaskTileOp;
			
			for each(fi in deltaIn.getList()){
				tile=_data.getTile_(fi.fi) as ZmaskTile;
//				trace("in",fi,tile.atlas.frameList.length,this);
				
				op=fi_ZmaskTileOp[fi.fi];
				if(op!=null)
					trace("error: duplicate tile:",fi.fi,this);
				
//				if(tile.atlas.frameList.length==0)
//					continue;
				
				op=new ZmaskTileOp();
				fi_ZmaskTileOp[fi.fi]=op;
				op.node=this;
				op.tile=tile;
				op.load();
			}
			
			for each(fi in deltaOut.getList()){
				tile=_data.getTile_(fi.fi) as ZmaskTile;
//				trace("out",fi,tile.atlas.frameList.length,this);
				op=fi_ZmaskTileOp[fi.fi];
				if(op==null){
					trace("error: fi not found:",fi.fi,this);
					continue;
				}
				delete fi_ZmaskTileOp[fi.fi];
				op.dispose();
			}
		}
		
		override protected function scaleChange(scaleGlobal:Number):void{
			//			trace("scale",scaleGlobal,this);
			var zUpNew:int=FastMath.log2(Math.floor(1/scaleGlobal));
			viewer.z=_data.zMax-zUpNew;
		}
		
		override public function updateVisual():void
		{
			super.updateVisual();
			//			trace("visual change",this);
			if(_data==null)
				return;
			
			var vg:Rectangle=space.viewGlobal;
			var box:Rectangle=_data.boundingBox.clone();
			
			if(vg.intersects(box)){
				vg.x/=256;
				vg.y/=256;
				vg.width/=256;
				vg.height/=256;
				viewer.look(vg);
			}
		}
		
		override public function clear():void{
			viewer.clear();
			super.clear();
		}
	}
}