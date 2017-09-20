package azura.banshee.zbox2.editor
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dEngine;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.engine.starling_away.AwayLayer;
	import azura.banshee.engine.starling_away.StarlingAway;
	import azura.banshee.engine.starling_away.StarlingLayer;
	import azura.banshee.zbox2.Zspace2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.engine.g2d.Zbox2ReplicaG2d;
	import azura.banshee.zbox2.engine.starling.Zbox2ReplicaStarling;
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.common.graphics.Draw;
	import azura.touch.TouchBox;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	import starling.display.Sprite;
	
	public class EditorCanvas 
	{
		public var away:AwayLayer;
		public var starling:StarlingLayer;
		
		public var space:Zspace2;		
		public var ruler:ZebraC2;
		
		private var stage_:Stage;
		private var ready_:Function;
		
		public function EditorCanvas()
		{
		}
		
		public function init(stage:Stage,holder:DisplayObjectContainer,ready:Function):void
		{
			stage_=stage;
			ready_=ready;
			StarlingAway.init(stage,holder,saReady);
		}
		
		private function saReady():void{
			away=StarlingAway.addAwayLayer();
			StarlingAway.addStarlingLayer(starlingReady);
		}
		
		private function starlingReady(sl:StarlingLayer):void{
			this.starling=sl;
			var rep:Zbox2ReplicaStarling=new Zbox2ReplicaStarling(sl.root);
			space=new Zspace2(rep);
			space.viewSizeScaled(stage_.stageWidth,stage_.stageHeight);
			space.look(0,0);
			
			space.keepSorted=true;
			
			//ruler
			var rulerZ:Zebra2Old=new Zebra2Old();
			var rulerBd:BitmapData=Draw.ruler(stage_.stageWidth,stage_.stageHeight);
			rulerZ.fromBitmapData(rulerBd);
			ruler=new ZebraC2(space);
			ruler.sortValue=0;
			ruler.feed(rulerZ);
			
			ready_.call();
		}
		
	}
}