package azura.banshee.zebra.editor.zebra
{
	import azura.banshee.engine.Statics;
	
	import azura.avalon.maze3.ui.woo.WooObserver;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.mouse.MouseDUMI;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.editor.ZebraEditorShell;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	import azura.touch.watcherOld.WatcherDrag;
	import azura.touch.watcherOld.WatcherEvent;
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.TouchBox;
	import azura.touch.TouchSpace;
	import azura.touch.TouchStage;
	
	import flash.display.Stage;
	import flash.geom.Point;
	
	import mx.states.OverrideBase;
	
	import org.osflash.signals.Signal;
	
	import spark.core.SpriteVisualElement;
	
	public class LayerZebra extends LayerRuler 
	{
		public var actor:ZebraNode;
		private var boxBg:TouchBox;
		private var boxItem:TouchBox;
		
//		public static var touchLayer:TouchLayer;
		
		public function LayerZebra(gl:G2dLayer)
		{
			super(gl);
//			boxBg=new TouchBox();
//			boxBg.box.width=Statics.stage.stageWidth;
//			boxBg.box.height=Statics.stage.stageHeight;			
//			ZebraEditorShell.touchLayer.putBox(boxBg);
			
//			box.user=new rota
		}
		
		public function showZebra(zebra:Zebra):void{
			if(actor==null){
				actor=new ZebraNode(root.root);
			}
			actor.zebra=zebra;
			actor.move(0,0);
			
			if(zebra.type==Zebra.zimage){
//				box.user=new MoverG(this);
//				boxBg.user=null;
			}else{
				boxBg.addUser(new RotaterG(this));
			}
			
//			boxItem.box.lbb.width=zebra.boundingBox.width;
//			boxItem.box.lbb.height=zebra.boundingBox.height;
//			trace("item size",boxItem.width,boxItem.height,this);
//			boxItem.updatePos();
		}
		
		override public function init(stage:Stage):void{
			super.init(stage);
			
//			root.touchLayer=new TouchLayer();
			TouchStage.addLayer(root);
//			var tb:TouchBox=new TouchBox();
//			tb.box.width=stage.stageWidth;
//			tb.box.height=stage.stageHeight;
//			tb.box.lbb.x=-stage.stageWidth/2;
//			tb.box.lbb.y=-stage.stageHeight/2;
//			tb.user=new MoverG(this);
//			TouchStage.screenSpace.putBox(tb);
//			root.user=new MoverG(this);
//			boxItem=new TouchBox();
//			root.touchLayer.putBox(boxItem);
//			boxItem.user=new MoverG(this);
		}
		
		override public function dispose():void{
			boxBg.dispose();
			super.dispose();
		}
		
		override public function clear():void{
			actor.dispose();
		}
	}
}