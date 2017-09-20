package azura.banshee.mass.layer
{
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.mass.graphics.p.ZuiTreeVP;
	import azura.banshee.mass.tree.MassTree;
	import azura.banshee.zebra.zbox2.Zspace2;
	import azura.banshee.zebra.zbox2.customize.Zbox2Container;
	import azura.banshee.zebra.zbox2.customize.g2d.Zbox2ReplicaG2d;
	import azura.zui.touch.TouchStage;
	
	import flash.display.Stage;
	import flash.utils.setTimeout;
	
	public class ZuiPlayLayer implements Stage3DLayerI
	{
		public static var instance:ZuiPlayLayer;
		
		private var gl:G2dLayer;
		public var space:Zspace2;
		
		public var uiLayer:Zbox2Container;
		public var treeView:ZuiTreeVP;
		
		private var ready:Function;
		
		private var stage:Stage;
		
		public function ZuiPlayLayer(gl:G2dLayer, ready:Function=null)
		{
			this.gl=gl;
			this.ready=ready;
			
			Stage3DRoot.singleton().addLayer(this);
			
			instance=this;
		}
		
		public function init(stage:Stage):void
		{
			this.stage=stage;
			
			var replica:Zbox2ReplicaG2d=new Zbox2ReplicaG2d();
			gl.node.addChild(replica.node);
			
			space=new Zspace2(replica);			
			space.look(0,0,stage.stageWidth,stage.stageHeight);
			
			uiLayer=new Zbox2Container(space.view);
			
			initTouch(stage);
			
			if(ready!=null)
				setTimeout(ready.call,0);
		}
		
		private function initTouch(stage:Stage):void{
			TouchStage.start(stage);
		}
		
		public function showTree(tree:MassTree):void{
			if(treeView!=null)
				treeView.dispose();
			treeView=new ZuiTreeVP(uiLayer.zbox,tree,new DisplayerSdk());
//			treeView.user=new DisplayerSdk();
			treeView.changeScreenSize(stage.stageWidth,stage.stageHeight);
		}
		
		public function clear():void
		{
		}
		
		public function dispose():void
		{
		}
		
		public function enterFrame():void
		{
		}
	}
}