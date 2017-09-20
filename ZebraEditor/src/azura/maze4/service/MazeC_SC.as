package azura.maze4.service
{
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.GalPack4;
	import azura.karma.def.KarmaSpace;
	import azura.karma.hard11.service.HubC_SC;
	import azura.karma.run.Karma;
	
	import zz.karma.Maze.CS.K_Clear;
	import zz.karma.Maze.CS.K_Load;
	import zz.karma.Maze.CS.K_Save;
	import zz.karma.Maze.K_CS;
	import zz.karma.Maze.K_SC;
	import zz.karma.Maze.SC.K_SaveRet;
	
	public class MazeC_SC extends K_SC
	{
		private var hub:HubC_SC;
//		public static var ksMaze:KarmaSpace;
		
		public function MazeC_SC(space:KarmaSpace,hub:HubC_SC)
		{
			super(space);
//			ksMaze=space;
			this.hub=hub;
		}
		
		public function save():void{
			var s:K_Save=new K_Save(space);
			send(s.toKarma());
		}
		
		public function load(data:ZintBuffer):void{
			var L:K_Load=new K_Load(space);
			L.data=data;
			send(L.toKarma());
		}
		
		public function clear():void{
			send(new K_Clear(space).toKarma());
		}
		
		private function send(k:Karma):void{
			var cs:K_CS=new K_CS(space);
			cs.msg=k;
			hub.sendCustom(cs.toBytes());
		}
		
		public function receive(zb:ZintBuffer):void{
			fromBytes(zb);
			
			if(msg.type==T_SaveRet){
				var sr:K_SaveRet=new K_SaveRet(space);
				sr.fromKarma(msg);
				
				var mp:MazePack=new MazePack();
				mp.fromBytes(sr.mazeData);
				
				mp.gp.toPackFN(".maze");
//				trace("SaveRet: ",sr.mazeData.length,this);
			}
		}
	}
}