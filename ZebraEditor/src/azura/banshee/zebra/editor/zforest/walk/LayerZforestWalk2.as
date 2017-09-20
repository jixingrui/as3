package azura.banshee.zebra.editor.zforest.walk
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.editor.PageI2;
	import azura.banshee.zebra.editor.ZebraEditorShell;
	import azura.banshee.zebra.editor.zforest.Zforest2;
	import azura.banshee.zebra.editor.zforest.ZforestC2;
	import azura.banshee.zebra.editor.ztree.Ztree2;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.node.ZlineNode;
	import azura.banshee.zbox2.editor.EditorCanvas;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Ztree;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.algorithm.pathfinding.FpsWalkerOld;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	import azura.touch.TouchBox;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	
	public class LayerZforestWalk2 implements PageI2,MotorI
	{
		public static var mouse_move:int=0;
		public static var mouse_check_path:int=1;
		
		public var fc:ZforestC2;
		
		internal var zforest:Zforest2=new Zforest2();
		
		private var motor:FpsWalkerOld;
		
		public var wayFinder:WayFinder;
		
		public var ec:EditorCanvas;
		
		public function LayerZforestWalk2()
		{
			motor=new FpsWalkerOld(this);
			motor.stride=3;
		}
		
		public function activate(ec:EditorCanvas):void
		{
			this.ec=ec;
			fc=new ZforestC2(ec.space);
			ec.space.addGesture(new PathG2(this));
		}
		
		public function deactivate():void{
			ec.space.removeGestureAll();
		}
		
		public function loadZforest(data:ZintBuffer):void{
			
			zforest.fromBytes(data);
			//			mm.bounder=new Bounder(Statics.stage.stageWidth,Statics.stage.stageHeight,zforest.land.boundingBox.width,zforest.land.boundingBox.height);
			wayFinder=new WayFinder(zforest.way,zforest.zbaseScale);
			
			fc.zforest=zforest;
			fc.reload();
//			for each(var zitem:Ztree2 in zforest.ztreeList){
				//				var zn:ZebraNode=new ZebraNode(zforestNode.assLayer);
				//				zn.zebra=zitem.zebra;
				//				zn.move(zitem.zebra.x,zitem.zebra.y);
//			}
		}
		
		public function walkAlong(path:Vector.<Point>):void
		{
//			for each(var p:Point in path){
//				trace("path",p.x,p.y,this);
//			}
			
			if(motor.currentPoint!=null)
				path.shift();
			motor.goAlong(path);
		}
		
		public function jumpTo(x:Number, y:Number):void
		{
//			trace("look at",x,y,this);
			ec.space.look(x,y);
		}
		
		public function turnTo(angle:int):int
		{
			return angle;
		}
		
		public function go():void
		{
		}
		
		public function stop():void
		{
		}
		
		public function clear():void{
			fc.clear();
		}
	}
}