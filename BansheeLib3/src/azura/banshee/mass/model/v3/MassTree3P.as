package azura.banshee.mass.model.v3
{
	import azura.banshee.mass.sdk.MassCoderA4;
	import azura.banshee.zbox3.Zbox3;
	
	public class MassTree3P extends MassTree3
	{
		public function MassTree3P(zbox:Zbox3, sdk:MassCoderA4)
		{
			super(zbox, sdk);
		}
		
		override protected function newRoot():MassTreeN3{
			return new MassTreeN3P(this);
		}
	}
}