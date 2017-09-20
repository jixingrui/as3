package azura.banshee.loaders.g2d.old
{
	import azura.common.algorithm.FastMath;
	import azura.common.async2.Async2;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import azura.banshee.loaders.g2d.LoaderG2d;
	import azura.banshee.loaders.g2d.PackG2d;
	
	public class SubTextureLoaderG2dOld extends LoaderG2d
	{
		private var atlasLoader:AtlasLoaderG2dOld;
		private var tex:GTexture;
		
		public function SubTextureLoaderG2dOld(pack:PackG2d)
		{
			super(pack);
		}
		
		override protected function getKey(pack:PackG2d):String{
			return FastMath.zeroPad(pack.piece.id)+pack.piece.mc5;
		}
		
		override public function process():void
		{
			atlasLoader=new AtlasLoaderG2dOld(pack);
			atlasLoader.load(onLoaded);
			
			function onLoaded(al:AtlasLoaderG2dOld):void{
				al.hold();
				var atlas:GTextureAtlas=al.value as GTextureAtlas;
				tex=atlas.addSubTexture(pack.piece.id.toString(),pack.piece.rectOnTexture);
				submit(tex);
			}
		}
		override public function dispose():void
		{
			tex.dispose();
//			atlasLoader.release(2000);
		}
		
	}
}