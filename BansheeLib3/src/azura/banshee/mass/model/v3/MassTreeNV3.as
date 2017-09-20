package azura.banshee.mass.model.v3
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.trigger.v3.TouchDouble;
	import azura.banshee.mass.trigger.v3.TouchHover;
	import azura.banshee.mass.trigger.v3.TouchOut;
	import azura.banshee.mass.trigger.v3.TouchSingle;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.collection.ZboxRect3;
	import azura.banshee.zbox3.collection.ZboxText;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.graphics.Draw;
	import azura.common.ui.list.motor.DragList;
	
	import flash.display.BitmapData;
	
	public class MassTreeNV3 extends Zbox3Container implements Zbox3ControllerI
	{
		public var model:MassTreeN3;
		
		protected var _image:ZebraC3;		
		private var textView:ZboxText;
		
		public function MassTreeNV3(parentZbox:Zbox3,model:MassTreeN3)
		{
			super(parentZbox);
			this.model=model;
			model.v=this;
			
			zbox.keepSorted=true;
			zbox.sortValue=model.sortValue;

			
//			trace("show",model.path,this);
			showSelfBox();
			
			enableTouch();
		}
		
		//======================= view ===========
		public function showSelfBox():void{
			if(model.isRoot)
				return;
			
			zbox.move(model.x,model.y);
			zbox.width=model.width;
			zbox.height=model.height;
			zbox.scaleLocal=model.scale;
			
			if(model.box.me5_zebra.length>0){
				image.feedMc5(model.box.me5_zebra);
				
				if(model.box.isF1){
					image.zbox.stretchTo1(zbox.width,zbox.height);
				}else if(model.box.isF2){
					image.zbox.stretchTo2(zbox.width,zbox.height);
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
			}
			
			if(model.box.zfont.text.length>0){
				if(textView==null)
					textView=new ZboxText(zbox);
				textView.fromFont(model.box.zfont);
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
		//===================== structure =================
		override public function notifyDispose():void{
			model.v=null;
			if(model.isRoot)
				return;
			if(model.parent.keptStateV==this){
				model.parent.keptStateV=null;
			}
		}
		
		//==================== touch =====================
		
		protected function disableTouch():void{
			zbox.removeGestureAll();
		}
		
		protected function enableTouchList():void{
			//to override
		}
		
		protected function enableTouch():void{
			zbox.intercept=model.box.isInterceptive;
			
			if(model.box.isList){
				enableTouchList();
			}
			
			for each(var action:MassAction in model.actionList){
				if(action.byType==MassAction.byHover){
					var hover:TouchHover=new TouchHover();
					hover.action=action;
					hover.actor=this.model.tree;
					zbox.addGesture(hover);
				}
				if(action.byType==MassAction.byOut){
					var out:TouchOut=new TouchOut();
					out.action=action;
					out.actor=this.model.tree;
					zbox.addGesture(out);
				}
				if(action.byType==MassAction.bySingle){
					var single:TouchSingle=new TouchSingle();
					single.action=action;
					single.actor=this.model.tree;
					zbox.addGesture(single);
				}
				if(action.byType==MassAction.byDouble){
					var double:TouchDouble=new TouchDouble();
					double.action=action;
					double.actor=this.model.tree;
					zbox.addGesture(double);
				}
			}
		}
		
	}
}
