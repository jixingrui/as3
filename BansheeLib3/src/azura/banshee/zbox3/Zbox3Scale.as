package azura.banshee.zbox3
{
	import azura.banshee.mass.view.p.MassTreeNVP2;
	import azura.common.collections.RectC;
	
	public class Zbox3Scale extends Zbox3Touch
	{
		private var scaleParent_:Number=1;
		protected var scaleLocal_:Number=1;
		private var _scaleFix:Number=1;
		
		public function Zbox3Scale(key:PrivateLock, parent:Zbox3)
		{
			super(key, parent);
			if(parent==null)
				return;
			
			scaleParent_=parent.scaleGlobal;
		}
		
		public function set scaleLocal(value:Number):void{
			if(scaleLocal_==value){
				//				trace("warning: scale no change",this);
				return;
			}
			
			scaleLocal_=value;
			updateTouch();
			updateScale();
			changeViewBubbleDown();
		}
		
		public function get scaleLocal():Number{
			return scaleLocal_;
		}
		
		public function get scaleFix():Number
		{
			return _scaleFix;
		}
		
		public function set scaleFix(value:Number):void
		{
			_scaleFix = value;
			replica.scaleX=scaleLocal_*scaleFix;
			replica.scaleY=scaleLocal_*scaleFix;
//			updateScale();
		}
		
		private function updateScale():void{
			replica.scaleX=scaleLocal_*scaleFix;
			replica.scaleY=scaleLocal_*scaleFix;
			changeScaleBubbleDown();
		}
		
		public function get scaleGlobal():Number{
			return scaleParent_*scaleLocal_;
		}
		
		private function changeScaleBubbleDown():void{
			controller.notifyChangeScale();
			for each(var child:Zbox3Scale in childList){
				child.scaleParent_=scaleGlobal;
				child.xParent_=xGlobal;
				child.yParent_=yGlobal;
				child.changeScaleBubbleDown();
			}
		}
		
		public function stretchTo2(width:int,height:int):void{
			var scaleX:Number=width/this.width;
			var scaleY:Number=height/this.height;
			this.replica.scaleX=scaleX;
			this.replica.scaleY=scaleY;
		}
		
		public function stretchTo1(width:int,height:int):void{
			var imageRatio:Number=this.width/this.height;
			var boxRatio:Number=width/height;
			var scale:Number=1;
			if(imageRatio>=boxRatio){
				//fit width
				scale=width/this.width;
			}else{
				//fit height
				scale=height/this.height;
			}
			this.scaleLocal=scale;
		}
		
		public function noStretch():void{
			this.replica.scaleX=1;
			this.replica.scaleY=1;
		}
		
		//================== override ===============
		override public function get touchBoxRes():RectC{
			var rc:RectC=new RectC();
			rc.width=width*scaleGlobal;
			rc.height=height*scaleGlobal;
			rc.xc=xGlobal+touchDX;
			rc.yc=yGlobal+touchDY;
			//			var c:MassTreeNVP2=Zbox3(this).controller as MassTreeNVP2;
			//			if(c!=null)
			//				trace("touch box left=",rc.left,"right=",rc.right,rc.toString(),c.model.path,this);
			return rc;
		}
		
		override public function get xGlobal():Number{
			return xParent_+x_*scaleGlobal;
		}
		override public function get yGlobal():Number{
			return yParent_+y_*scaleGlobal;
		}
	}
}