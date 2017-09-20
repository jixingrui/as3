package azura.banshee.mass.editor
{
	import azura.banshee.mass.model.MassAction;
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
	
	public class MassPanel3Canvas
	{
		public static var instance:MassPanel3Canvas;
		private static var leftPanel:int=0;
		
		private var designWidth:Number;
		private var designHeight:Number;
		
		private var space:Zspace3;
		
		private var bgLayer:Zbox3Container;
		public var ref:ZebraC3;		
		
		public var uiLayer:Zbox3Container;
		
		private var screenRect:ZboxRect3;
		
		public var action:MassAction=new MassAction(null);
		
		public function MassPanel3Canvas()
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
			space.look(leftPanel/2,0,w,h);
			uiLayer.zbox.width=w;
			uiLayer.zbox.height=h;
			screenRect.resize(designWidth,designHeight);
//			if(treeView!=null)
//				treeView.model.setScreenSize(designWidth,designHeight);
		}
		
		private function onWheel(me:MouseEvent):void{
			space.scaleView+=0.1*FastMath.sign(me.delta);
			Toast.show(space.scaleView.toString());
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