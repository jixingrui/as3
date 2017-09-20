package azura.banshee.loaders.g2d
{
	import old.azura.banshee.naga.Frame;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	
	import azura.common.async2.AsyncLoader2;
	import azura.common.util.OS;
	
	import flash.geom.Rectangle;
	
	public class FrameLoaderG extends AsyncLoader2
	{
		private var al:AtfAtlasLoaderG;
		
		public function FrameLoaderG(frame:Frame)
		{
			super(frame);//loadNow,syncReturn);
		}
		
		public function get frame():Frame{
			return key as Frame;
		}
		
		override public function process():void
		{
			al=new AtfAtlasLoaderG(frame.md5Sheet[OS.ordinal]);
			al.load(sheetLoaded);
			function sheetLoaded(al:AtfAtlasLoaderG):void{
				al.hold();
				var region:Rectangle=new Rectangle(frame.xOnSheet,frame.yOnSheet,frame.width,frame.height);
				var atlas:GTextureAtlas=al.value as GTextureAtlas;
				
				var sid:String=atlas.getId()+"_"+frame.idx.toString();
				var frameTex:GTexture=GTexture.getTextureById(sid);
				if(frameTex==null){
					frameTex=atlas.addSubTexture(frame.idx.toString(),region,-frame.width/2,-frame.height/2);
					
//					trace("texture create: "+frameTex.getId());
				}
				
				submit(frameTex);
			}
		}
		
		override public function dispose():void
		{
			al.release(30000);
		}
	}
}