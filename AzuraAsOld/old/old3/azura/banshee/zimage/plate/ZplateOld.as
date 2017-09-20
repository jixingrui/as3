package old.azura.banshee.zimage.plate
{
	import old.azura.banshee.zimage.i.ZrendererI;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class ZplateOld
	{
		public var parent:ZplateOld;
		protected var renderer:ZrendererI;
		private var component:ZplateOpI;
		
		/**
		 *relative to parent, on the bottom layer 
		 */
		public var xLocal:Number=0,yLocal:Number=0;
		
		private var child_child:Dictionary=new Dictionary();
		
		public function ZplateOld(parent:ZplateOld, renderer:ZrendererI)
		{
			this.renderer=renderer;
			if(parent==null && !(this is ZplateCanvasOld))
				throw new Error("Zplate: parent cannot be null");
			if(parent!=null)
				parent.addChild(this);
		}
		
		public function enterFrame():void{
			renderer.enterFrame();
			for each(var child:ZplateOld in child_child){
				child.enterFrame();
			}
		}
		
		private function addChild(child:ZplateOld):void{
			child_child[child]=child;
			child.parent=this;
			renderer.addChild(child.renderer);
			renderer.sortChildren();
		}
		
		public function removeChild(zp:ZplateOld):void{
			delete child_child[zp];
			renderer.removeChild(zp.renderer);
		}
		
		/**
		 * 
		 * relative to the canvas, on the bottom layer 
		 * 
		 */
		public function get xGlobal():Number{
			return parent.xGlobal+xLocal;
		}
		
		/**
		 * 
		 * relative to ZplateRoot 
		 * 
		 */
		public function get yGlobal():Number{
			return parent.yGlobal+yLocal;
		}
		
		/**
		 * 
		 * @param x as zUp==0
		 * @param y as zUp==0
		 * 
		 */
		public function move(x:Number,y:Number):void{
			this.xLocal=x;
			this.yLocal=y;
			move_();
		}
		
		protected function move_():void{
			var x:Number=xLocal>>zUpInternal;
			var y:Number=yLocal>>zUpInternal;
			renderer.put(x,y,y);
			parent.renderer.sortChildren();
		}
		
		protected function get zUpInternal():Number
		{
			return parent.zUpInternal;
		}
		
		/**
		 * 
		 * @param value [0,?]
		 * 
		 */
		protected function set zUpInternal(value:Number):void
		{
			move_();
			var scale:Number=1-(value-Math.floor(value));
			renderer.scale=scale;
			for each(var zi:ZplateOld in child_child){
				zi.zUpInternal=value;
			}
		}
		
		/**
		 *
		 * relative to canvas, on the current layer 
		 * 
		 */
		protected function get viewGlobal():Rectangle
		{
			return parent.viewGlobal;
		}
		
		protected function look_():void {
			for each(var zi:ZplateOld in child_child){
				zi.look_();
			}
		}
		
	}
}