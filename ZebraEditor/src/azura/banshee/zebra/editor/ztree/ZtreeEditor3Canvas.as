package azura.banshee.zebra.editor.ztree
{
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.editor.EditorCanvas3;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.Zebra3;
	import azura.common.collections.RectC;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.bitset.BitSet;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class ZtreeEditor3Canvas
	{
		public var downScreen:Point;
		public var downRoot:Point;
		
		public var base:ZboxBitmap3;
		public var actor:ZebraC3;
		public var cross:ZboxBitmap3;
		
		private var bdBase:BitmapData;
		
		public var ztree:Ztree3=new Ztree3();
		
		private var ec:EditorCanvas3;
		
		public function activate(ec:EditorCanvas3):void
		{
			this.ec=ec;
			base=new ZboxBitmap3(ec.space);
			actor=new ZebraC3(ec.space);
			cross=new ZboxBitmap3(ec.space);
			base.zbox.sortValue=-1;
			actor.zbox.sortValue=1;
			cross.zbox.sortValue=2;
			
			cross.fromBitmapData(Draw.cross(15,15,3));
		}
		
		public function deactivate():void{
			base.zbox.dispose();
			actor.zbox.dispose();
			cross.zbox.dispose();
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
			sprite.graphics.endFill();
			bdBase.draw(sprite);
			base.fromBitmapData(bdBase);
		}
		
		public function save():Ztree3{
			ztree.zbase.clear();
			for(var i:int=0;i<bdBase.width;i++)
				for(var j:int=0;j<bdBase.height;j++){
					var color:int=bdBase.getPixel(i,j)&0x00ffffff;
					ztree.zbase.push(color!=0xffffff);
				}
			return ztree;
		}
		
		public function set mode(idx:int):void{
			base.zbox.removeGestureAll();
			if(idx==0){
			}else if(idx==1){
				base.zbox.addGesture(new PainterG3(this));
			}else if(idx==2){
				base.zbox.addGesture(new EraserG3(this));
			}else if(idx==3){
				base.zbox.addGesture(new SetRootG3(this));
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
			base.fromBitmapData(bdBase);
			cross.zbox.move(ztree.rootX,ztree.rootY);
		}
		
		public function loadZebra(zebra:Zebra3):void{
			cross.zbox.move(0,0);
			
			ztree.zebra=zebra;
			actor.feedZebra(zebra);
			
			var w:int=Math.max(1,zebra.boundingBox.width);
			var h:int=Math.max(1,zebra.boundingBox.height);
			bdBase=new BitmapData(w,h,false,0xffffff);			
			base.fromBitmapData(bdBase);
		}
		
	}
}