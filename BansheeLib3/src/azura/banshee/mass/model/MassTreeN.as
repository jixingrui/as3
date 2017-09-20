package azura.banshee.mass.model
{
	import azura.banshee.mass.view.MassTreeNV2;
	import azura.banshee.zebra.Zebra3;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	import azura.gallerid4.Gal4;
	import azura.gallerid4.Gal4PackI;
	
	public class MassTreeN implements ZintCodecI,Gal4PackI
	{
		//static
		private var _name:String="";
		public var box:MassBox=new MassBox();
		public var actionList:Vector.<MassAction>=new Vector.<MassAction>();
		
		//tree
		public var tree:MassTree;
		public var parent:MassTreeN;
		public var childList:Vector.<MassTreeN>=new Vector.<MassTreeN>();
		
		//state
		public var keptState:MassTreeN;
		
		private var _v:MassTreeNV2;
		
		public var delayedActivatePending:Boolean;
		public var coderList:Vector.<MassAction>=new Vector.<MassAction>();
		
		public function MassTreeN(tree:MassTree)
		{
			this.tree=tree;
		}
		
		//================= visual ======================
		
		private var _visible:Boolean;
		public function get visible():Boolean
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void
		{
			if(_visible!=value)
				throw new Error();
			
			_visible = value;
			if(value==true){
				//generate view
			}
		}
		
		public function get v():MassTreeNV2
		{
			return _v;
		}
		
		public function set v(value:MassTreeNV2):void
		{
			_v = value;
			checkCoder();
		}
		
		
		//=================== tree =================
		public function registerToTree():void{
			tree.path_MassTreeN[path]=this;
			if(box.isReceiver){
				tree.alias_path[box.from_mass]=this.path;
			}
			for each(var child:MassTreeN in childList){
				child.registerToTree();
			}
		}
		
		public function addChild(child:MassTreeN):void{
			child.parent=this;
			childList.push(child);
			if(keptState==null){
				keptState=firstState;
			}
		}
		
		//========================== action ===================
		
		public function slap(target:MassTreeN):void{		
			if(target==null){
				//				trace("Warning: activate null",this);
				throw new Error();
				//				return;
			}
			if(keptState==target){
				//				Toast.show("Error: duplicate activate "+target.path);
				trace("Warning: duplicate activate",target.path,this);
				return;
			}
			if(this.box.isList){
				//============ notify motor ==============
			}else{
				trace("change state from",keptState.path,"to",target.path,this);
				keptState=target;
				target.castActivate();
			}
		}
		
		public function castActivate():void{	
			for each(var action:MassAction in actionList){
				if(action.byType==MassAction.byActivate){
					tree.act(action);
				}
			}
		}
		
		public function spankChildren():void{
			for each(var child:MassTreeN in childList){
				child.beSpanked();
			}
		}
		
		public function beSpanked():void{
			for each(var action:MassAction in actionList){
				if(action.byType==MassAction.bySpank){
					tree.act(action);
				}
			}
		}
		
		public function clearState():void{
			if(firstState!=null && keptState!=firstState){
				slap(firstState);
			}
			//			if(v!=null)
			//				v.notifyInitStates();
			for each(var child:MassTreeN in childList){
				child.clearState();
			}
		}
		
		public function bookCoder(action:MassAction):void{
			coderList.push(action);
			checkCoder();
		}
		
		public function checkCoder():void{
			if(v==null || coderList.length==0)
				return;
			for each(var action:MassAction in coderList){
				tree.user.chainAction(action);
			}
			coderList=new Vector.<MassAction>();
		}
		//========================== data ======================
		
		
		public function readFrom(reader:ZintBuffer):void
		{
			name=reader.readUTFZ();
			box.fromBytes(reader.readBytesZ());
			
			var sizeA:int=reader.readZint();
			for(var i:int=0;i<sizeA;i++){
//				var action:MassAction=new MassAction(this);
				//				action.host=this.path;
//				action.fromBytes(reader.readBytesZ());
//				if(action.targetPath.length>0)
//					action.targetPath+=".";
//				actionList.push(action);
			}
			
			var sizeC:int=reader.readZint();
			for(i=0;i<sizeC;i++){
				var child:MassTreeN=new MassTreeN(tree);
				child.readFrom(reader);
				this.addChild(child);
			}
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			throw new Error();
		}
		
		public function getMc5List(dest:Vector.<String>):void
		{
			for each(var box:MassTreeN in childList){
				loadOne(dest,box);
			}
		}
		
		//====================== support ===================
		
		public function get firstState():MassTreeN{
			if(box.isList){
				if(childList.length>0)
					return childList[0];
				else
					return null;
			}else{
				for each(var child:MassTreeN in childList){
					if(child.box.isState)
						return child;
				}
				return null;
			}
		}
		
		public function get isRoot():Boolean{
			return parent==null;
		}
		
		public function get sortValue():int{
			if(parent==null)
				return 0;
			else
				return parent.childList.indexOf(this);
		}
		
		public function getState(stateName:String):MassTreeN{
			for each(var child:MassTreeN in childList){
				if(child.box.isState && child.name==stateName)
					return child;
			}
			return null;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			if(_name.length>0||value==null)
				throw new Error();
			
			_name = value;
		}
		
		public function get path():String{
			var result:String="";
			var pointer:MassTreeN=this;
			while(pointer!=null){
				result+=pointer.name+".";
				pointer=pointer.parent;
			}
			return result;
		}
		
		public function get isTouchable():Boolean{
			for each(var action:MassAction in actionList){
				switch(action.byType)
				{
					case MassAction.byHover:
						return true;
					case MassAction.byOut:
						return true;
					case MassAction.bySingle:
						return true;
					case MassAction.byDouble:
						return true;
				}
			}
			return false;
		}
		
		public function loadOne(list:Vector.<String>, box:MassTreeN):void{
			if(box.box.me5_zebra.length>0){
				list.push(box.box.me5_zebra);
				var zdata:ZintBuffer=Gal4.readSync(box.box.me5_zebra);
				zdata.uncompress();
				var zebra:Zebra3=new Zebra3();
				zebra.fromBytes(zdata);
				zebra.getMc5List(list);
			}
			
			box.getMc5List(list);
		}
		
	}
}