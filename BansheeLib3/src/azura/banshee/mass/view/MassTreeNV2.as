package azura.banshee.mass.view
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.model.ScreenSetting;
	import azura.banshee.mass.trigger.TouchDouble;
	import azura.banshee.mass.trigger.TouchHover;
	import azura.banshee.mass.trigger.TouchOut;
	import azura.banshee.mass.trigger.TouchSingle;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.collection.ZboxText;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.collections.BoxC;
	
	public class MassTreeNV2 extends Zbox3Container implements Zbox3ControllerI
	{
		protected var isRoot:Boolean;
		public var tree:MassTreeV2;
		public var parent:MassTreeNV2;
		protected var childList:Vector.<MassTreeNV2>=new Vector.<MassTreeNV2>();
		
		private var _model:MassTreeN;
		protected var _image:ZebraC3;
		
		private var textView:ZboxText;
		
		//		public var leaderState:MassTreeNV2;//======= ? =======
		
		//		public var displayingState:MassTreeNV2;
		//		public var replacingState:MassTreeNV2;
		
		public var displayingState:MassTreeNV2;
		
		public function MassTreeNV2(parentZbox:Zbox3,parentNode:MassTreeNV2,model:MassTreeN,tree:MassTreeV2)
		{
			super(parentZbox);
			if(parentNode==null){
				isRoot=true;
			}
			this.parent=parentNode;
			this.model=model;
			this.tree=tree;
			
			//			trace("created:",model.path,this);
			
			this.zbox.keepSorted=true;
			this.zbox.sortValue=model.sortValue;
			
			model.delayedActivatePending=true;
			
			if(!isRoot){
				parent.addChild(this);
			}else{
				tree.path_MassTreeNV2["."]=this;
			}
			
			this.zbox.onReplaceParent.add(onReplace);
			function onReplace(rep:Zbox3):void{
				displayingState=rep.controller as MassTreeNV2;
			}
			
			showSelfBox();
			
			enableTouch();
			
			showChildBoxList();
			
			model.v=this;
			
			//			model.checkCoder();
		}
		
		public function get model():MassTreeN
		{
			return _model;
		}
		
		public function set model(value:MassTreeN):void
		{
			_model = value;
		}
		
		public function updateFrame():void{
			
			if(displayingState==null && model.keptState!=null){
				//no state -> first state
				displayingState=model.keptState.v;
			}else if(displayingState!=null && model.keptState==null){
				//has state -> no state
				displayingState=null;
			}else if(displayingState!=null && displayingState.model!=model.keptState){
				if(displayingState.model.box.isState==false){
					//is state -> not state
					displayingState=newChild(model.keptState);
				}else{
					if(model.keptState.v==null){
						//one state -> another state
						var ns:MassTreeNV2=newChild(model.keptState);
						displayingState.zbox.replaceBy(ns.zbox);
					}else if(displayingState.zbox.shadow==null){
						//not state -> is state
						displayingState.zbox.dispose();
						displayingState=model.keptState.v;
					}
				}
				
			}else{
				//				trace("what",this);
			}
			
			loopFrame();
		}
		
		public function loopFrame():void{
			if(model.delayedActivatePending==true){
				model.delayedActivatePending=false;
				model.castActivate();
			}
			for each(var child:MassTreeNV2 in childList){
				child.updateFrame();
			}			
		}
		
		private function showSelfBox():void{
			if(isRoot){
				zbox.width=Zbox3(zbox.parent).width;
				zbox.height=Zbox3(zbox.parent).height;
				return;
			}
			
			relativePosition();
			
			if(model.box.me5_zebra.length>0){
				image.feedMc5(model.box.me5_zebra);
				
				if(model.box.isF2){
					image.zbox.stretchTo2(zbox.width,zbox.height);
					
				}else if(model.box.isF1){
					image.zbox.stretchTo1(zbox.width,zbox.height);
				}else{
					image.zbox.noStretch();
				}
			}else{
				if(_image!=null){
					_image.zbox.dispose();
					_image=null;
				}
				
				if(model.childList.length==0)
					zbox.initialize();
				//============================== touble =======================
			}
			
			if(model.box.zfont.text.length>0){
				if(textView==null)
					textView=new ZboxText(zbox);
				textView.fromFont(model.box.zfont);
			}
		}
		
		public function refreshBg():void{
			if(model.box.isF1){
				image.zbox.stretchTo1(zbox.width,zbox.height);
			}else if(model.box.isF2){
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
			if(model.box.isF1){
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
				return _image.zbox.touchDX;
		}
		
		public function get pivotY():Number{
			if(_image==null)
				return 0;
			else
				return _image.zbox.touchDY;
		}
		
		override public function notifyClear():void{
			childList=new Vector.<MassTreeNV2>();
		}
		
		//===================== structure =================
		
		protected function newChild(childData:MassTreeN):MassTreeNV2{
			throw new Error("to override");
		}
		
		/**
		 *Except list. 
		 * 
		 */
		public function showChildBoxList():void{
			for each(var childData:MassTreeN in model.childList){
				if(childData.box.isState == false && model.box.isHlist==false && model.box.isVlist==false){
					newChild(childData);
				}else if(childData==model.keptState){
					displayingState=newChild(model.keptState);
				}
			}
		}
		
		public function addChild(child:MassTreeNV2):void{
			if(child.zbox.isDisposed)
				throw new Error();
			
			//			trace("add child",child.model.path,this);
			
			if(tree.path_MassTreeNV2[child.model.path]!=null){
//				Toast.show("Error: duplicate "+child.model.path,true);
				trace("Error: duplicate",child.model.path,this);
				return;
				//				throw new Error("duplicate");
			}
			
			tree.path_MassTreeNV2[child.model.path]=child;
			childList.push(child);
		}
		
		public function removeChild(child:MassTreeNV2):void{
			
			//			trace("remove child",child.model.path,this);
			
			if(tree.path_MassTreeNV2[child.model.path]==null){
				//				trace("Error: remove target not exist",child.model.path,this);
				//				return;
				throw new Error("remove target not exist");
			}
			
			delete tree.path_MassTreeNV2[child.model.path];
			var idx:int=childList.indexOf(child);
			childList.splice(idx,1);
			
			if(child==displayingState){
				displayingState=null;
				//				trace("stop",this);
			}
		}
				
		override public function notifyDispose():void{
			//			trace("disposed",this);
			tree=null;
			childList=null;
			if(parent!=null)
				parent.removeChild(this);
			parent=null;
			model.v=null;
		}
		
		//==================== touch =====================
				
		private function enableTouch():void{
			zbox.intercept=model.box.isInterceptive;
			
			for each(var action:MassAction in model.actionList){
				if(action.byType==MassAction.byHover){
					var hover:TouchHover=new TouchHover();
					hover.action=action;
					hover.from=this.model;
					zbox.addGesture(hover);
				}
				if(action.byType==MassAction.byOut){
					var out:TouchOut=new TouchOut();
					out.action=action;
					out.from=this.model;
					zbox.addGesture(out);
				}
				if(action.byType==MassAction.bySingle){
					var single:TouchSingle=new TouchSingle();
					single.action=action;
					single.from=this.model;
					zbox.addGesture(single);
				}
				if(action.byType==MassAction.byDouble){
					var double:TouchDouble=new TouchDouble();
					double.action=action;
					double.from=this.model;
					zbox.addGesture(double);
				}
			}
		}
		
	}
}
