package azura.banshee.zbox3
{
	import azura.banshee.mass.view.MassTreeNV2;
	import azura.common.collections.RectC;
	import azura.touch.TouchBox;
	import azura.touch.TouchUserI;
	import azura.touch.gesture.GestureI;
	
	public class Zbox3Touch extends Zbox3Show implements TouchUserI	
	{
		public function Zbox3Touch(key:PrivateLock, parent:Zbox3)
		{
			super(key, parent);
		}
		
		//touch: to match touch with visual, use pivot
		private var touchBox_:TouchBox;
		public var touchDX:Number=0;
		public var touchDY:Number=0;
		
		private var _isIntercept:Boolean;
		
		public function get intercept():Boolean
		{
			return _isIntercept;
		}

		public function set intercept(value:Boolean):void
		{
			_isIntercept = value;
			if(value)
				touchBox;
		}

		public function updateTouch():void{
			if(touchBox_!=null){
				touchBox_.range=touchBoxRes;
				touchBox_.updatePos();
			}
		}
		
		public function get touchBoxRes():RectC{
			var rc:RectC=new RectC();
			rc.width=width;
			rc.height=height;
			rc.xc=xGlobal+touchDX;
			rc.yc=yGlobal+touchDY;
			return rc;
		}
		
		private function get touchBox():TouchBox
		{
			if(touchBox_==null){
				touchBox_=new TouchBox(this);
				touchBox_.range=touchBoxRes;
				space.touchSpace.addBox(touchBox_);
			}
			return touchBox_;
		}
		
	
		public function sorter(oneB:TouchBox,twoB:TouchBox):int{
			var oneT:Zbox3Touch=oneB.user as Zbox3Touch;
			var twoT:Zbox3Touch=twoB.user as Zbox3Touch;
			var one:Vector.<int>=oneT.depthVector;
			var two:Vector.<int>=twoT.depthVector;
						
			for(var i:int=0;i<one.length;i++){
				var oneC:int=one[i];
				var twoC:int=-1;
				if(i<two.length)
					twoC=two[i];
				if(oneC<twoC)
					return -1;
				else if(oneC>twoC)
					return 1;
			}
			if(one.length==two.length)
				return 0;
			else
				return -1;
		}
		
		public function addGesture(user:GestureI):void{
			touchBox.addUser(user);
		}
		
		public function removeGesture(user:GestureI):void{
			touchBox.removeUser(user);
			checkRemoveTouch();
		}
		
		private function checkRemoveTouch():void{
			if(touchBox_.isEmpty && !intercept){
				space.touchSpace.removeBox(touchBox_);
				touchBox_=null;
			}
		}
		
		public function removeGestureAll():void{
			touchBox.removeAllUser();
			checkRemoveTouch();
		}
		
		//================== visible ===================
		override public function set visible(value:Boolean):void{
			super.visible=value;
			if(touchBox_!=null){
				touchBox_.enabled=value;
			}
		}
		
		//===================== override =================
		override public function changeViewBubbleDown():void{
			updateTouch();
			super.changeViewBubbleDown();
		}
		
		override public function dispose():void{
			if(touchBox_!=null){
//				space.touchSpace.removeBox(touchBox_);
				touchBox_.enabled=false;
				touchBox_=null;
			}
			super.dispose();
		}
	}
}