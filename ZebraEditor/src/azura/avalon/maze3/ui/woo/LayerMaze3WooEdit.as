package azura.avalon.maze3.ui.woo
{
	import azura.avalon.maze.data.EventCenter;
	import azura.avalon.maze.data.Item;
	import azura.avalon.maze3.data.Mroom;
	import azura.avalon.maze3.data.Mwoo;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Zforest;
	import azura.touch.mouserOld.MouserDrag;
	
	import flash.display.Stage;
	
	import mx.charts.renderers.BoxItemRenderer;
	
	public class LayerMaze3WooEdit implements Stage3DLayerI
	{
		public static var MOUSEDRAGSCREEN:int=0;
		public static var MOUSEDRAGWOO:int=1;
		
		public static var instance:LayerMaze3WooEdit;
		
		private var gl:G2dLayer;
		
		internal var root:Zspace;
		public var zforestNode:ZforestNode;
		
		public var idxSelectedWoo:int=-1;
		public var woo:Mwoo;
		private var wooNodeList:Vector.<ZebraNode>=new Vector.<ZebraNode>();
		
		private var this_:LayerMaze3WooEdit;
		
		public var wayFinder:WayFinder;
		
		private var room:Mroom;
		
		public var stage:Stage;
		
		private var md:MouserDrag;
		
		public var panel:Maze3WooEditPanel;
		
		public function LayerMaze3WooEdit(gl:G2dLayer,stage:Stage)
		{
			this.gl=gl;
			this.stage=stage;
			this_=this;
			
			instance=this;
			
			md=new MouserDrag(stage);
			
			mouseMode=MOUSEDRAGSCREEN;
			Stage3DRoot.singleton().addLayer(this);
			
			EventCenter.moveItem.add(moveWoo);
			function moveWoo():void{
				mouseMode=MOUSEDRAGWOO;
			}
			
			//			EventCenter.lookAt.add(root.lookAt);
		}
		
		public function get selectedWooNode():ZebraNode{
			return wooNodeList[idxSelectedWoo];
		}
		
		public function rotateItem(angle:int):void{
			selectedWooNode.angle=angle;
			panel.wooPanel.woo.icon.angle=angle;
			panel.drWoo.save();
		}
		
		public function showWoo(item:Mwoo):void{
			var dn:ZebraNode=wooNodeList[idxSelectedWoo];
			dn.zebra=item.icon;
			dn.move(item.icon.x,item.icon.y);
			dn.angle=item.icon.angle;
			
			//			dn.observer=new Observer();
		}
		
		public function loadZforest(zf:Zforest):void{
			clearWoo();
			zforestNode.zforest=zf;
			zforestNode.reload();
			lookAt(xCache,yCache);
			
			wayFinder=new WayFinder(zf.way,zf.zbaseScale);
		}
		
		public function loadWoo(wooList:Vector.<Mwoo>):void{
			clearWoo();
			for each(var d:Mwoo in wooList){
				var dn:ZebraNode=new ZebraNode(zforestNode.footLayer);
				wooNodeList.push(dn);
				dn.zebra=d.icon;
				dn.move(d.icon.x,d.icon.y);
				dn.angle=d.icon.angle;
				
				//				dn.observer=new WooObserver(d,dn);
			}
		}
		
		private var xCache:int,yCache:int;
		public function lookAt(x:int,y:int):void{
			if(zforestNode.zforest==null){
				xCache=x;
				yCache=y;
			}else
				root.lookAt(x,y);
		}
		
		public function init(stage:Stage):void{
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
			var scale:Number=1;
			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
			
			root=new Zspace(link,w,h);
			root.scaleLocal=scale;
			EventCenter.lookAt.add(root.lookAt);
			
			zforestNode=new ZforestNode(root.root);
		}
		
		public function set mouseMode(mode:int):void{
			if(mode==MOUSEDRAGSCREEN){
				md.listener=new MouseDragScreen(this);
			}else if(mode==MOUSEDRAGWOO){
				md.listener=new MouseDragWoo(this);
			}
		}
		
		public function enterFrame():void{
			if(root!=null)
				root.enterFrame();
		}
		
		public function dispose():void
		{
			clearWoo();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clearWoo():void{
			for each(var dn:ZebraNode in wooNodeList){
				dn.dispose();
			}
			wooNodeList=new Vector.<ZebraNode>();
		}
		
		public function clear():void{
			clearWoo();
			zforestNode.clear();
		}
		
		public function get x():int{
			return root.xView;
		}
		
		public function get y():int{
			return root.yView;
		}
	}
}