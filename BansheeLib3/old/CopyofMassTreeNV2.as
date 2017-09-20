package azura.banshee.mass.view
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.model.ScreenSetting;
	import azura.banshee.mass.view.p.MassActiveI;
	import azura.banshee.mass.view.p.TouchDouble;
	import azura.banshee.mass.view.p.TouchHover;
	import azura.banshee.mass.view.p.TouchOut;
	import azura.banshee.mass.view.p.TouchSingle;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.collections.BoxC;
	import azura.common.collections.Path;
	import azura.common.ui.alert.Toast;
	
	public class MassTreeNV2 extends Zbox3Container implements Zbox3ControllerI,MassActiveI
	{
		public var tree:MassTreeV2;
		public var parent:MassTreeNV2;
		protected var childList:Vector.<MassTreeNV2>=new Vector.<MassTreeNV2>();
		
		private var _model:MassTreeN;
		protected var _image:ZebraC3;
		
		public var currentState:MassTreeNV2;
		
		protected var isRoot:Boolean;
		
		public function MassTreeNV2(parentZbox:Zbox3,parentNode:MassTreeNV2,model:MassTreeN,tree:MassTreeV2)
		{
			super(parentZbox);
			if(parentNode==null){
				isRoot=true;
				trace("is root",model.path,this);
			}
			this.parent=parentNode;
			this.model=model;
			this.tree=tree;
			
			//			trace("create",model.path,this);
			
			this.zbox.keepSorted=true;
			this.zbox.sortValue=model.sortValue;
			
			if(!isRoot){
				parent.addChild(this);
			}else{
				tree.path_MassTreeNV2["."]=this;
			}
			
			this.zbox.onReplace.add(onReplace);
			function onReplace(rep:Zbox3):void{
				currentState=rep.controller as MassTreeNV2;
				//				trace("state replaced to",currentState.model.path,this);
			}
			
			showSelfBox();
			
			enableTouch();
			
			showChildBoxList();
		}
		
		
		public function get model():MassTreeN
		{
			return _model;
		}
		
		public function set model(value:MassTreeN):void
		{
			_model = value;
		}
		
		public function showSelfBox():void{
			if(isRoot){
				zbox.width=Zbox3(zbox.parent).width;
				zbox.height=Zbox3(zbox.parent).height;
				return;
			}
			
			relativePosition();
			
			if(model.box.me5_zebra.length>0){
				image.feedMe5(model.box.me5_zebra);
				
				if(model.box.isF2()){
					image.zbox.stretchTo2(zbox.width,zbox.height);
					
				}else if(model.box.isF1()){
					image.zbox.stretchTo1(zbox.width,zbox.height);
				}else{
					image.zbox.noStretch();
				}
			}else{
				if(_image!=null){
					_image.zbox.dispose();
					_image=null;
				}
				zbox.initialize();
			}
			//			refreshBg();
		}
		
		public function refreshBg():void{
			
			if(model.box.isF1()){
				image.zbox.stretchTo1(zbox.width,zbox.height);
			}else if(model.box.isF2()){
				image.zbox.stretchTo2(zbox.width,zbox.height);
			}else{
				image.zbox.noStretch();
			}
		}
		
		public function updateSize():void{
			showSelfBox();
			for each(var child:MassTreeNV2 in childList){
				child.updateSize();
			}
		}
		
		public function get image():ZebraC3
		{
			if(_image==null){
				_image=new ZebraC3(this.zbox);
				_image.zbox.sortValue=-2;
				zbox.sortOne(_image.zbox);
			}
			return _image;
		}
		
		//================== position ====================
		
		protected function relativePosition():void{
			var nb:BoxC=model.box.localizeBox(parent.zbox.width,parent.zbox.height);
			if(model.box.isF1()){
				zbox.scaleLocal=ScreenSetting.fitScale(nb.bb.width,nb.bb.height,parent.zbox.width,parent.zbox.height);
			}else{
				zbox.scaleLocal=1;
			}
			zbox.width=nb.bb.width;
			zbox.height=nb.bb.height;
			zbox.move(nb.pos.x,nb.pos.y);
		}
		
		public function updatePos():void{
			zbox.move(zbox.x,zbox.y);
			for each(var child:MassTreeNV2 in childList){
				child.updatePos();
			}
		}
		
		public function get pivotX():Number{
			if(_image==null)
				return 0;
			else
				return _image.zbox.pivotX;
		}
		
		public function get pivotY():Number{
			if(_image==null)
				return 0;
			else
				return _image.zbox.pivotY;
		}
		//================== state ========================
		
		public function changeStateToFirst():void{
			var fs:Path=model.firstState;
			if(fs!=null){
				if(currentState==null || fs.toString()!=currentState.model.path)
					activate(fs.toString());
			}
		}
		
		override public function notifyClear():void{
			childList=new Vector.<MassTreeNV2>();
		}
		
		public function activate(path:String):MassTreeNV2{		
			//			trace("change state to",path,this);
			var childModel:MassTreeN=model.tree.path_MassTreeN[path];
			if(childModel==null)
				throw new Error();
			
			var target:MassTreeNV2=tree.getBox(path);
			if(target!=null){
				if(target!=currentState&&target.model.box.isState()){
					trace("editor changes box to state(first)",path,this);
					currentState.zbox.replaceBy(target.zbox);
				}else{
					target.spankChildren();
				}
			}else if(!childModel.box.isState()){
				Toast.show("Error: target should be state: "+path);
				trace("Error: target should be state:",path,this);
			}else{
				target=newChild(childModel);
				if(target.model.box.isState()){
					if(currentState==null || !currentState.model.box.isState())
						currentState=target;
					else
						currentState.zbox.replaceBy(target.zbox);
				}else{
					
				}
				target.doActionActivate();
			}
			return target;
		}
		
		//===================== structure =================
		
		protected function newChild(childData:MassTreeN):MassTreeNV2{
			throw new Error("to override");
		}
		
		public function showChildBoxList():void{
			for each(var childData:MassTreeN in model.boxList){
				if(childData.box.isState()){
					if(currentState==null){
						currentState=newChild(childData);
						currentState.doActionActivate();
					}
				}else{
					var b:MassTreeNV2=newChild(childData);
					b.doActionActivate();
				}
			}
		}
		
		public function addChild(child:MassTreeNV2):void{
			//			trace("try to add child",child.model.path,this);
			if(child.zbox.isDisposed)
				throw new Error();
			
			if(tree.path_MassTreeNV2[child.model.path]!=null){
				Toast.show("error: duplicate"+child.model.path,true);
				trace("Error: duplicate",child.model.path,this);
				return;
			}
			
			tree.path_MassTreeNV2[child.model.path]=child;
			childList.push(child);
			//			trace("add child",child.model.path,this);
		}
		
		public function removeChild(child:MassTreeNV2):void{
			if(tree.path_MassTreeNV2[child.model.path]==null){
				trace("error: remove target not exist",child.model.path,this);
				return;
				//				throw new Error();
			}
			
			delete tree.path_MassTreeNV2[child.model.path];
			var idx:int=childList.indexOf(child);
			childList.splice(idx,1);
			//			trace("remove child",child.model.path,this);
		}
		
		
		//========================== todo =================
		//=========== some action tries to use 'tree' on disposed node ============
		//			tree=null;
		//			childList=null;
		
		
		//			delete tree.path_ZuiTreeNV[model.path];
		//			zbox.dispose();
		//			_zbox=null;
		//		}
		
		//		override public function notifyInitialized():void{
		//			super.notifyInitialized();
		//			doActionActivate();
		//		}
		
		override public function notifyDispose():void{
			//			delete tree.path_MassTreeNV2[model.path];
			tree=null;
			childList=null;
			if(parent!=null)
				parent.removeChild(this);
			parent=null;
			//						trace("dispose",model.path,this);
		}
		//==================== action =====================
		
		public function act(action:MassAction):void{
//			trace("action: type=",action.type,"from=","target=",action.targetPath,this);
			if(tree==null){
				Toast.show("Error:操作源已销毁-"+model.path);
				trace("Error:操作源已销毁-",model.path,this);
			}else{
				tree.act(action,this);
			}
		}
		
		public function spankChildren():void{
			//						trace("spank children",model.path,this);
			var cache:Vector.<MassTreeNV2>=childList.slice();
			for each(var child:MassTreeNV2 in cache){
				child.notifySpank();
			}
		}
		
		public function notifySpank():void{
			for each(var action:MassAction in model.actionList){
				if(action.type==MassAction.spank){
					//					trace("spank",model.path,this);
					act(action);
				}
			}
		}
		
		public function doActionActivate():void{	
			for each(var action:MassAction in model.actionList){
				if(action.type==MassAction.activate){
					//					trace("state on",model.path,this);
					act(action);
				}
			}
		}
		
		private function enableTouch():void{
			for each(var action:MassAction in model.actionList){
				if(action.type==MassAction.hover){
					var hover:TouchHover=new TouchHover();
					hover.action=action;
					hover.node=this;
					zbox.addGesture(hover);
				}
				if(action.type==MassAction.out){
					var out:TouchOut=new TouchOut();
					out.action=action;
					out.node=this;
					zbox.addGesture(out);
				}
				if(action.type==MassAction.single_click){
					var single:TouchSingle=new TouchSingle();
					single.action=action;
					single.node=this;
					zbox.addGesture(single);
				}
				if(action.type==MassAction.double_click){
					var double:TouchDouble=new TouchDouble();
					double.action=action;
					double.node=this;
					zbox.addGesture(double);
				}
			}
		}
		
	}
}