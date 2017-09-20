package azura.banshee.mass.test
{
	import azura.banshee.mass.model.v3.MassTree3;
	import azura.banshee.mass.view.MassTreeSyncI;
	import azura.banshee.mass.view.MassTreeV2;
	
	public class CommDealer implements MassTreeSyncI
	{
		public function CommDealer()
		{
		}
		
		public var dest:MassTree3;
		
		public function massSyncOut(state:String):void
		{
//			trace(state,this);
			if(dest!=null)
				dest.syncIn(state);
		}
	}
}