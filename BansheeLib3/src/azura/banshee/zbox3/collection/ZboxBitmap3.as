package azura.banshee.zbox3.collection
{
	import azura.banshee.engine.TextureResI;
	import azura.banshee.zbox3.LoadingTreeLoaderI;
	import azura.banshee.zbox3.LoadingTreeLoaderListenerI;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	
	public class ZboxBitmap3 extends Zbox3Container implements LoadingTreeLoaderI,TextureResI
	{
		private var bd:BitmapData;
		private var tex:Texture;
		
		public function ZboxBitmap3(parent:Zbox3)
		{
			super(parent);
		}
		
		public function fromBitmapData(bd:BitmapData,smoothing:Boolean=false):void{
			this.bd=bd;
			
			zbox.load(this);
		}
		
		public function loadingTreeLoad(listener:LoadingTreeLoaderListenerI):void
		{
			tex=Texture.fromBitmapData(bd);
			zbox.notifyLoadingTreeLoaded();
//			listener.notifyLoadingTreeLoaded();
		}
		
		public function get resource():TextureResI
		{
			return this;
		}
		
		public function loadingTreeUnload():void
		{
			tex.dispose();
		}
		
		public function get texture():Object
		{
			return tex;
		}
		
		public function get pivotX():Number
		{
			return 0;
		}
		
		public function get pivotY():Number
		{
			return 0;
		}
		
		public function get width():Number
		{
			return bd.width;
		}
		
		public function get height():Number
		{
			return bd.height;
		}
		
		public function get center_LT():Boolean
		{
			return true;
		}
	}
}