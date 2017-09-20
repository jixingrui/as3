package azura.common.ui.alert
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mx.core.FlexGlobals;
	import mx.core.IVisualElementContainer;
	import mx.events.FlexEvent;
	
	import org.osflash.signals.Signal;
	
	import spark.components.BorderContainer;
	import spark.components.Label;
	import spark.layouts.VerticalLayout;
	
	public class Toast extends BorderContainer
	{
		private static var current:Toast;
		private static var validator_:Object=new Object();
		public static var container:IVisualElementContainer;
//		public var creationComplete:Signal=new Signal();
				
		public static function show(text:String,sticky:Boolean=false):Toast{
			if(container==null){
//				trace("Toast container undefined");
				container=FlexGlobals.topLevelApplication as IVisualElementContainer;
			}
			
			if(container==null){
//				trace("Toast has no container",text);
				return null;
			}
			
			if(current!=null && current.text==text){
				current.timer.reset();
				current.timer.start();
				return current;
			}else if(current!=null){
				current.close();
			}
			current=new Toast(text,sticky,null,validator_);
			current.show();
			
			return current;
		}
		
		public static function remove():void{
			if(current!=null){
				current.close();
				current=null;				
			}
		}

		//============================================
		
		private var text:String;
		private var sticky:Boolean;
		private var onDisappear:Function;
		private var timer:Timer;
		public function Toast(text:String, sticky:Boolean, onDisappear:Function, validator:Object):void
		{
			this.text=text;
			this.sticky=sticky;
			this.onDisappear=onDisappear;
			
//			this.addEventListener(FlexEvent.CREATION_COMPLETE,creationCompleteEvent);
//			this.addEventListener(Event.ADDED_TO_STAGE,creationCompleteEvent);
			
			if(validator!=validator_)
				throw new Error("Toast: please use Toast.show()");
		}
		
//		override public function dispatchEvent(event:Event):Boolean{
//			trace(event.type,this);
//			return super.dispatchEvent(event);
//		}
		
//		private function creationCompleteEvent(event:FlexEvent):void{
//			setTimeout(creationComplete.dispatch,1000);
////			creationComplete.dispatch();
//		}
		
		public function close():void{
			removeCheck();
		}
		
		private function show():void{
			
			var timeOut:int=2000+text.length*200;
			if(sticky)
				timeOut+=8000;
			timer = new Timer(timeOut, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, removeCheck);
			timer.start();
			
			var color:String='#454545';
			var width:Number=300;
			var height:Number=50;
			createUI(text, color, width, height);
			
			positionToast();
		}
		
		public function get isRemoved():Boolean{
			return timer==null;
		}
		
		public function removeCheck(event:TimerEvent=null):void{
			if(timer==null)
				return;
			
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, removeCheck);
			timer.stop();
			timer=null;
			container.removeElement(this);
			current=null;
			if(onDisappear!=null)
				onDisappear.call();
		}
		
		/**
		 *  CREATE TOAST UI COMPONENTS
		 */
		private function createUI(textToDisplay:String, color:String, width:Number, height:Number):void
		{
			selfProperties(color, width, height);
			addText(textToDisplay);
		}
		
		/**
		 * ASSIGNING ATTRIBUTES TO THE BASE CONTAINER
		 */
		private function selfProperties(color:String, width:Number, height:Number):void
		{
			this.width=width;
			this.height=height;
			this.setStyle('backgroundAlpha','0.75');
			this.setStyle('backgroundColor',color);
			this.setStyle('borderColor','#242424');
			this.setStyle('borderWeight','2');
			this.setStyle('cornerRadius','3');
			
			var vl:VerticalLayout = new VerticalLayout();
			vl.horizontalAlign = "center";
			vl.verticalAlign = "middle";
			this.layout = vl;
		}
		
		/**
		 *  CREATE LABEL
		 */
		private function addText(textToDisplay:String):void
		{
			var lbl:Label = new Label();
			lbl.setStyle('font','Arial');
			lbl.setStyle('color','#EDEDED');
			lbl.setStyle('fontSize','20');
			lbl.setStyle('textAlign', 'center');
			lbl.text = textToDisplay;
			lbl.width = this.width-5;
			
			this.addElement(lbl);
		}
		
		/**
		 *  POSITIONING THE TOAST 
		 */
		private function positionToast():void
		{
			container.addElement(this);
			this.horizontalCenter=0;
			this.bottom=stage.stageHeight/10;
			var sca:Number=stage.stageHeight/576;
			this.scaleX=sca;
			this.scaleY=sca;
//			if(Capabilities.screenDPI>200){
//				this.scaleX=Capabilities.screenDPI/200;
//				this.scaleY=Capabilities.screenDPI/200;
//			}
		}
	}
}