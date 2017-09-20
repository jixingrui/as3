package azura.junior.service
{
	import azura.common.collections.ZintBuffer;
	import azura.common.loaders.PngLoader;
	import azura.common.ui.alert.AlertShow;
	import azura.common.ui.button.ImageDisplay;
	import azura.karma.def.KarmaSpace;
	import azura.karma.hard11.service.HubC_SC;
	import azura.karma.run.Karma;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import zz.karma.JuniorEdit.CS.K_Load;
	import zz.karma.JuniorEdit.CS.K_ReportIdea;
	import zz.karma.JuniorEdit.CS.K_Save;
	import zz.karma.JuniorEdit.CS.K_SaveIdea;
	import zz.karma.JuniorEdit.CS.K_Sdk;
	import zz.karma.JuniorEdit.CS.K_SelectIdea;
	import zz.karma.JuniorEdit.CS.K_TestRun;
	import zz.karma.JuniorEdit.CS.K_Wipe;
	import zz.karma.JuniorEdit.K_CS;
	import zz.karma.JuniorEdit.K_Idea;
	import zz.karma.JuniorEdit.K_SC;
	import zz.karma.JuniorEdit.SC.K_ReportIdeaRet;
	import zz.karma.JuniorEdit.SC.K_SaveRet;
	import zz.karma.JuniorEdit.SC.K_SdkRet;
	import zz.karma.JuniorEdit.SC.K_SelectIdeaRet;
	import zz.karma.JuniorEdit.SC.K_TestRunRet;
	
	
	public class JuniorC_SC extends K_SC
	{
		private var hub:HubC_SC;
		
		public static var ksJunior:KarmaSpace;
		
		public function JuniorC_SC(space:KarmaSpace,hub:HubC_SC)
		{
			super(space);
			this.hub=hub;
			ksJunior=space;
		}
		
		public function selectIdea():void{
			sendCS(new K_SelectIdea(space).toKarma());
		}
		public function save():void{
			sendCS(new K_Save(space).toKarma());
		}
		public function saveIdea(idea:K_Idea):void{
			var s:K_SaveIdea=new K_SaveIdea(space);
			s.idea=idea.toKarma();
			sendCS(s.toKarma());
		}
		public function wipe():void{
			sendCS(new K_Wipe(space).toKarma());
		}
		public function load(data:ZintBuffer):void{
			var load:K_Load=new K_Load(space);
			load.db=data;
			sendCS(load.toKarma());
		}
		public function sdk():void{
			sendCS(new K_Sdk(space).toKarma());
		}
		
		private var reportName:String;
		public function report(name:String):void{
			reportName=name;
			sendCS(new K_ReportIdea(space).toKarma());
		}
		private function sendCS(msg:Karma):void{
			var cs:K_CS=new K_CS(space);
			cs.send=msg;
			hub.sendCustom(cs.toBytes());
		}
		public function test(name:String):void{
			reportName=name;
			sendCS(new K_TestRun(space).toKarma());
		}
		
		public function receive(zb:ZintBuffer):void{
			var version:int;
			
			super.fromBytes(zb);
			if(send.type==T_SaveRet){
				var sr:K_SaveRet=new K_SaveRet(space);
				sr.fromKarma(send);
				saveDb(sr.db,sr.version);
			}else if(send.type==T_SdkRet){
				var sdk:K_SdkRet=new K_SdkRet(space);
				sdk.fromKarma(send);
				saveSdk(sdk.data,sdk.version);
			}else if(send.type==T_ReportIdeaRet){
				var rir:K_ReportIdeaRet=new K_ReportIdeaRet(space);
				rir.fromKarma(send);
				var png:ZintBuffer=rir.data.clone();
				new PngLoader(png,show);
				function show(bd:BitmapData):void{
					var b:Bitmap=new Bitmap(bd);
					new ImageDisplay().showBitmap(b);
				}
//				txt.uncompress();
//				popShow("关系",txt);
			}else if(send.type==T_TestRunRet){
				var trr:K_TestRunRet=new K_TestRunRet(space);
				trr.fromKarma(send);
				var t2:ZintBuffer=trr.data.clone();
				t2.uncompress();
				popShow("单元测试",t2);
			}else if(send.type==T_SelectIdeaRet){
				var sir:K_SelectIdeaRet=new K_SelectIdeaRet(space);
				sir.fromKarma(send);
				var i:K_Idea=new K_Idea(space);
				i.fromKarma(sir.idea);
				Junior3Panel.me.showIdea(i);
			}
		}
		
		private function popShow(header:String,data:ByteArray):void{
			var text:String=data.readMultiByte(data.length,"utf-8");
			AlertShow.show(text,header);
		}
		
		private function saveReport(data:ByteArray):void{
			var box:Alert=Alert.show(reportName, "save report",  Alert.OK, null, closeHandler);
			PopUpManager.centerPopUp(box);
			function closeHandler( event:CloseEvent ):void
			{							
				if ( event.detail == Alert.OK )
				{
					var f:FileReference=new FileReference;
					f.save(data,reportName+".txt");
				}
			}
		}
		
		private function saveDb(data:ZintBuffer,version:int):void{
			
			var box:Alert=Alert.show("保存数据 v"+version+".zip", "",  Alert.OK, null, closeHandler);
			PopUpManager.centerPopUp(box);
			function closeHandler( event:CloseEvent ):void
			{							
				if ( event.detail == Alert.OK )
				{
					new File().save(data,"Junior_v"+version+".zip");
				}
			}
		}
		
		private function saveSdk(data:ZintBuffer,version:int):void{
			
			var box:Alert=Alert.show("保存SDK", "",  Alert.OK, null, closeHandler);
			PopUpManager.centerPopUp(box);
			function closeHandler( event:CloseEvent ):void
			{							
				if ( event.detail == Alert.OK )
				{
					new File().save(data,"JuniorSDK.zip");
				}
			}
		}
		
	}
}