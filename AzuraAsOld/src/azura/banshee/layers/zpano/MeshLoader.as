package azura.banshee.layers.zpano
{
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	
	import azura.common.async2.AsyncLoader2;
	import azura.common.async2.AsyncLoader2I;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	public class MeshLoader extends AsyncLoader2 implements AsyncLoader2I
	{
		public function MeshLoader(mc5:String)
		{
			super(mc5);
		}
		
		public function get mc5():String{
			return key as String;
		}
		
		public function get mesh():Mesh{
			return value as Mesh;
		}
		
		override public function process():void
		{
			Gallerid.singleton().getData(mc5).onReady.add(fileReady);
			function fileReady(item:GalMail):void{
				AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, assetReady);
				AssetLibrary.loadData(item.dataClone());
			}
			function assetReady(event:AssetEvent):void
			{
//				trace(this,event.asset.assetType);
				if (event.asset.assetType == AssetType.MESH) {
					AssetLibrary.removeEventListener(AssetEvent.ASSET_COMPLETE, assetReady);
					
					var mesh:Mesh = event.asset as Mesh;
//					mesh=mesh.clone() as Mesh;
					submit(mesh);
				}
			}
		}
		
		override public function dispose():void
		{
			mesh.dispose();
		}
	}
}