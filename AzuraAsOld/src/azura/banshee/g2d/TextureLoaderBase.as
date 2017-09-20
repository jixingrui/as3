package azura.banshee.g2d
{
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.common.async2.AsyncLoader2;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	
	public class TextureLoaderBase extends AsyncLoader2
	{
		protected var texture:GTexture;
		protected var atlas:GTextureAtlas;
		public var sheet:ZsheetOp;
		
		public function TextureLoaderBase(zt:ZsheetOp)
		{
			super(zt.me5);
			this.sheet=zt;
//			trace("loading: ",key,this);
//			hold(); ===== it is unknown if hold can be called before loaded
		}
		
		override public function dispose():void{
//			trace("disposed: ",key,this);
			sheet.nativeTexture=null;
			sheet=null;
			if(texture!=null){
				texture.dispose();
				texture=null;
			}
			if(atlas!=null){
				atlas.dispose();
				atlas=null;
			}
		}
	}
}