package azura.maze4
{
	import azura.banshee.animal.AnimalEditor;
	import azura.banshee.engine.starling_away.AwayLayer;
	import azura.banshee.engine.starling_away.StarlingAway;
	import azura.banshee.engine.starling_away.StarlingLayer;
	import azura.banshee.zbox3.Zspace3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.engine.Zbox3ReplicaStarling;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	public class Maze4Canvas
	{
		public var away:AwayLayer;
		public var starling:StarlingLayer;
		
		public var space:Zspace3;		
		
		private var stage:Stage;
		private var ready_:Function;
		
		public var hud:Zspace3;
		private var ruler:ZboxBitmap3;
		
		public var landLayer:Zbox3Container;
		public var landImage:ZebraC3;
		
		public var groundLayer:Zbox3Container;
		public var itemImage:ZebraC3;
		
		public var dg:DragLook;
		public var dw:DragRotate;
		private var scroll_rotate:Boolean=true;
		
		public function init(stage:Stage,holder:DisplayObjectContainer,ready:Function):void
		{
			this.stage=stage;
			ready_=ready;
			StarlingAway.init(stage,holder,saReady);
		}
		
		public function changeMode():void{
			if(scroll_rotate)
				rotateMode();
			else
				scrollMode();
		}
		
		public function scrollMode():void{
			scroll_rotate=true;
			space.removeGestureAll();
			space.addGesture(dg)
		}
		
		public function rotateMode():void{
			if(scroll_rotate==false)
				return;
			
			space.look(itemImage.zbox.x,itemImage.zbox.y);
			scroll_rotate=false;
			space.removeGestureAll();
			space.addGesture(dw)
		}
		
		private function saReady():void{
			away=StarlingAway.addAwayLayer();
			StarlingAway.addStarlingLayer(starlingReady);
		}
		
		private function starlingReady(sl:StarlingLayer):void{
			this.starling=sl;
			
			var rep:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(sl.root);
			space=new Zspace3(rep);
			space.look(0,0,stage.stageWidth,stage.stageHeight);
			space.keepSorted=true;
			
			//ground
			landLayer=new Zbox3Container(space);
			landImage=new ZebraC3(landLayer.zbox);
			
			groundLayer=new Zbox3Container(space);
			itemImage=new ZebraC3(groundLayer.zbox);
			
			//ruler
			var repHud:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(sl.root);
			hud=new Zspace3(repHud);
			var rulerBd:BitmapData=Draw.ruler(stage.stageWidth,stage.stageHeight);
			ruler=new ZboxBitmap3(hud);
			//			ruler.zbox.sortValue=int.MAX_VALUE;
			ruler.fromBitmapData(rulerBd);
			
			dg=new DragLook(space);
			dw=new DragRotate(itemImage);
			scrollMode();
			
			ready_.call();
		}
		
		public function showAnimal(mc5:String,x:int,y:int,angle:int):void{
			itemImage.feedMc5(mc5);
			itemImage.zbox.x=x;
			itemImage.zbox.y=y;
			itemImage.zbox.angle=angle;
		}
		
		public function clearAnimal():void{
			itemImage.clear();
		}
		
		public function loadZebra(mc5:String):void{
			//			actor=new ZebraC3(space);
			landImage.feedMc5(mc5);
		}
		
		public function clear():void{
			if(landImage!=null)
				landImage.clear();
		}
	}
}