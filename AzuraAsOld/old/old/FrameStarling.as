package azura.banshee.naga.starling
{
	import azura.banshee.starling.ATF;
	
	import common.collections.LBSet;
	import common.collections.ZintBuffer;
	import common.loaders.AtfLoader;
	
	import flash.geom.Rectangle;
	
	import starling.textures.Texture;
	
	public class FrameStarling
	{
		private var xOnSheet:int, yOnSheet:int;
		private var width:int, height:int;
		public var xLeftTop:int, yLeftTop:int;
		public var xCenter:int, yCenter:int;
		private var md5Sheet:Vector.<String>=new Vector.<String>();
		private var lbs:LBSet;
		
		public var idx:int;
		private var loader:AtfLoader;		
		private var userList:Vector.<Function>=new Vector.<Function>();
		private var frameTexture:Texture;
		
		public function FrameStarling(idx:int,zb:ZintBuffer)
		{
			this.idx=idx;
			xOnSheet=zb.readZint();
			yOnSheet=zb.readZint();
			width=zb.readZint();
			height=zb.readZint();
			xLeftTop=zb.readZint();
			yLeftTop=zb.readZint();
			xCenter=zb.readZint();
			yCenter=zb.readZint();
			md5Sheet.push(zb.readUTF());
			md5Sheet.push(zb.readUTF());
			md5Sheet.push(zb.readUTF());
			lbs=new LBSet(zb.readBytes_());
		}
		
		public function loadTexture(call_Texture_frameIdx:Function,priority:Boolean):void{	
			if(call_Texture_frameIdx!=null)
				userList.push(call_Texture_frameIdx);
			check();
			if(loader!=null)
				return;
			
			loader=AtfLoader.load(md5Sheet[ATF._type],sheetLoaded,priority);
			function sheetLoaded(texSheet:Texture):void{
				var region:Rectangle=new Rectangle(xOnSheet,yOnSheet,width,height);
				frameTexture=Texture.fromTexture(texSheet,region);
				check();
			}
		}
		
		private function check():void{
			var user:Function;
			if(frameTexture!=null)
				while((user=userList.pop())!=null){
					user.call(null,frameTexture,idx);
				}
		}
		
		public function dispose():void{
			if(loader!=null){
//				loader.discard();
				loader=null;
			}
		}
	}
}
