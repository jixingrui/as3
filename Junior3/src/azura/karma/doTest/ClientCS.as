package azura.karma.doTest
{
	import azura.karma.Karma;
	import azura.karma.KarmaSpace;
	import azura.karma.drop._Hard._Client.CS;
	
	public class ClientCS extends CS
	{
		public function ClientCS(space:KarmaSpace, root:Karma)
		{
			super(space, root);
		}
		
		public function receive(karma:Karma):void{
			if(karma.type==T_Add){
				karma.getInt(F_receive);
			}
		}
	}
}