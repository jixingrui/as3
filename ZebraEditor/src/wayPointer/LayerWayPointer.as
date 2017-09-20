package wayPointer
{
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.mouse.MouseDUMI;
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Zforest;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	
	public class LayerWayPointer implements Stage3DLayerI
	{
		public static var MOUSEDRAGSCREEN:int=0;
		public static var MOUSEPATH:int=1;
		
		private var gl:G2dLayer;
		
		internal var root:Zspace;
		internal var zforestNode:ZforestNode;
		
		internal var wayFinder:WayFinder;
		private var mouse_:MouseDUMI;
		[Bindable]
		public var mousePath:MousePath;
		
		internal var zforest:Zforest=new Zforest();
		
		private var points:Vector.<ZebraNode>=new Vector.<ZebraNode>();
		
		public function LayerWayPointer(gl:G2dLayer)
		{
			this.gl=gl;
			mouse_=new MouseDragScreen(this);
			Stage3DRoot.singleton().addLayer(this);
			mousePath=new MousePath(this);
		}
		
		public function init(stage:Stage):void{
			//canvas
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
			//			var scale:Number=Stage3DRoot.singleton().stage.stageWidth/1280;
			var scale:Number=1;
			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
			
			root=new Zspace(link,w,h);
			
			zforestNode=new ZforestNode(root.root);
		}
		
		public function get mouse():MouseDUMI{
			return mouse_;
		}
		
		public function set mouseMode(mode:int):void{
			if(mode==MOUSEDRAGSCREEN)
				mouse_=new MouseDragScreen(this);
			else if(mode==MOUSEPATH){
				mouse_=mousePath;
			}
		}
		
		public function drawPoint(x:int,y:int,color:int,size:int=2):void{
			
			var dot:BitmapData=Draw.circle(size,color);
			var z:Zebra=new Zebra();
			var zb:Zbitmap=new Zbitmap();
			zb.bitmapData=dot;
			z.branch=zb;
			var zn:ZebraNode=new ZebraNode(zforestNode.headLayer);
			zn.zebra=z;
			zn.move(x,y);
			points.push(zn);
		}
		
		public function enterFrame():void{
			root.enterFrame();
		}
		
		public function dispose():void
		{
			//			bg.dispose();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clear():void{
			zforestNode.clear();
			mousePath=new MousePath(this);
			mouseMode=MOUSEDRAGSCREEN;
		}
		
		public function clearWays():void{
			while(points.length>0){
				var p:ZebraNode=points.pop();
				p.dispose();
			}
		}
		
		public function showTrees():void{
			zforestNode.assLayer.clear();
//			for each(var zp:Zplanted in zforest.zplantedList){
//				var treeDisplay:ZebraNode=new ZebraNode(zforestNode.assLayer);
//				treeDisplay.zebra=zp.ztree.zebra;
//				treeDisplay.move(zp.ztree.zebra.x,zp.ztree.zebra.y);
//			}
		}
	}
}