package old.azura.avalon.ice.plain
{
	import old.azura.avalon.ice.dish.PyramidDish;
	import azura.banshee.zebra.zimage.large.PyramidZimage;
	import old.azura.avalon.ice.GenomeIceOld;
	
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	
	import flash.display.Stage;
	import flash.geom.Rectangle;

	public class Layer
	{
		public var dish_:PyramidZimage;
		private var user:LayerUserI;
		
		public function Layer(user:LayerUserI){
			this.user=user;
		}
		
		public function set dish(value:PyramidZimage):void
		{
			dish_ = value;
//			dish_.user=user;
			user.layer=this;
		}
		
		public function look(xfc:Number,yfc:Number):void{
			
			if(dish_==null)
				return;
			
			var levelScale:int=FastMath.pow2(dish_.zMax-user.level);
			var side:int=FastMath.pow2(user.level);
			
			xfc/=levelScale;
			yfc/=levelScale;
			
//			user.x=-256*side/2-xfc;
//			user.y=-256*side/2-yfc;
			
			if(dish_!=null){
								
				var vc:Rectangle=new Rectangle();
				vc.x=xfc;
				vc.y=yfc;
				vc.width=user.visualWidth;
				vc.height=user.visualHeight;
//				dish_.look(user.level,vc);
				
//				trace(vc.toString());
			}
		}
		
		public function clear():void{
			if(dish_!=null)
				dish_.clear();
			dish_=null;
			user.clear();
		}
	}
}