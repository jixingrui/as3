package azura.banshee.zbox3.collection
{
	import azura.banshee.engine.TextureResI;
	import azura.banshee.zbox3.LoadingTreeLoaderI;
	import azura.banshee.zbox3.LoadingTreeLoaderListenerI;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zebra.Zfont;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	
	public class ZboxText extends Zbox3Container implements TextureResI, LoadingTreeLoaderI
	{
		private var zfont:Zfont;
		private var bd:BitmapData;
		private var tex:Texture;
		
		public function ZboxText(parent:Zbox3)
		{
			super(parent);
		}
		
		public function fromFont(zfont:Zfont):void{
			this.zfont=zfont;
			zbox.load(this);
		}
		
		public function loadingTreeLoad(listener:LoadingTreeLoaderListenerI):void
		{
			bd=Draw.font(zfont);
			tex=Texture.fromBitmapData(bd);
			zbox.notifyLoadingTreeLoaded();
			listener.notifyLoadingTreeLoaded();
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