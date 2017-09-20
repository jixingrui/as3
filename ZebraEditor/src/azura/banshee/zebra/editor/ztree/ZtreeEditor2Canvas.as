package azura.banshee.zebra.editor.ztree
{
	import azura.banshee.zbox2.editor.EditorCanvas;
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.common.collections.BitSet;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.RectC;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class ZtreeEditor2Canvas
	{
		public var downScreen:Point;
		public var downRoot:Point;
		
		public var base:ZebraC2;
		public var actor:ZebraC2;
		public var cross:ZebraC2;
		
		private var bdBase:BitmapData;
		
		public var ztree:Ztree2=new Ztree2();
		
		private var ec:EditorCanvas;
		
		public function activate(ec:EditorCanvas):void
		{
			this.ec=ec;
			//			mode=0;
			base=new ZebraC2(ec.space);
			actor=new ZebraC2(ec.space);
			cross=new ZebraC2(ec.space);
			base.sortValue=-1;
			actor.sortValue=1;
			cross.sortValue=2;
		}
		
		public function deactivate():void{
			base.zbox.dispose();
			actor.zbox.dispose();
			cross.zbox.dispose();
		}
		
		private function feed(bd:BitmapData,target:ZebraC2):void{
			var z:Zebra2Old=new Zebra2Old();
			z.fromBitmapData(bd);
			target.feed(z);
			ec.space.sortOne(target.zbox);
		}
		
		public var penThick:int=16;
		public function paint(x:int,y:int,color:int):void{
			x+=bdBase.width/2;
			y+=bdBase.height/2;
			var sprite:Sprite=new Sprite();
			sprite.graphics.beginBitmapFill(bdBase);
			sprite.graphics.endFill();
			sprite.graphics.beginFill(color);
			sprite.graphics.drawCircle(x,y,penThick);
//			sprite.graphics.drawRect(x-penThick,y-penThick,penThick*2,penThick*2);
			sprite.graphics.endFill();
			bdBase.draw(sprite);
			feed(bdBase,base);
		}
		
		public function save():Ztree2{
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
				//				if(base!=null)
				base.zbox.removeGestureAll();
			}else if(idx==1){
				base.zbox.addGesture(new PainterG2(this));
				//				box.addUser(new PainterG(this));
			}else if(idx==2){
				base.zbox.addGesture(new EraserG2(this));
				//				box.addUser(new EraserG(this));
			}else if(idx==3){
				//				box.addUser(new SetRootG(this));
			}
		}
		
		public function loadZtree(zb:ZintBuffer):void{
			ztree.fromBytes(zb);
			
			loadZebra(ztree.zebra);
			var bs:BitSet=ztree.zbase.toBitSet();
			var bb:RectC=ztree.zebra.boundingBox;
			for(var i:int=0;i<bb.width;i++)
				for(var j:int=0;j<bb.height;j++){
					var idx:int=i*bb.height+j;
					if(bs.getBitAt(idx))
						bdBase.setPixel(i,j,0x0);
				}
			feed(bdBase,base);
			cross.zbox.move(ztree.rootX,ztree.rootY);
		}
		
		public function loadZebra(zebra:Zebra2Old):void{
			cross.zbox.move(0,0);
			
			ztree.zebra=zebra;
			actor.feed(zebra);
			
			var w:int=Math.max(1,zebra.boundingBox.width);
			var h:int=Math.max(1,zebra.boundingBox.height);
			bdBase=new BitmapData(w,h,false,0xffffff);			
			feed(bdBase,base);
		}
		
		//		public function enterFrame():void
		//		{
		//			space.enterFrame();
		//		}
		//		public function clear():void{
		//		}
		//		public function dispose():void{
		//			box.dispose();
		//			space.dispose();
		//			Stage3DRoot.singleton().removeLayer(this);
		//		}
	}
}