package azura.banshee.mass.model.v3
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassBox;
	import azura.banshee.mass.model.ScreenSetting;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zebra.Zebra3;
	import azura.common.collections.BoxC;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	import azura.gallerid4.Gal4;
	import azura.gallerid4.Gal4PackI;
	
	public class MassTreeN3 implements ZintCodecI,Gal4PackI
	{
		//static
		private var _name:String="";
		public var box:MassBox=new MassBox();
		public var actionList:Vector.<MassAction>=new Vector.<MassAction>();
		
		//runtime
		public var x:int;
		public var y:int;
		public var width:int;
		public var height:int;
		public var scale:Number=1;
		
		//tree
		public var tree:MassTree3;
		public var parent:MassTreeN3;
		public var childList:Vector.<MassTreeN3>=new Vector.<MassTreeN3>();
		
		//state
		private var keptState_:MassTreeN3;
		public var keptStateV:MassTreeNV3;
		
		//visual
		public var v:MassTreeNV3;
		
		public function MassTreeN3(tree:MassTree3)
		{
			this.tree=tree;
		}
		
		//=================== tree =================
		
		public function get keptState():MassTreeN3
		{
			return keptState_;
		}
		
		public function set keptState(value:MassTreeN3):void
		{
			if(keptState_==null && value==null)
				return;
			if(keptState_!=null && value==null){
				trace("Warning: set state to null",this);
				keptState_=null;
				if(keptStateV!=null)
					keptStateV.zbox.dispose();
				keptStateV=null;
				return;
			}
			if(keptState_==value){
				//				trace("Warning: duplicate set state",value.path,this);
				return;
			}
			keptState_ = value;
		}
		
		public function initRoot(shell:Zbox3):void{
			tree.path_MassTreeN3['.']=this;
			this.width=shell.width;
			this.height=shell.height;
			v=new MassTreeNV3(shell,this);
		}
		
		public function newChild():MassTreeN3{
			var child:MassTreeN3=new MassTreeN3(tree);
			child.parent=this;
			childList.push(child);
			return child;
		}
		
		public function get childStateCount():int{
			var count:int=0;
			for each(var c:MassTreeN3 in childList){
				if(c.box.isState){
					count++;
				}
			}
			return count;
		}
		
		//================= display ======================
		/**
		 *init state 
		 */
		public function initState():void{
			if(this.box.isList==false)
				keptState_=firstState;
			else
				initList();
			for each(var child:MassTreeN3 in childList){
				child.initState();
			}
		}
		
		public function resetState():void{
			if(this.box.isList==false)
				keptState=firstState;
			for each(var child:MassTreeN3 in childList){
				child.resetState();
			}
		}
		
		public function initList():void{
			//to override
		}
		
		protected function get shouldBeVisible():Boolean{
			//to override
			return true;
		}
		
		public function get visible():Boolean{
			return v!=null;
		}
		
		public function set visible(value:Boolean):void{
			//			trace(path,"visible=",value,this);
			if(visible==value)
				return;
			if(value==true){
				v=makeV();
				if(box.isState){
					if(parent.keptStateV!=null)
						parent.keptStateV.zbox.replaceBy(v.zbox);
					parent.keptStateV=v;
				}
			}else{
				if(parent.box.isList){
					v.zbox.dispose();
				}
			}
		}
		
		public function makeV():MassTreeNV3{
			if(parent.v==null)
				throw new Error();
			return new MassTreeNV3(parent.v.zbox,this);
		}
		
		/**
		 * can be called duplicate 
		 * 
		 */
		public function showVisible():void{
			
			var wasVisible:Boolean=visible;
			if(shouldBeVisible==true){
				if(isRoot==false && wasVisible==false){
					visible=true;
					castVisual();
				}
				for each(var child:MassTreeN3 in childList){
					child.showVisible();
				}
			}else if(wasVisible==true){
				visible=false;
			}
		}
		
		public function showNumber(num:Number):void{
			showText(num+"");
		}
		
		public function showText(text:String):void{
			box.zfont.text=text;
			if(v!=null)
				v.showSelfBox();
		}
		
		//============================ size ===================
		
		public function adaptSize():void{
			if(isRoot==false){
				//				trace("parent is",parent.path,"this is",path,this);
				var nb:BoxC=box.localizeBox(parent.width,parent.height);
				if(box.isF1){
					scale=ScreenSetting.fitScale(nb.bb.width,nb.bb.height,parent.width,parent.height);
				}else{
					scale=1;
				}
				width=nb.bb.width;
				height=nb.bb.height;
				if(this is MassTreeN3P && parent.box.isList==true){
					//do nothing
				}else{
					x=nb.pos.x;
					y=nb.pos.y;
				}
			}
			
			if(v!=null){
				v.showSelfBox();
			}
			
			for each(var child:MassTreeN3 in childList){
				child.adaptSize();
			}
		}
		
		//========================== action ===================
		public function slap(target:MassTreeN3):void{		
			if(target==null){
				throw new Error();
			}
			
			//			if(keptState==target){
			//				trace("Warning: duplicate slap",target.path,this);
			//				return;
			//			}
			
			if(this.box.isList){
				var idx:int=childList.indexOf(target);
				slapListItem(idx);
				//				motor.autoTo(idx);
			}else if(target.box.isState){
				keptState=target;
				//				keptState.castActivate();
			}
		}
		
		protected function slapListItem(idx:int):void{
			//to override
		}
		
		internal function castActivate():void{	
			for each(var action:MassAction in actionList){
				if(action.byType==MassAction.byActivate){
					tree.act(action,true);
				}
			}
		}
		
		private function castVisual():void{	
			for each(var action:MassAction in actionList){
				if(action.byType==MassAction.byActivate && action.toType==MassAction.to_coder){
					tree.act(action,false);
				}
			}
		}
		
		public function spankChildren():void{
			for each(var child:MassTreeN3 in childList){
				child.beSpanked();
			}
		}
		
		private function beSpanked():void{
			for each(var action:MassAction in actionList){
				if(action.byType==MassAction.bySpank){
					tree.act(action,true);
				}
			}
		}
		
		//========================== data ======================
		
		public function readFrom(reader:ZintBuffer):void
		{
			name=reader.readUTFZ();
			if(this.isRoot && name.length>0){
				trace("============warning: root name not empty",name,this);
				_name='';
			}
			box.fromBytes(reader.readBytesZ());
			
			if(isRoot)
				box.init();
			
			//========action=======
			var sizeA:int=reader.readZint();
			for(var i:int=0;i<sizeA;i++){
				var action:MassAction=new MassAction(this);
				action.fromBytes(reader.readBytesZ());
				if(action.targetPath.length>0)
					action.targetPath+=".";
				actionList.push(action);
			}
			
			//			adaptSize();
			
			//========tree========
			var sizeC:int=reader.readZint();
			for(i=0;i<sizeC;i++){
				var child:MassTreeN3=newChild();
				child.readFrom(reader);
				tree.path_MassTreeN3[child.path]=child;
			}
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			throw new Error();
		}
		
		public function getMc5List(dest:Vector.<String>):void
		{
			for each(var box:MassTreeN3 in childList){
				loadOne(dest,box);
			}
		}
		
		//====================== support ===================
		
		public function get firstState():MassTreeN3{
			for each(var child:MassTreeN3 in childList){
				if(child.box.isState)
					return child;
			}
			return null;
		}
		
		public function get isRoot():Boolean{
			return parent==null;
		}
		
		public function get isLeaf():Boolean{
			return childList.length==0;
		}
		
		public function get sortValue():int{
			if(parent==null)
				return 0;
			else
				return parent.childList.indexOf(this);
		}
		
		public function getState(stateName:String):MassTreeN3{
			for each(var child:MassTreeN3 in childList){
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
			var pointer:MassTreeN3=this;
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
		
		public function loadOne(list:Vector.<String>, box:MassTreeN3):void{
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