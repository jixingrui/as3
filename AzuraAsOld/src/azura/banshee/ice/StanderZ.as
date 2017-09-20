package azura.banshee.ice
{
	import azura.common.collections.ZintBuffer;

	public class StanderZ extends Zombie
	{
		public function StanderZ()
		{
			super();
		}
		
		public function fromBrief(zb:ZintBuffer):void{
			id=zb.readZint();
			version=zb.readZint();
		}
	}
}