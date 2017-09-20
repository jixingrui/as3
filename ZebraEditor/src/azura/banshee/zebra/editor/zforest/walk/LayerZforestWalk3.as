package azura.banshee.zebra.editor.zforest.walk
{
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.zbox3.editor.EditorCanvas3;
	import azura.banshee.zbox3.editor.PageI3;
	import azura.banshee.zebra.editor.zforest.Zforest3;
	import azura.banshee.zebra.editor.zforest.ZforestC3;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.algorithm.pathfinding.FpsWalkerOld;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	
	public class LayerZforestWalk3 implements PageI3,MotorI
	{
		public static var mouse_move:int=0;
		public static var mouse_check_path:int=1;
		
		public var fc:ZforestC3;
		
		internal var zforest:Zforest3=new Zforest3();
		
		private var motor:FpsWalkerOld;
		
		public var wayFinder:WayFinder;
		
		public var ec:EditorCanvas3;
		
		public function LayerZforestWalk3()
		{
			motor=new FpsWalkerOld(this);
			motor.stride=3;
		}
		
		public function activate(ec:EditorCanvas3):void
		{
			this.ec=ec;
			fc=new ZforestC3(ec.space);
			ec.space.addGesture(new PathG3(this));
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