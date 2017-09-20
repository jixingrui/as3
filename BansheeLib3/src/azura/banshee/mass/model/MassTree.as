package azura.banshee.mass.model
{
	import azura.banshee.mass.sdk.MassSdkI2;
	import azura.banshee.mass.sdk.MassSwitch2;
	import azura.banshee.mass.view.MassTreeSyncI;
	import azura.common.collections.BytesI;
	import azura.common.collections.Path;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4PackI;
	
	import flash.utils.Dictionary;
	
	public class MassTree implements BytesI,Gal4PackI
	{
		public static var formatVersion:int=2016083001;
		
		public var ss:ScreenSetting=new ScreenSetting();
		public var root:MassTreeN;		
		public var path_MassTreeN:Dictionary=new Dictionary();
		public var alias_path:Dictionary=new Dictionary();
		
		public var tunnel:MassTreeSyncI;
		public var user:MassSdkI2;
		public var receiver:MassTree;
		
		public function MassTree()
		{
			root=new MassTreeN(this);
			user=new MassSwitch2(".");
		}
		
		public function updateFrame():void{
			
		}
		
		//======================= display ===============
		public function setScreenSize(w:int,h:int):void{
			
		}
		
		//====================== action ================
		public function act(action:MassAction):void{
			
			if(action.isInternal()){
				if(action.targetPath.length==0){
					trace("error: action has empty target ==============",this);
					return;
				}				
				
				if(action.toType==MassAction.doSlap){
					activate(action.targetPath);
				}else if(action.toType==MassAction.doSpank){
					spank(action.targetPath);
					//					trace("spank",action.targetPath,this);
				}else if(action.toType==MassAction.doReset){
					clear(action.targetPath);
					//					trace("clear",action.targetPath,this);
				}
			}else{
				if(action.toType==MassAction.to_coder){ 
//					action.host.bookCoder(action);
				}else if(action.toType==MassAction.to_mass){
//					Toast.show("[mass]"+action.stringMsg);
					trace("[mass]"+action.stringMsg,this);
					if(receiver!=null){
						receiver.from_mass(action.stringMsg);
					}
				}else if(action.toType==MassAction.to_device){
//					Toast.show("[device]"+action.intMsg+" "+action.stringMsg);
					trace("[device]",action.intMsg,action.stringMsg,this);
				}
			}
		}
		
		public function activate(path:String):void{
			var parentPath:String=Path.getParentString(path);
			var target:MassTreeN=getBox(path);
			if(target.box.isState==false){
//				Toast.show("Error: can only activate state");
				trace("Error: can only activate state",this);
				return;
			}
			getNode(parentPath).slap(target);
		}
		
		public function spank(path:String):void{
			getNode(path).spankChildren();
		}
		
		public function clear(path:String):void{
			getNode(path).clearState();
		}
		
		private function getNode(path:String):MassTreeN{
			return path_MassTreeN[path];
		}
		
		//=================== sync =====================
		public function syncOut(state:String):void{
			if(tunnel!=null){
				tunnel.massSyncOut(state);
			}
		}
		
		public function syncIn(state:String):void{
			var parent:MassTreeN=getBox(Path.getParentString(state));
			
			//			if(parent.box.isHbox || parent.box.isVbox){
			//				MassTreeNVP_Grid3(parent).toBoss(path);
			//			}else{
			activate(state);
			//			}
		}
		
		public function from_mass(msg:String):void{
			var patPath:String=alias_path[msg];
			//			trace("from mass",msg,patPath,this);
			if(patPath!=null){
				activate(patPath);
			}else{
				trace("unknown message",this);
			}
		}
		
		public function getBox(path:String):MassTreeN{
			return path_MassTreeN[path];
		}
		
		//======================= data =======================
		public function fromBytes(zb:ZintBuffer):void
		{
			var fileFormat:int = zb.readInt();
			if(fileFormat==formatVersion){
				ss.fromBytes(zb.readBytesZ());
				root.readFrom(zb);
				path_MassTreeN=new Dictionary();
				root.registerToTree();
			}else
				throw new Error("format unknown");
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeInt(formatVersion);
			zb.writeBytesZ(ss.toBytes());
			root.writeTo(zb);
			return zb;
		}
		
		public function getMc5List(dest:Vector.<String>):void
		{
			root.getMc5List(dest);
		}
	}
}