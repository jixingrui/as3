package azura.common.algorithm.mover
{
	import org.osflash.signals.Signal;
	
	public class EnterFrame
	{
		private static var userList:Vector.<EnterFrameI>=new Vector.<EnterFrameI>();
		
		public static function addListener(user:EnterFrameI):void{
			var oldIdx:int=userList.indexOf(user);
			if(oldIdx>0)
				return;
			userList.push(user);
//			trace("EnterFrame user count=",userList.length);
		}
		
		public static function removeListener(user:EnterFrameI):void{
			var oldIdx:int=userList.indexOf(user);
			if(oldIdx==-1)
				return;
			userList.removeAt(oldIdx);
//			trace("EnterFrame user count=",userList.length);
		}
		
		public static function tick():void{
			for each(var user:EnterFrameI in userList){
				user.enterFrame();
			}
		}
	}
}