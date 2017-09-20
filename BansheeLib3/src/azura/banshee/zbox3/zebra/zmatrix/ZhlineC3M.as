package azura.banshee.zbox3.zebra.zmatrix
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.zebra.ZebraC3;
	
	public class ZhlineC3M extends ZhlineC3
	{
		public var host:ZmatrixC3;
		
		public function ZhlineC3M(parent:Zbox3,zebra:ZebraC3,host:ZmatrixC3)
		{
			super(parent,zebra);
			this.host=host;
		}
		
//		override public function notifyReplace():void{
////			trace("replace",this);
//			host.replaceLine();
//		}
	}
}