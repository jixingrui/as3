package azura.banshee.zanimal
{
	import old.azura.avalon.ice.g2d.StageG2dOld;
	import azura.avalon.ice.util.DragMoverG2d;
	import azura.avalon.mouse.MouseManager;
	import azura.banshee.zebra.ZebraPlate;
	import azura.banshee.zebra.zimage.Zimage;
	import azura.banshee.zplate.ZplateRoot;
	import azura.avalon.ice.g2d.ZebraRendererG2d;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	import azura.common.graphics.Draw;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;

	public class CanvasZanimalOld extends StageG2dOld
	{
		public var zcanvas:ZplateRoot;
		public var target:ZebraPlate;
		private var ruler:GSprite;
		
		public function CanvasZanimalOld(stage:Stage)
		{
//			super(stage);
			onInitialize.addOnce(onInit);
			onMouseDown.add(onMouseDownZebra);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			function onEnterFrame(e:Event):void{
				zcanvas.enterFrame();
			}
		}
		
		private function onMouseDownZebra(x:Number,y:Number):void{
			var angle:int=(FastMath.xy2Angle(x,y)+180)%360;
			target.rotation=angle;
		}
		
		protected function onInit():void{
			//ruler
			var bd:BitmapData=Draw.ruler(512,512);
			var ruler:GSprite=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			var tex:GTexture=GTextureFactory.createFromBitmapData("ruler",bd);
			ruler.texture=tex;
			nodeGame.addChild(ruler.node);
			
			//canvas
			var canvasG2d:ZebraRendererG2d=ZebraRendererG2d.create();
			nodeGame.addChild(canvasG2d.node);
			zcanvas=new ZplateRoot(canvasG2d,stage.stageWidth,stage.stageHeight);
			
//			var bgG2d:ZebraRendererG2d=GNodeFactory.createNodeWithComponent(ZebraRendererG2d) as ZebraRendererG2d;
			target=new ZebraPlate(zcanvas,canvasG2d.newInstance());
		}
				
		public function clear():void{
		}
	}
}