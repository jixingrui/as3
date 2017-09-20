package azura.banshee.zebra.editor.zforest.walk
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.editor.ZebraEditorShell;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.node.ZlineNode;
	import azura.banshee.zebra.zanimal.Zanimal;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Zforest;
	import azura.banshee.zforest.Ztree;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.algorithm.pathfinding.FpsWalkerOld;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	import azura.touch.TouchBox;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	
	public class LayerZforestWalk implements Stage3DLayerI,MotorI
	{
		public static var mouse_move:int=0;
		public static var mouse_check_path:int=1;
		
		private var gl:G2dLayer;
		
//		private var md:MouserDrag;
		
		public var root:Zspace;
		public var zforestNode:ZforestNode;
		
		public var avatar:ZebraNode;
		
		internal var zforest:Zforest=new Zforest();
		
		//		private var mm:MouseMove;
		//		private var mp:MousePath;
		
		private var box:TouchBox;
		
		private var motor:FpsWalkerOld;
		
		public var wayFinder:WayFinder;
		
		private var dotList:Vector.<ZboxOld>=new Vector.<ZboxOld>();
		
//		private var zrace:Zrace;
		public var zanimal:Zanimal=new Zanimal();
		
		public function LayerZforestWalk(gl:G2dLayer)
		{
			this.gl=gl;
			Stage3DRoot.singleton().addLayer(this);
			
			motor=new FpsWalkerOld(this);
			motor.stride=3;
			
			
			box=new TouchBox();
			box.box.width=Statics.stage.stageWidth;
			box.box.height=Statics.stage.stageHeight;			
			ZebraEditorShell.touchLayer.putBox(box);
			
			box.addUser(new PathG(this));
			
			//			mm=new MouseMove(this);
//			md=new MouserDrag(Statics.stage);
//			md.listener=new MousePath(this);
			//			mouseMode=mouse_move;
			
//			zrace=new Zrace();
		}
		
		public function init(stage:Stage):void{
			//canvas
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
			var scale:Number=1;
			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
			
			root=new Zspace(link,w,h);
			root.scaleLocal=scale;
			
			zforestNode=new ZforestNode(root.root);
		}
		
		public function loadZforest(data:ZintBuffer):void{
			clearDots();
			
			zforest.fromBytes(data);
			//			mm.bounder=new Bounder(Statics.stage.stageWidth,Statics.stage.stageHeight,zforest.land.boundingBox.width,zforest.land.boundingBox.height);
			wayFinder=new WayFinder(zforest.way,zforest.zbaseScale);
			
			zforestNode.zforest=zforest;
			zforestNode.reload();
			for each(var zitem:Ztree in zforest.ztreeList){
				var zn:ZebraNode=new ZebraNode(zforestNode.assLayer);
				zn.zebra=zitem.zebra;
				zn.move(zitem.zebra.x,zitem.zebra.y);
			}
			
			avatar =new ZebraNode(zforestNode.assLayer);
		}
		
		public function drawPoint(x:int,y:int,color:int,size:int=2):void{
			var dot:BitmapData=Draw.circle(size/root.root.scaleLocal,color);
			var z:Zebra=new Zebra();
			var zb:Zbitmap=new Zbitmap();
			zb.bitmapData=dot;
			z.branch=zb;
			var zn:ZebraNode=new ZebraNode(zforestNode.headLayer);
			zn.zebra=z;
			zn.move(x,y);
			dotList.push(zn);
		}
		
		public function walkAlong(path:Vector.<Point>):void
		{
			var i:int;
			for(i=0;i<path.length-1;i++){
				drawLine(path[i].x,path[i].y,path[i+1].x,path[i+1].y);
			}
			for each(var p:Point in path){
				trace("path",p.x,p.y,this);
			}
			
			//			var motor
			//			motor.jump(path[0].x,path[0].y);
			//			motor.clear();
			if(motor.currentPoint!=null)
				path.shift();
			motor.goAlong(path);
		}
		
		public function drawLine(xStart:int,yStart:int,xEnd:int,yEnd:int,color:int=0xffff8800):void{
			var thick:int=4;
			var zn:ZlineNode=new ZlineNode(zforestNode.footLayer);
			zn.draw(color,thick);
			zn.moveLine(xStart,yStart,xEnd,yEnd);
			
			dotList.push(zn);
			
			drawPoint(xEnd,yEnd,color,2);
		}
		
		public function jumpTo(x:int, y:int):void
		{
			//			trace("look at",x,y,this);
			avatar.move(x,y);
			root.lookAt(x,y);
		}
		
		public function turnTo(angle:int):int
		{
			return avatar.angle=angle;
		}
		
		public function go():void
		{
			avatar.zebra=zanimal.getZebra("go");
		}
		
		public function stop():void
		{
			avatar.zebra=zanimal.getZebra('idle');
		}
		
		public function enterFrame():void{
			motor.tick();
			root.enterFrame();
		}
		
		public function clearDots():void{
			//			trace("clear dots");
			for each(var dot:ZboxOld in dotList){
				dot.dispose();
			}
			dotList=new Vector.<ZboxOld>();
		}
		
		public function clear():void{
			clearDots();
			zforestNode.clear();
		}
		
		public function dispose():void
		{
			clearDots();
//			md.dispose();
			box.dispose();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
	}
}