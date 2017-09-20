package azura.banshee.zebra.zode
{
	import azura.banshee.zebra.zode.i.ZRnodeI;
	import azura.common.collections.BoxC;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GestureI;
	
	import flash.geom.Point;
	
	/**
	 * 
	 * Zbox is a container, which does not display any image. The attached Zshard displays. 
	 * The tree structure defined by Zbox is synchronized with ZRnodeI and Zbox.
	 * Zbox cannot be moved within the tree structure.
	 * 
	 */
	public class ZboxOld 
	{
		public var space:Zspace;
		protected var parent:ZboxOld;
		public var renderer:ZRnodeI;
		
		public var box:BoxC=new BoxC();
		public var posParentCache:Point=new Point();
		
		public var touchBox:TouchBox;
		public var sortEnabled:Boolean=false;
		
		private var childList:Vector.<ZboxOld>=new Vector.<ZboxOld>();
		internal var shardList:Vector.<Zshard>=new Vector.<Zshard>();
		
		public function ZboxOld(parent:ZboxOld=null)
		{
			//			touchBox=new TouchBox();
//			touchBox.box=box.bb;
			
			//			if(this is Zspace){
			//				space=this as Zspace;
			//				return;
			//			}
			//			
			//			if(parent==null){
			//				throw new Error("parent cannot be null");
			//			}
			
			if(parent==null)
				return;
			
			this.parent=parent;
			space=parent.space;
			renderer=parent.renderer.newChild();
			parent.childList.push(this);
			
			posParentCache.x=parent.xGlobal;
			posParentCache.y=parent.yGlobal;
		}
		
		public function get xGlobal():Number{
			return posParentCache.x+box.pos.x;
		}
		
		public function get yGlobal():Number{
			return posParentCache.y+box.pos.y;
		}
		
		//=================== touch =====================
		
		public function set user(value:GestureI):void
		{
			if(value!=null){
//				if(touchBox.active==false){				
//					space.touchLayer.putBox(touchBox);
//					updateTouch();
//				}
				touchBox.addUser(value);
			}else if(touchBox!=null){
				touchBox.dispose();
			}
		}
		
		public function updateTouch():void{
//			if(touchBox.active==false)
//				return;
//			
//			touchBox.box.xc=xGlobal;
//			touchBox.box.yc=yGlobal;
//			touchBox.updatePos();
		}
		
		//=================== display ===============
		
		
		/**
		 *
		 * The caller is responsible for releasing. 
		 * 
		 */
		public function loadTexture(zt:ZsheetOp):void{
			renderer.load(zt);
		}
		
		public function updateVisual():void{
			for each(var zi:ZboxOld in childList){
				zi.updateVisual();
			}
		}
		
		public function enterFrame():void{
			renderer.enterFrame();
			for each(var child:ZboxOld in childList){
				child.enterFrame();
			}
		}
		
		public function set visible(value:Boolean):void{
			renderer.visible=value;
		}
		
		
		/**
		 * 
		 * @param x local
		 * @param y local
		 * 
		 */
		public function move(x:Number,y:Number):void{
			box.pos.x=x;
			box.pos.y=y;
			
			renderer.move(x,y,y);
			
			if(parent!=null&&parent.sortEnabled)
				parent.renderer.sortChildren();
			
			movedDeep();
		}
		
		private function movedDeep():void{
			updateTouch();
			for each(var child:ZboxOld in childList){
				child.posParentCache.x=xGlobal;
				child.posParentCache.y=yGlobal;
				child.movedDeep();
			}
		}
		
		public function sort():void{
			renderer.sortChildren();
		}
		
		//=================== remove ==============
		
		public function removeChild(child:ZboxOld):void{
			var idx:int=childList.indexOf(child);
			if(idx==-1)
				throw new Error();
			childList.splice(idx,1);
		}
		
		public function removeDisplay(zd:Zshard):void{
			var idx:int=shardList.indexOf(zd);
			if(idx==-1)
				throw new Error();
			shardList.splice(idx,1);
		}
		
		public function clear():void{
			var sp:Zshard;
			var child:ZboxOld;
			var spriteRef:Vector.<Zshard>=new Vector.<Zshard>();
			var childRef:Vector.<ZboxOld>=new Vector.<ZboxOld>();
			for each(sp in shardList){
				spriteRef.push(sp);
			}
			for each(child in childList){
				childRef.push(child);
			}
			for each(sp in spriteRef){
				sp.dispose();
			}
			for each(child in childRef){
				child.dispose();
			}
		}
		
		public function dispose():void{
			this.clear();
			
			touchBox.dispose();
			
			if(!(this is Zspace)){
				if(parent==null)
					throw new Error("duplicate dispose");
				
				//				trace("dispose",this);
				parent.removeChild(this);
				parent=null;				
			}
		}
		
		
		//================== scale ======================
		public var scaleUpper:Number=1;
		protected var scaleLocal_:Number=1;
		
		public function get scaleGlobal():Number{
			if(parent==null)
				return scaleLocal_;
			else
				return scaleLocal_*parent.scaleGlobal;
		}
		
		public function get scaleLocal():Number
		{
			return scaleLocal_;
		}
		
		public function set scaleLocal(value:Number):void
		{
			scaleLocal_ = value;
			renderer.scaleX=scaleLocal;
			renderer.scaleY=scaleLocal;
			scaleBubble();
		}
		
		private function scaleBubble():void{
			scaleChange(scaleGlobal);
			for each(var child:ZboxOld in childList){
				child.scaleBubble();
			}
		}
		
		protected function scaleChange(scaleGlobal:Number):void{
			
		}
	}
}
