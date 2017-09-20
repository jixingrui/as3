package azura.banshee.mass.editor
{
	import azura.banshee.mass.layer.DisplayerSdk2;
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTree;
	import azura.banshee.mass.view.e.MassTreeVE2;
	import azura.banshee.zbox3.Zspace3;
	import azura.banshee.zbox3.collection.ZboxRect3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.engine.Zbox3ReplicaStarling;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.algorithm.FastMath;
	import azura.common.ui.alert.Toast;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import starling.display.Sprite;
	
	public class MassPanel2Canvas
	{
		public static var instance:MassPanel2Canvas;
		private static var leftPanel:int=190;
		
		public var designWidth:Number;
		public var designHeight:Number;
		
		public var space:Zspace3;
		
		public var bgLayer:Zbox3Container;
		public var ref:ZebraC3;		
		
		public var uiLayer:Zbox3Container;
		public var treeView:MassTreeVE2;
		
		public var screenRect:ZboxRect3;
		
		public var action:MassAction=new MassAction(null);
		
		public function MassPanel2Canvas()
		{
			instance=this;
		}
		
		public function init(stage:Stage,root:Sprite):void
		{
			var replica:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(root);
			
			space=new Zspace3(replica);			
			
			bgLayer=new Zbox3Container(space);
			bgLayer.zbox.move(leftPanel/2,0);

			uiLayer=new Zbox3Container(space);
			uiLayer.zbox.move(leftPanel/2,0);
			uiLayer.zbox.keepSorted=true;
			
			ref=new ZebraC3(bgLayer.zbox);
			
			screenRect=new ZboxRect3(uiLayer.zbox);
			screenRect.zbox.sortValue=2;
			screenRect.paint(0xffff0000);
//			screenRect.shape(designWidth,designHeight);
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,onWheel);
		}
		
		public function resize(w:int,h:int):void{
			designWidth=w;
			designHeight=h;
			space.look(0,0,w,h);
			uiLayer.zbox.width=w;
			uiLayer.zbox.height=h;
			screenRect.resize(designWidth,designHeight);
			if(treeView!=null)
				treeView.model.setScreenSize(designWidth,designHeight);
		}
		
		private function onWheel(me:MouseEvent):void{
			space.scaleView+=0.1*FastMath.sign(me.delta);
			Toast.show(space.scaleView.toString());
//			trace("scaleView",space.scaleView,this);
		}
		
		public function showTree(tree:MassTree):void{
			if(treeView!=null)
				treeView.dispose();
			treeView=new MassTreeVE2(uiLayer.zbox,tree,new DisplayerSdk2());
			treeView.root.zbox.sortValue=1;
			treeView.model.setScreenSize(designWidth,designHeight);
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