package azura.banshee.g2d
{
	import azura.banshee.layers.zpano.ZpanoLoader;
	import azura.common.async2.Async2;
	
	public final class LoaderInitializer {		
		private static var instance:LoaderInitializer = new LoaderInitializer();	
		public function LoaderInitializer() {			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" );
			Async2.newSequence(1).order(AtfAtlasLoaderGLand2).order(AtfAtlasLoaderGMask2);
			Async2.newSequence(1).order(AtfAtlasLoaderGAnimal2);
			Async2.newSequence(3).order(ZpanoLoader);
		}		
		public static function singleton():LoaderInitializer {			
			return instance;			
		}		
	}
}