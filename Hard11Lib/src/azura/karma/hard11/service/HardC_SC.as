package azura.karma.hard11.service
{
	import azura.common.collections.ZintBuffer;
	import azura.karma.def.KarmaSpace;
	import azura.karma.hard11.Hard11UI;
	import azura.karma.hard11.HardCSI;
	import azura.karma.hard11.HardItem;
	import azura.karma.run.Karma;
	import azura.karma.run.bean.KarmaList;
	
	import zz.karma.Hard.CS.K_Add;
	import zz.karma.Hard.CS.K_AskMore;
	import zz.karma.Hard.CS.K_Delete;
	import zz.karma.Hard.CS.K_Drop;
	import zz.karma.Hard.CS.K_Hold;
	import zz.karma.Hard.CS.K_Jump;
	import zz.karma.Hard.CS.K_Rename;
	import zz.karma.Hard.CS.K_Save;
	import zz.karma.Hard.CS.K_SelectCS;
	import zz.karma.Hard.CS.K_UnselectCS;
	import zz.karma.Hard.K_CS;
	import zz.karma.Hard.K_SC;
	import zz.karma.Hard.PS.K_RefillDownPS;
	import zz.karma.Hard.SC.K_AppendDown;
	import zz.karma.Hard.SC.K_RefillUp;
	import zz.karma.Hard.SC.K_SelectSC;
	import zz.karma.Hard.SC.K_UpdateOne;
	
	public class HardC_SC extends K_SC implements HardCSI
	{
		private var tunnel:HardTunnelI;
		public var ui:Hard11UI;
		
		public function HardC_SC(space:KarmaSpace,tunnel:HardTunnelI)
		{
			super(space);
			this.tunnel=tunnel;
		}
		
		public function receive(sd:Karma):void{
			fromKarma(sd);
			
			//cache def
			var up_down:Boolean;
			var idx:int;
			var hi:HardItem;
			var kList:KarmaList;
			var hiList:Vector.<HardItem>;
			
			switch(send.type)
			{
				case T_AppendDown:
				{
					var ad:K_AppendDown=new K_AppendDown(space);
					ad.fromKarma(send);
					hiList=itemToHiList(ad.itemList);
					ui.appendDownSc(hiList);
					break;
				}
				case T_ClearDown:
				{
					ui.clearDown();
					break;
				}
				case T_ClearUp:
				{
					ui.clearUp();
					break;
				}
				case T_RefillUp:
				{
					var ru:K_RefillUp=new K_RefillUp(space);
					ru.fromKarma(send);
					hiList=itemToHiList(ru.itemList);
					ui.fillUpSc(hiList);
					break;
				}
				case T_UnselectSC:
				{
					ui.unselect();
					break;
				}
				case T_SelectSC:
				{
					var ss:K_SelectSC=new K_SelectSC(space);
					ss.fromKarma(send);
					ui.selectSc(ss.up_down,ss.idx);
					break;
				}
				case T_UpdateOne:
				{
					var uo:K_UpdateOne=new K_UpdateOne(space);
					uo.fromKarma(send);
					hi=HardItem.fromKarmaS(uo.item);
					ui.update(uo.up_down,uo.idx,hi);
					break;
				}
				case T_ClearHold:
				{
					ui.clearHold();
					break;
				}
					
				default:
				{
					throw new Error();
				}
			}
		}
		//================== support ==============
		
		private function itemToHiList(kList:KarmaList):Vector.<HardItem>{
			var hiList:Vector.<HardItem>=new Vector.<HardItem>();
			for each(var k:Karma in kList.getList()){
				var hi:HardItem=HardItem.fromKarmaS(k);
				hiList.push(hi);
			}
			return hiList;
		}
		
		//==================== send ===================
		
		private function sendCS(karma:Karma):void{
			var cs:K_CS=new K_CS(space);
			cs.send=karma;
			tunnel.sendHard(cs.toKarma(),this);
		}
		
		public function hold():void
		{
			sendCS(new K_Hold(space).toKarma());
		}
		
		public function add():void
		{
			sendCS(new K_Add(space).toKarma());
		}
		
		public function rename(name:String):void
		{
			var r:K_Rename=new K_Rename(space);
			r.name=name;
			sendCS(r.toKarma());
		}
		
		public function delete_():void
		{
			sendCS(new K_Delete(space).toKarma());
		}
		
		public function drop():void
		{
			sendCS(new K_Drop(space).toKarma());
		}
		
		public function select(up_down:Boolean, idx:int):void
		{
			var se:K_SelectCS=new K_SelectCS(space);
			se.up_down=up_down;
			se.idx=idx;
			sendCS(se.toKarma());
		}
		
		public function unselect():void
		{
			sendCS(new K_UnselectCS(space).toKarma());
		}
		
		public function save(data:ZintBuffer):void
		{
			var s:K_Save=new K_Save(space);
			s.data=data;
			sendCS(s.toKarma());
		}
		
		public function jump():void
		{
			sendCS(new K_Jump(space).toKarma());
		}
		
		public function askMore(pageSize:int):void
		{
			var am:K_AskMore=new K_AskMore(space);
			am.pageSize=pageSize;
			sendCS(am.toKarma());
		}
	}
}