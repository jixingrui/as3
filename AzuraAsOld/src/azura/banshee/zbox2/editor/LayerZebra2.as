package azura.banshee.zbox2.editor
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dEngine;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zbox2.Zspace2;
	import azura.banshee.zbox2.engine.g2d.Zbox2ReplicaG2d;
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.common.graphics.Draw;
	import azura.touch.TouchBox;
	import azura.touch.TouchSpace;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	
	public class LayerZebra2 implements Stage3DLayerI
	{
		private var gl:G2dLayer;
		private var ruler:GSprite;
//		public var root:Zspace;
		public var space:Zspace2;
		
		private var boxBg:TouchBox;
		
//		public var actorLayer:Zbox2Container;
		public var actor:ZebraC2;
		
		public function LayerZebra2(touchLayer:TouchSpace)
		{
			this.gl=gl;
			Stage3DRoot.singleton().addLayer(this);
			
//			boxBg=new TouchBox();
//			boxBg.box.xc=-Statics.stage.stageWidth/2;
//			boxBg.box.yc=-Statics.stage.stageHeight/2;
//			boxBg.box.width=Statics.stage.stageWidth;
//			boxBg.box.height=Statics.stage.stageHeight;			
//			ZebraEditorShell.touchLayer.putBox(boxBg);
//			touchLayer.putBox(boxBg);
		}
		
		public function init(stage:Stage):void
		{
			gl=G2dEngine.singleton().singleLayer;
			
			//ruler
			var bd:BitmapData=Draw.ruler(stage.stageWidth,stage.stageHeight);
			ruler=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			var tex:GTexture=GTextureFactory.createFromBitmapData("ruler",bd);
			ruler.texture=tex;
			gl.node.addChild(ruler.node);
			
			//canvas
//			var canvasG2d:ZRnodeG2d=ZRnodeG2d.createNewRenderer();
//			gl.node.addChild(canvasG2d.node);
			
			var root:Zbox2ReplicaG2d=new Zbox2ReplicaG2d();
			gl.node.addChild(root.node);
				//canvasG2d.node.addComponent(Zbox2ReplicaG2d) as Zbox2ReplicaG2d;
			space=new Zspace2(root);
			space.viewSizeScaled(stage.stageWidth,stage.stageHeight);
			space.look(0,0);
//			space.look(0,0,stage.width,stage.height);
			
//			actorLayer=space.addContainer();
			actor=new ZebraC2(space);
			
//			TouchZ.add
//			actorBox.replicate()
//			root=new Zspace(canvasG2d,Statics.stage.stageWidth,
//				Statics.stage.stageHeight);
		}
		
		public function showZebra(zebra:Zebra2Old):void{
			actor.zbox.move(0,0);
			actor.feed(zebra);
			
			if(zebra.type==Zebra2Old.MATRIX||zebra.type==Zebra2Old.VLINE){
				boxBg.addUser(new RotaterG2(this));
			}else{
				boxBg.addUser(new MoverG(this));
			}
			
//			actor.zbox.move(200,0);
		}
		
		public function dispose():void{
			gl.node.removeChild(ruler.node);
//			root.dispose();
			GTexture.getTextureById("ruler").dispose();
//			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clear():void{
			actor.zbox.clear();
		}
		
		public function enterFrame():void
		{
//			if(root!=null)
//				root.enterFrame();
		}
		
	}
}