package old.azura.banshee.zimage.plate
{
	import old.azura.banshee.zimage.i.ZrendererI;
	
	import flash.geom.Rectangle;

	public class ZplateCanvasOld extends ZplateOld
	{
		private var _zUp:int;
		public var screenWidth:int;
		public var screenHeight:int;
		
		public function ZplateCanvasOld(draw:ZrendererI)
		{
			super(null,draw);
		}
		
		override protected function get viewGlobal():Rectangle
		{
			return new Rectangle((xLocal>>_zUp)-screenWidth/2,(yLocal>>_zUp)-screenHeight/2,screenWidth,screenHeight);
		}

		override protected function get zUpInternal():Number
		{
			return _zUp;
		}
		
		public function get zUp():Number{
			return _zUp;
		}
		
		public function set zUp(value:Number):void
		{
			if(value<0)
				return;
			
			_zUp = value;
			super.zUpInternal=value;
		}
		
		/**
		 * 
		 * @param x on the bottom layer
		 * @param y on the bottom layer
		 * 
		 */
		public function look(x:int,y:int):void{
			xLocal=x;
			yLocal=y;
			move_();
			look_();
		}
		
		override protected function move_():void{
			renderer.put(-xLocal>>_zUp,-yLocal>>_zUp,-yLocal>>_zUp);
		}
		
		override public function get xGlobal():Number{
			return 0;
		}
		
		override public function get yGlobal():Number{
			return 0;
		}
	}
}