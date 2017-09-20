package azura.banshee.maze.zebra
{
	import azura.avalon.ice.g2d.old.StageG2dOld;
	import azura.avalon.ice.layers.GroundItem;
	import azura.avalon.mouse.MouseDummy;
	import azura.avalon.mouse.MouseManager;
	import azura.avalon20.layers.EditorSwampI;
	import azura.banshee.maze.zimage.door.DraggerZebra;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.ZebraPlate;
	import azura.banshee.zplate.Zcanvas;
	import azura.avalon.ice.g2d.ZebraRendererG2d;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid.gal.Gal;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	public class CanvasZebraOld extends StageG2dOld implements EditorSwampI
	{
		public var canvas:Zcanvas;
		public var bg:ZebraPlate;
		public var doorIcon:ZebraPlate;
		
		private var dd:DraggerZebra;
		
		private var downPos:Point;
		private var downGlobal:Point;
		
		private var dummy:MouseDummy=new MouseDummy();
		
		public function CanvasZebraOld(stage:Stage)
		{
			super(stage);
			onInitialize.addOnce(onInit);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			function onEnterFrame(e:Event):void{
				canvas.enterFrame();
			}
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onPress);
		}
		protected function onPress(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.LEFT:
				{
					doorIcon.rotation++;
					break;
				}
				case Keyboard.RIGHT:
				{
					doorIcon.rotation--;
					break;
				}
				default:
				{
					break;
				}
			}
			//			source.tilt=mesh.rotationX;
			//			source.pan=mesh.rotationY;
			//			source.roll=mesh.rotationZ;
		}
		
		protected function onInit():void{
			//			trace("zebra layer init");
			//canvas
			var canvasG2d:ZebraRendererG2d=ZebraRendererG2d.create();
			nodeGame.addChild(canvasG2d.node);
			canvas=new Zcanvas(canvasG2d,stage.stageWidth,stage.stageHeight);
			
			//zebra
			bg=new ZebraPlate(canvas,canvasG2d.newInstance());
			doorIcon=new ZebraPlate(canvas,canvasG2d.newInstance());
			
			dd=new DraggerZebra(canvas,doorIcon);
		}
		
		
		public function editItem(item:GroundItem):void
		{
			if(item.md5!=null&&item.md5.length>0){
				
				canvas.move(item.x,item.y);
				canvas.lookAt(item.x,item.y);
				
				Gal.getData(item.md5,ret);
				function ret(ba:ByteArray):void{
					var zb:ZintBuffer=new ZintBuffer(ba);
					zb.uncompress();
					
					var z:Zebra=new Zebra();
					z.fromBytes(zb);
					doorIcon.data=z;
					doorIcon.move(item.x,item.y);
					doorIcon.rotation=item.pan;
				}
			}
		}
		
		public function showItems(list:Vector.<GroundItem>):void
		{
		}
		
		public function clear():void
		{
			doorIcon.renderer.unregister();
			//			bg.dispose();
			//			doorIcon.dispose();
			
			this.onMouseDown.removeAll();
			this.onMouseMove.removeAll();
			this.onMouseUp.removeAll();
		}
		
		public function unclear():void{
			doorIcon.renderer.register(dd);
			
			this.onMouseDown.add(dragStart);
			this.onMouseMove.add(dragMove);
			this.onMouseUp.add(dragEnd);
		}
		
		public function dragStart(x:int, y:int):void
		{	
			MouseManager.singleton().mouseDown(dummy,x,y);
			downPos=new Point(x,y);
			downGlobal=new Point(canvas.xLocal,canvas.yLocal);
		}
		
		public function dragMove(x:int, y:int):void
		{
			MouseManager.singleton().mouseMove(dummy,x,y);
			if(downPos==null)
				return;
			
			var dx:Number=x-downPos.x;
			var dy:Number=y-downPos.y;
			canvas.move(downGlobal.x-dx,downGlobal.y-dy);
			canvas.lookAt(canvas.xLocal,canvas.yLocal);
		}
		
		public function dragEnd(x:int, y:int):void
		{
			MouseManager.singleton().mouseUp(dummy,x,y);
			downPos=null;
		}
		
		public function set md5(value:String):void
		{
			Gal.getData(value,ret);
			function ret(ba:ByteArray):void{
				var zb:ZintBuffer=new ZintBuffer(ba);
				zb.uncompress();
				var zebra:Zebra=new Zebra();
				zebra.fromBytes(zb);
				bg.data=zebra;
			}
		}
	}
}