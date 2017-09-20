package azura.banshee.zebra.editor.zforest.check
{
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.engine.Statics;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.collection.ZboxLine3;
	import azura.banshee.zbox3.editor.EditorCanvas3;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.editor.zforest.Zforest3;
	import azura.banshee.zebra.editor.zforest.ZforestC3;
	import azura.banshee.zebra.editor.ztree.Ztree3;
	import azura.banshee.zebra.node.Bounder;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	
	public class LayerZforestCheck3
	{
		public static var mouse_move:int=0;
		public static var mouse_check_path:int=1;
		
//		private var gl:G2dLayer;
		
//		private var box:TouchBox;
		private var moverG:MoverG3;
		private var pathG:PathG3;
		
//		public var root:Zspace3;
		public var zforestNode:ZforestC3;
		
		public var avatar:ZebraC3;
		
		internal var zforest:Zforest3=new Zforest3();
		
		public var wayFinder:WayFinder;
		
		private var dotList:Vector.<Zbox3>=new Vector.<Zbox3>();
		
		internal var ec:EditorCanvas3;
		
		public function LayerZforestCheck3()
		{
			moverG=new MoverG3(this);
			pathG=new PathG3(this);
			mouseMode=mouse_move;
		}
		
		public function activate(ec:EditorCanvas3):void{
			zforestNode=new ZforestC3(ec.space);
		}
		
		public function loadZforest(data:ZintBuffer):void{
			clearDots();
			
			zforest.fromBytes(data);
			moverG.bounder=new Bounder(Statics.stage.stageWidth,Statics.stage.stageHeight,
				zforest.land.boundingBox.width,zforest.land.boundingBox.height);
			wayFinder=new WayFinder(zforest.way,zforest.zbaseScale);
			
			zforestNode.zforest=zforest;
			zforestNode.reload();
			for each(var zitem:Ztree3 in zforest.ztreeList){
				var zn:ZebraC3=new ZebraC3(zforestNode.assLayer.zbox);
				zn.zebra=zitem.zebra;
				zn.zbox.move(zitem.zebra.boundingBox.xc,zitem.zebra.boundingBox.yc);
			}
			
			avatar =new ZebraC3(zforestNode.assLayer.zbox);
		}
		
		public function drawPoint(x:int,y:int,color:int,size:int=2):void{
			var dot:BitmapData=Draw.circle(size/ec.space.scaleLocal,color);
//			var z:Zebra3=new Zebra3();
//			var zb:Zbitmap3=new Zbitmap3();
			var zb:ZboxBitmap3=new ZboxBitmap3(zforestNode.headLayer.zbox);
			zb.fromBitmapData(dot);
			zb.zbox.move(x,y);
//			zb.bitmapData=dot;
//			z.branch=zb;
//			var zn:ZebraC3=new ZebraC3(zforestNode.headLayer);
//			zn.zebra=z;
//			zn.move(x,y);
			dotList.push(zb.zbox);
		}
		
		public function drawLine(xStart:int,yStart:int,xEnd:int,yEnd:int,color:int=0xffff8800):void{
			var thick:int=4;
			var zn:ZboxLine3=new ZboxLine3(zforestNode.footLayer.zbox);
			zn.paint(color,thick);
			zn.draw(xStart,yStart,xEnd,yEnd);
			
			dotList.push(zn);
			
			drawPoint(xEnd,yEnd,color,2);
		}
		
		public function set mouseMode(mode:int):void{
//			if(mode==mouse_move){
//				zforestNode.zbox.addGesture(moverG);
//			}else if(mode==mouse_check_path){
//				zforestNode.zbox.addGesture(pathG);
//			}
		}
		
//		public function enterFrame():void{
//			root.enterFrame();
//		}
		
		public function clearDots():void{
			for each(var dot:Zbox3 in dotList){
				dot.dispose();
			}
			dotList=new Vector.<Zbox3>();
		}
		
		public function clear():void{
			clearDots();
			zforestNode.clear();
		}
		
//		public function dispose():void
//		{
//			clearDots();
//			box.dispose();
//			root.dispose();
//			Stage3DRoot.singleton().removeLayer(this);
//		}
	}
}