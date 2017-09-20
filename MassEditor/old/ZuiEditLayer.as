package azura.banshee.mass.layer
{
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zebra.zbox2.Zspace2;
	import azura.banshee.zebra.zbox2.app.ZebraRect2;
	import azura.banshee.zebra.zbox2.customize.Zbox2Container;
	import azura.banshee.zebra.zbox2.customize.g2d.Zbox2ReplicaG2d;
	import azura.banshee.zebra.zbox2.zebra.ZebraC2;
	import azura.common.algorithm.FastMath;
	import azura.banshee.mass.graphics.e.ZuiTreeVE;
	import azura.banshee.mass.model.ZuiAction;
	import azura.zui.touch.TouchBox;
	import azura.zui.touch.TouchStage;
	import azura.banshee.mass.tree.MassTree;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	public class ZuiEditLayer implements Stage3DLayerI
	{
		public static var instance:ZuiEditLayer;
		private static var rightDrift:int=95;
		
		public var redW:Number;
		public var redH:Number;
		
		private var gl:G2dLayer;
		public var space:Zspace2;
		
		public var bgLayer:Zbox2Container;
		public var ref:ZebraC2;		
		
		public var uiLayer:Zbox2Container;
		public var treeView:ZuiTreeVE;
		
		public var screenLayer:Zbox2Container;
		public var screenRect:ZebraRect2;
		
		private var ready:Function;
		
		public var action:ZuiAction=new ZuiAction();
		
		public function ZuiEditLayer(gl:G2dLayer, ready:Function)
		{
			this.gl=gl;
			this.ready=ready;
			
			Stage3DRoot.singleton().addLayer(this);
			
			instance=this;
		}
		
		public function init(stage:Stage):void
		{
			redW=stage.stageWidth-1-rightDrift*2;
			redH=stage.stageHeight-1;			
			
			var replica:Zbox2ReplicaG2d=new Zbox2ReplicaG2d();
			gl.node.addChild(replica.node);
			
			space=new Zspace2(replica);			
			space.look(0,0,redW,redH);
			
			bgLayer=new Zbox2Container(space.view);
			uiLayer=new Zbox2Container(space.view);
			screenLayer=new Zbox2Container(space.view);
			bgLayer.zbox.move(rightDrift,0);
			uiLayer.zbox.move(rightDrift,0);
			screenLayer.zbox.move(rightDrift,0);
			
			ref=new ZebraC2(bgLayer.zbox);
			
			screenRect=new ZebraRect2(screenLayer.zbox);
			screenRect.paint(0xffff0000);
			screenRect.shape(redW,redH);
			
			initTouch(stage);
			
			setTimeout(ready.call,0);
			
			//			stage.addEventListener(MouseEvent.MOUSE_WHEEL,onWheel);
		}
		
		private var screenBox:TouchBox;
		private var screenMoveUser:ScreenDrag;
		private var screenBackUser:ScreenBack;
		private var screenJump:ScreenJump;
		
		private function initTouch(stage:Stage):void{
			TouchStage.start(stage);
			screenBox=new TouchBox();
			screenBox.box.width=stage.stageWidth;
			screenBox.box.height=stage.stageHeight;
			
//			screenMoveUser=new ScreenDrag();
//			screenMoveUser.space=space;
//			screenBox.addUser(screenMoveUser);
			
//			screenBackUser=new ScreenBack();
//			screenBackUser.space=space;
//			screenBox.addUser(screenBackUser);
			
//			screenJump=new ScreenJump();
//			screenJump.space=space;
//			screenBox.addUser(screenJump);
			
			TouchStage.screenSpace.putBox(screenBox);
		}
		
		private function onWheel(me:MouseEvent):void{
			space.scale-=0.05*FastMath.sign(me.delta);
		}
		
		public function showTree(tree:MassTree):void{
			if(treeView!=null)
				treeView.dispose();
			treeView=new ZuiTreeVE(uiLayer.zbox,tree);
			treeView.changeScreenSize(redW,redH);
//			treeView.touchSpace.dx=rightDrift;
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