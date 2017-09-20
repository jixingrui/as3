package azura.banshee.mass.model.v3
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.ScreenSetting;
	import azura.banshee.mass.sdk.MassCoderA4;
	import azura.banshee.mass.sdk.MassSdkA3;
	import azura.banshee.mass.sdk.MassSdkI2;
	import azura.banshee.mass.view.MassTreeSyncI;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.collections.BytesI;
	import azura.common.collections.Path;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4PackI;
	
	import flash.utils.Dictionary;
	
	public class MassTree3 implements BytesI,Gal4PackI,ActorI
	{
		public static var formatVersion:int=2016083001;
		
		public var ss:ScreenSetting=new ScreenSetting();
		
		public var root:MassTreeN3;		
		public var path_MassTreeN3:Dictionary=new Dictionary();
		
		public var tunnel:MassTreeSyncI;
		public var coder:MassCoderA4;
		public var receiver:MassTree3;
		public var alias_path:Dictionary=new Dictionary();
		
		private var upLink:Zbox3;
		
		public function MassTree3(zbox:Zbox3,coder:MassCoderA4)
		{
			this.upLink=zbox;
			
			this.coder=coder;
			coder.tree=this;
			
			root=newRoot();
			root.initRoot(zbox);
		}
		
		protected function newRoot():MassTreeN3{
			return new MassTreeN3(this);
		}
		
		public function showVisible():void{
			root.showVisible();
		}
		
		//====================== action ================
		public function act(action:MassAction,logic_visual:Boolean):void{
			
			if(action.toType==MassAction.to_coder){
				var ok:Boolean=false;
				if(action.byType==MassAction.byActivate && logic_visual==false)
					ok=true;
				else if(action.byType!=MassAction.byActivate && logic_visual==true)
					ok=true;
				if(ok){
					coder.pipe(action.toCoder());
					return;
				}
			}
			
			
			if(action.isInternal()){
				if(action.targetPath.length==0){
					trace("error: action has empty target ==============",this);
					return;
				}				
				
				if(action.toType==MassAction.doSlap){
					slap(action.targetPath);
				}else if(action.toType==MassAction.doSpank){
					spank(action.targetPath);
				}else if(action.toType==MassAction.doReset){
					reset_(action.targetPath);
				}
			}else{
				if(action.toType==MassAction.to_mass){
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
		
		public function slap(path:String):void{
			syncIn(path);
			//================= test ===========
			syncOut(path);
			showVisible();
		}
		
		public function spank(path:String):void{
			getNode(path).spankChildren();
		}
		
		public function reset_(path:String):void{
			var target:MassTreeN3=getNode(path)
			target.resetState();
			target.showVisible();
		}
		
		private function getNode(path:String):MassTreeN3{
			return path_MassTreeN3[path];
		}
		
		//=================== sync =====================
		public function syncOut(state:String):void{
			if(tunnel!=null){
				tunnel.massSyncOut(state);
			}
		}
		
		public function syncIn(path:String):void{
			var parentPath:String=Path.getParentString(path);
			var target:MassTreeN3=getBox(path);
			if(target==null){
				trace("Error: invalid slap on ============",path,this);
				return;
			}
			var parent:MassTreeN3=getNode(parentPath);
			parent.slap(target);
		}
		
		public function from_mass(msg:String):void{
			var patPath:String=alias_path[msg];
			if(patPath!=null){
				slap(patPath);
			}else{
				trace("unknown message",this);
			}
		}
		
		public function getBox(path:String):MassTreeN3{
			return path_MassTreeN3[path];
		}
		
		public function dispose():void{
			root.v.zbox.dispose();
		}
		
		//======================= data =======================
		public function fromBytes(zb:ZintBuffer):void
		{
			var fileFormat:int = zb.readInt();
			if(fileFormat==formatVersion){
				ss.fromBytes(zb.readBytesZ());
				trace("mass design size",ss.designWidth,ss.designHeight,this);
				
				ss.display(upLink.width,upLink.height);
				upLink.width=ss.dragWidth;
				upLink.height=ss.dragHeight;
				upLink.scaleLocal=ss.scale;
				
				root.readFrom(zb);		
				root.width=ss.dragWidth;
				root.height=ss.dragHeight;
				root.adaptSize();
				root.initState();
				
				resize(ss.dragWidth,ss.dragHeight);
				
			}else
				throw new Error("format unknown");
		}
		
		public function resize(w:int,h:int):void{
			root.width=w;
			root.height=h;
			root.adaptSize();
			//			root.showVisible();
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