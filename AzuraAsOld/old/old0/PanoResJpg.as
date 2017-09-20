package pano.res
{
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.SkyBox;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.resources.TextureResource;
	
	import azura.gallerid.Gal_Http2;
	
	import common.async2.Async2;
	import common.collections.ZintBuffer;
	
	import flash.display.BitmapData;
	
	import spark.components.Alert;
	
	public class PanoResJpg
	{
		{Async2.newSequence().order(SideLoaderJpg,6);}
		
		private var ret:Function;
		private var side:int;
		private var direction_platform:Vector.<String>;
		private var bdList:Vector.<TextureMaterial>;
		private var loading:Boolean;
		
		public function PanoResJpg(ret_SkyBox:Function)
		{
			this.ret=ret_SkyBox;
		}
		
		public function load(md5:String):Boolean{
			if(loading)
				return false;
			
			loading=true;
			direction_platform=new Vector.<String>();
			bdList=new Vector.<TextureMaterial>(6);
			side=0;
			
			new Gal_Http2(md5).load(ready);
			function ready(gh:Gal_Http2):void{
				var zb:ZintBuffer=gh.value as ZintBuffer;
				for(var i:int=0;i<6;i++){
					direction_platform.push(zb.readUTF());
				}
//				Alert.show("load content");
				loadContent();
			}
			
			return true;
		}
		
		private function loadContent():void{
			new SideLoaderJpg(direction_platform[0],0).load(sideLoaded);
			new SideLoaderJpg(direction_platform[1],1).load(sideLoaded);
			new SideLoaderJpg(direction_platform[2],2).load(sideLoaded);
			new SideLoaderJpg(direction_platform[3],3).load(sideLoaded);
			new SideLoaderJpg(direction_platform[4],4).load(sideLoaded);
			new SideLoaderJpg(direction_platform[5],5).load(sideLoaded);
		}
		
		private function sideLoaded(sl:SideLoaderJpg):void{
			side++;
			var bd:BitmapData=sl.value as BitmapData;
			var res:TextureResource=new BitmapTextureResource(bd);
			bdList[sl.id]=new TextureMaterial(res);
			if(side==6){
				loading=false;
				var sb:SkyBox= new SkyBox(3000,bdList[0],bdList[1],bdList[2],bdList[3],bdList[4],bdList[5],1/1025);
				ret.call(null,sb);
			}
		}
	}
}