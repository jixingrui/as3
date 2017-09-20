package azura.banshee.layers
{
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.common.graphics.Draw;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	
	public class LayerRuler implements Stage3DLayerI
	{
		private var gl:G2dLayer;
		private var root:Zspace;
		private var ruler:GSprite;
		
		public var canvas:ZboxOld;
		
		public function LayerRuler(gl:G2dLayer)
		{
			this.gl=gl;
			Stage3DRoot.singleton().addLayer(this);
		}
				
		public function init(stage:Stage):void{
			//ruler
			var bd:BitmapData=Draw.ruler(512,512);
			ruler=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			var tex:GTexture=GTextureFactory.createFromBitmapData("ruler",bd);
			ruler.texture=tex;
			gl.node.addChild(ruler.node);
			
			//canvas
			var canvasG2d:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(canvasG2d.node);
			root=new Zspace(canvasG2d,Stage3DRoot.singleton().stage.stageWidth,
				Stage3DRoot.singleton().stage.stageHeight);
			
			//zebra
			canvas=new ZboxOld(root.root);
		}
		
		public function dispose():void{
			root.dispose();
			GTexture.getTextureById("ruler").dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clear():void{
			canvas.dispose();
			canvas=new ZebraNode(root.root);
		}
		
		public function resize(width:int, height:int):void{
			
		}
		public function enterFrame():void
		{
			root.enterFrame();
		}
		
//		public function get priority():int
//		{
//			return 0;
//		}
		
//		public function get active():Boolean{
//			return true;
//		}
	}
}