package azura.common.localconnection
{
	import azura.common.swf.SwfEvent;
	import azura.common.swf.ui.InputPanel;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	public class LocalConnectionOnLoader
	{
		private var lc:LocalConnection;
		
		public function LocalConnectionOnLoader()
		{
			lc=new LocalConnection();
			lc.addEventListener(StatusEvent.STATUS, onLCStatus);
			lc.client=this;
			lc.allowDomain("*");
			lc.connect("_loader");
		}
		
		protected function onLCStatus(event:StatusEvent):void
		{
			trace("LcLoader:", event.code);
		}
		
		public function request():void{
			var ip:InputPanel=new InputPanel();
			ip.addEventListener(SwfEvent.ANSWER_INPUT,onInputDone);
			PopUpManager.addPopUp(ip,FlexGlobals.topLevelApplication as DisplayObject,true);
			ip.x=stage.stageWidth/2-ip.width/2;
			ip.y=stage.stageHeight/2-ip.height/2;
			
			function onInputDone(e:SwfEvent):void{
				//					trace("text input done: "+e.input);
				PopUpManager.removePopUp(ip);
				//						stage.dispatchEvent(new TextEvent(TextEvent.LINK,false,false,e.input));
				lc.send("_app","receive",e.string);
			}
		}
		
		private function get stage():Stage{
			return DisplayObject(FlexGlobals.topLevelApplication).stage;
		}
	}
}