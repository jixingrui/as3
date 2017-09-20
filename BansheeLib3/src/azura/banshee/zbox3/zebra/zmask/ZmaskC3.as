package azura.banshee.zbox3.zebra.zmask
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.PyramidViewer2;
	import azura.avalon.fi.view.PyramidViewerI;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zebra.branch.ZimageLarge2Tile;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	import azura.common.collections.RectC;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class ZmaskC3 extends Zbox3Container implements Zbox3ControllerI,PyramidViewerI
	{
		private var _data:Zmask2;
		public var fi_ZmaskTile2Op:Dictionary=new Dictionary();
		
		private var viewer:PyramidViewer2;
		
		public function ZmaskC3(parent:Zbox3)
		{
			super(parent);
			zbox.keepSorted=true;
			viewer=new PyramidViewer2(this,true);
		}
		
		public function get data():Zmask2
		{
			return _data;
		}
		
		public function set data(value:Zmask2):void
		{
			if(_data!=null){
				viewer.clear();
			}
			
			_data = value;
			viewer.z=_data.zMax;
		}
		
//		override public function notifyInitialized():void{
//			trace("init",this);
//		}
		
		override public function notifyChangeView():void{
			var viewLocal:RectC=new RectC();
			var scale:Number=zbox.space.scaleView*zbox.scaleGlobal;
			viewLocal.xc=(zbox.space.xView-zbox.xGlobal);
			viewLocal.yc=(zbox.space.yView-zbox.yGlobal);
			viewLocal.width=zbox.space.widthView/scale;
			viewLocal.height=zbox.space.heightView/scale;
			
			//			trace("notify change view",viewLocal,this);
			viewLocal.xc/=512;
			viewLocal.yc/=512;
			viewLocal.width/=512;
			viewLocal.height/=512;
			
			//			trace("z=",targetZup,"view=",viewLocal,this);
			viewer.look(viewLocal);
		}
		
		public function pyramidView(targets:FiSet, deltaIn:FiSet, deltaOut:FiSet):void
		{
			var fi:FoldIndex;
			var tile:ZmaskTile2;
			var op:ZmaskTile2Op;
			
			for each(fi in deltaIn.getList()){
				tile=_data.getTile_(fi.fi) as ZmaskTile2;
				//				trace("in",fi,tile.atlas.frameList.length,this);
				
				op=fi_ZmaskTile2Op[fi.fi];
				if(op!=null)
					trace("error: duplicate tile:",fi.fi,this);
				
				//				if(tile.atlas.frameList.length==0)
				//					continue;
				
				op=new ZmaskTile2Op();
				fi_ZmaskTile2Op[fi.fi]=op;
				op.host=this;
				op.tile=tile;
				op.load();
//				trace("loading",fi.fi,this);
			}
			
			for each(fi in deltaOut.getList()){
				tile=_data.getTile_(fi.fi) as ZmaskTile2;
				//				trace("out",fi,tile.atlas.frameList.length,this);
				op=fi_ZmaskTile2Op[fi.fi];
				if(op==null){
					trace("error: fi not found:",fi.fi,this);
					continue;
				}
				delete fi_ZmaskTile2Op[fi.fi];
				op.dispose();
			}
		}
		
//		override protected function scaleChange(scaleGlobal:Number):void{
//			//			trace("scale",scaleGlobal,this);
//			var zUpNew:int=FastMath.log2(Math.floor(1/scaleGlobal));
//			viewer.z=_data.zMax-zUpNew;
//		}
		
//		private function updateView():void{
//			viewer.clear();
//			viewer.z=data.zMax-zUp;
//			//			trace("viewer.z=",viewer.z,"zMax=",pyramid.zMax,this);
//			notifyChangeView();
//		}	
		
		private function get zUp():int{
			var target:int= FastMath.log2(Math.floor(1/(zbox.scaleGlobal*zbox.space.scaleView)));
			target= Math.min(target,data.zMax);
			//			trace("zUp",target,this);
			return target;
		}
		
//		override public function clear():void{
//			viewer.clear();
//			super.clear();
//		}
		
	}
}