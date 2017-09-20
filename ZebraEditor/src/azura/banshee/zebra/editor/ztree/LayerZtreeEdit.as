package azura.banshee.zebra.editor.ztree
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.editor.ZebraEditorShell;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Ztree;
	import azura.common.collections.BitSet;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	import azura.touch.TouchBox;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class LayerZtreeEdit implements Stage3DLayerI
	{
		private var gl:G2dLayer;
		public var root:Zspace;
		
		public var downScreen:Point;
		public var downRoot:Point;
		
		public var base:ZebraNode;
		private var ruler:ZebraNode;
		public var actor:ZebraNode;
		public var cross:ZebraNode;
		
		private var bdBase:BitmapData;
		
		public var ztree:Ztree=new Ztree();
		
		private var box:TouchBox;
		
		public function LayerZtreeEdit(gl:G2dLayer)
		{
			this.gl=gl;
			Stage3DRoot.singleton().addLayer(this);
			
			box=new TouchBox();
			box.box.width=Statics.stage.stageWidth;
			box.box.height=Statics.stage.stageHeight;			
			ZebraEditorShell.touchLayer.putBox(box);
			
			mode=0;
		}
		
		public function init(stage:Stage):void
		{
			//canvas
			var canvasG2d:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(canvasG2d.node);
			root=new Zspace(canvasG2d,Statics.stage.stageWidth,
				Statics.stage.stageHeight);
			
			base=new ZebraNode(root.root);
			ruler=new ZebraNode(root.root);
			actor=new ZebraNode(root.root);
			cross=new ZebraNode(root.root);
			
			//ruler
			var bd:BitmapData=Draw.ruler(512,512);
			feed(bd,ruler);
			
			//cross
			bd=Draw.cross(50,10);
			feed(bd,cross);
		}
		
		
		private function feed(bd:BitmapData,target:ZebraNode):void{
			var z:Zebra=new Zebra();
			var zb:Zbitmap=new Zbitmap();
			zb.bitmapData=bd;
			z.branch=zb;
			target.zebra=z;
		}
		
		public var penThick:int=8;
		public function paint(x:int,y:int,color:int):void{
			var sprite:Sprite=new Sprite();
			sprite.graphics.beginBitmapFill(bdBase);
			sprite.graphics.endFill();
			sprite.graphics.beginFill(color);
			sprite.graphics.drawCircle(bdBase.width/2+x,bdBase.height/2+y,penThick);
			bdBase.draw(sprite);
			feed(bdBase,base);
		}
		
		public function save():Ztree{
			ztree.zbase.clear();
			for(var i:int=0;i<bdBase.width;i++)
				for(var j:int=0;j<bdBase.height;j++){
					var color:int=bdBase.getPixel(i,j)&0x00ffffff;
					ztree.zbase.push(color!=0xffffff);
				}
			return ztree;
		}
		
		public function set mode(idx:int):void{
			if(idx==0){
//				box.user=null;
			}else if(idx==1){
				box.addUser(new PainterG(this));
			}else if(idx==2){
				box.addUser(new EraserG(this));
			}else if(idx==3){
				box.addUser(new SetRootG(this));
			}
		}
		
		public function loadZitem(zb:ZintBuffer):void{
			ztree.fromBytes(zb);
			
			loadZebra(ztree.zebra);
			var bs:BitSet=ztree.zbase.toBitSet();
			var bb:Rectangle=ztree.zebra.boundingBox;
			for(var i:int=0;i<bb.width;i++)
				for(var j:int=0;j<bb.height;j++){
					var idx:int=i*bb.height+j;
					if(bs.getBitAt(idx))
						bdBase.setPixel(i,j,0x0);
				}
			feed(bdBase,base);
			cross.move(ztree.rootX,ztree.rootY);
		}
		
		public function loadZebra(zebra:Zebra):void{
			cross.move(0,0);
			
			ztree.zebra=zebra;
			actor.zebra=zebra;
			
			var w:int=Math.max(1,zebra.boundingBox.width);
			var h:int=Math.max(1,zebra.boundingBox.height);
			bdBase=new BitmapData(w,h,false,0xffffff);			
			feed(bdBase,base);
			
		}
		
		public function enterFrame():void
		{
			root.enterFrame();
		}
		public function clear():void{
		}
		public function dispose():void{
			box.dispose();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
	}
}