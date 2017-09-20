package azura.banshee.layers
{
	import azura.banshee.door.Door;
	import azura.banshee.door.RoomWithDoors;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.mouse.MouseDUMI;
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Zforest;
	import azura.common.graphics.Draw;
	
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	public class LayerMiniMap implements Stage3DLayerI
	{
		private var gl:G2dLayer;
		
		public var root:Zspace;
		public var bg:ZebraNode;
		public var dot:ZebraNode;
		public var doorLayer:ZboxOld;
		
		private var downPos:Point;
		private var downGlobal:Point;
		
		public var scale:Number=1;
		
		public function LayerMiniMap(gl:G2dLayer,scale:Number)
		{
			this.gl=gl;
			this.scale=scale;
			Stage3DRoot.singleton().addLayer(this);
		}
		
		public function init(stage:Stage):void{
			//canvas
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
			var w:Number=Stage3DRoot.singleton().stage.stageWidth*0.75/scale;
			var h:Number=Stage3DRoot.singleton().stage.stageHeight*0.75/scale;
			
			root=new Zspace(link,w,h);
			root.scaleLocal=scale;
			//			root.renderer.alpha=0.4;
			
			bg=new ZebraNode(root.root);
			
			doorLayer=new ZboxOld(root.root);
			
			dot=new ZebraNode(doorLayer);
			var zo:Zbitmap=new Zbitmap();
			var side:int=16;
			if(Capabilities.screenDPI>400){
				side=32;
			}else if(Capabilities.screenDPI>200){
				side=24;
			}
			
			zo.bitmapData=Draw.focus(side,0xffff0000);
			var z:Zebra=new Zebra();
			z.branch=zo;
			dot.zebra=z;
			dot.scaleLocal=1/scale;
		}
		
		public function get x():int{
			return root.xView;
		}
		
		public function get y():int{
			return root.yView;
		}
		
		public function enterFrame():void{
			root.enterFrame();
		}
		
		public function get mouse():MouseDUMI{
			return null;
		}

		public function boot(zf:Zforest,rd:RoomWithDoors=null):void{
			bg.zebra=zf.land;
			
			if(rd!=null){
				for each(var d:Door in rd.doorList){
					showDoor(d);
				}
			}
		}
		
		public function lookAt(x:int,y:int):void{
			root.lookAt(x,y);
			dot.move(x,y);
		}
		
		public function showDoor(data:Door):void{
			var doorIcon:ZebraNode=new ZebraNode(doorLayer);
			
			//			doorIcon.move(data.x*scale,data.y*scale);
			doorIcon.move(data.x,data.y);
			doorIcon.angle=data.pan;
//			doorIcon.mc5=data.mc5;		
		}
		
		public function dispose():void
		{
			dot.dispose();
			doorLayer.dispose();
			bg.dispose();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clear():void{
			root.clear();
		}
		
		public function resize(width:int, height:int):void{
			
		}
	}
}