package
{
	public class ScreenResizer
	{
		public var scale:Number;
		public var dragWidth:Number;
		public var dragHeight:Number;
		
		private var designWidth:Number;
		private var designHeight:Number;
		
		public function ScreenResizer(designWidth:Number,designHeight:Number)
		{
			this.designWidth=designWidth;
			this.designHeight=designHeight;
		}
		
		public function display(screenWidth:Number,screenHeight:Number):void{
			var designRatio:Number=designWidth/designHeight;
			var screenRatio:Number=screenWidth/screenHeight;
			if(designRatio>=screenRatio){
				//fit width
				scale=screenWidth/designWidth;
				dragWidth=designWidth;
				dragHeight=designWidth/screenRatio;
			}else{
				//fit height
				scale=screenHeight/designHeight;
				dragHeight=designHeight;
				dragWidth=designHeight*screenRatio;
			}
		}
	}
}