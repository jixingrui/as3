package azura.avalon.maze.ui
{
	import spark.components.BusyIndicator;
	import spark.components.IconItemRenderer;
	
	public class LoadingItemRenderer extends IconItemRenderer
	{
		protected var busyIndicator : BusyIndicator;
		
		public function LoadingItemRenderer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			busyIndicator = new BusyIndicator();
			busyIndicator.width = 25;
			busyIndicator.height = 25;
			addChild( busyIndicator );
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			busyIndicator.x = w - (busyIndicator.width+10);
			busyIndicator.y = (h - busyIndicator.height)/2;
			super.updateDisplayList(w,h);
			this.graphics.clear();
			this.graphics.beginFill( 0xFFFFCC );
			this.graphics.drawRect( 0,0,w,h );
		}
	}
}