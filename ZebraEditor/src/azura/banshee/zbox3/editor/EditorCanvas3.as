package azura.banshee.zbox3.editor
{
	import azura.banshee.engine.starling_away.AwayLayer;
	import azura.banshee.engine.starling_away.StarlingAway;
	import azura.banshee.engine.starling_away.StarlingLayer;
	import azura.banshee.zbox3.Zspace3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.engine.Zbox3ReplicaStarling;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	public class EditorCanvas3
	{
		public var away:AwayLayer;
		public var starling:StarlingLayer;
		
		public var space:Zspace3;		
		
		public var hud:Zspace3;
		private var ruler:ZboxBitmap3;
		
		private var stage_:Stage;
		private var ready_:Function;
		
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
			
			var rep:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(sl.root);
			space=new Zspace3(rep);
			space.look(0,0,stage_.stageWidth,stage_.stageHeight);
			space.keepSorted=true;
			
			//ruler
			var repHud:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(sl.root);
			hud=new Zspace3(repHud);
			var rulerBd:BitmapData=Draw.ruler(stage_.stageWidth,stage_.stageHeight);
			ruler=new ZboxBitmap3(hud);
//			ruler.zbox.sortValue=int.MAX_VALUE;
			ruler.fromBitmapData(rulerBd);
			
			ready_.call();
		}
	}
}