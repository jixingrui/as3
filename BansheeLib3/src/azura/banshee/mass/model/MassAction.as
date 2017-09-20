package azura.banshee.mass.model
{
	import azura.banshee.mass.model.v3.MassTreeN3;
	import azura.common.collections.ZintBuffer;
	
	import flash.net.dns.AAAARecord;
	import azura.banshee.mass.sdk.MassCoder;
	
	[Bindable]
	public class MassAction
	{
		//=============== byType ===============
		public static var byHover:int=0;
		public static var byOut:int=1;
		public static var bySingle:int=2;
		public static var byDouble:int=3;
		public static var byActivate:int=4;
		public static var bySpank:int=5;
		
		//=============== toType =============
		public static var doSlap:int=0;
		public static var doSpank:int=1;
		public static var doReset:int=2;
		public static var to_coder:int=3;
		public static var to_mass:int=4;
		public static var to_device:int=5;
		
		//============== property =============
		public var byType:int;
		public var toType:int;
		public var targetPath:String;
		public var intMsg:int;
		public var stringMsg:String;
		
		//============== runtime ===============
		public var host:MassTreeN3;
		
		public function MassAction(host:MassTreeN3){
			this.host=host;
		}
		
		public function get target():MassTreeN3{
			return host.tree.getBox(targetPath);
		}
		
		public function init():void
		{
			byType=byActivate;
			toType=-1;
			targetPath="";
			intMsg=0;
			stringMsg="";
		}
		
		public function isInternal():Boolean{
			return toType<=2;
		}
		
		public function toCoder():MassCoder{
			var mc:MassCoder =new MassCoder();
			mc.from=host.path;
			mc.target=targetPath;
			mc.note=stringMsg;
			return mc;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			byType=zb.readZint();
			toType=zb.readZint();
			targetPath=zb.readUTFZ();
			intMsg=zb.readZint();
			stringMsg=zb.readUTFZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(byType);
			zb.writeZint(toType);
			zb.writeUTFZ(targetPath);
			zb.writeZint(intMsg);
			zb.writeUTFZ(stringMsg);
			return zb;
		}
	}
}