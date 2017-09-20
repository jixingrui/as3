package azura.common.util
{
	import flash.system.Capabilities;

	public class OS
	{
		private static var os:String=flash.system.Capabilities.version.substr(0,3);
		
		public static function get isBrowser():Boolean{
			return Capabilities.playerType=="ActiveX"||Capabilities.playerType=="PlugIn";
		}
			
		public static function get isPc():Boolean{
			return os=='WIN';
		}
		
		public static function get isAndroid():Boolean{
			return os=='AND';
		}
		
		public static function get isIos():Boolean{
			return os=='IOS';
		}
		
		public static function get ordinal():int{
			if(isPc)
				return 0;
			else if(isAndroid)
				return 1;
			else if(isIos)
				return 2;
			else
				return 4;
		}
	}
}