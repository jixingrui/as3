package azura.banshee.zbox3.engine
{
	import azura.banshee.engine.TextureResI;
	import azura.banshee.zbox3.LoadingTreeLoaderI;
	import azura.banshee.zbox3.LoadingTreeLoaderListenerI;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.banshee.zebra.data.wrap.Zframe2ListenerI;
	
	public class FrameCarrier implements LoadingTreeLoaderI,Zframe2ListenerI,TextureResI
	{
		public var frame:Zframe2;
		private var center_LT_:Boolean=true;
		
		private var listener:LoadingTreeLoaderListenerI;
		
		public function loadingTreeLoad(listener:LoadingTreeLoaderListenerI):void
		{
			this.listener=listener;
			frame.startUse(this);
		}
		
		public function notifyZframe2Loaded():void{
			listener.notifyLoadingTreeLoaded();
		}
		
		public function loadingTreeUnload():void
		{
			frame.endUse(this);
			frame=null;
//			loader=null;
			listener=null;
		}
		
		public function get resource():TextureResI
		{
			return this;
		}
		
		public function get texture():Object
		{
			return frame.nativeTexture;
		}
		
		public function get pivotX():Number
		{
			return frame.anchor.x;
		}
		
		public function get pivotY():Number
		{
			return frame.anchor.y;
		}
		
		public function get width():Number
		{
			return frame.rectOnSheet.width;
		}
		
		public function get height():Number
		{
			return frame.rectOnSheet.height;
		}
		
		public function get center_LT():Boolean
		{
			return center_LT_;
		}
		
		public function set center_LT(value:Boolean):void{
			center_LT_=value;
		}
//		public function get smoothing():Boolean
//		{
//			return _smoothing;
//		}
//		
//		public function set smoothing(value:Boolean):void
//		{
//			_smoothing = value;
//		}
		
	}
}