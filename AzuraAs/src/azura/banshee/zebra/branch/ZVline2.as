package azura.banshee.zebra.branch
{
	import azura.banshee.zebra.data.wrap.Zatlas2;
	import azura.common.collections.ZintBuffer;
	
	public class ZVline2 implements Zebra2BranchI
	{
		public var line:Zline2=new Zline2();
				
		public function readFrom(reader:ZintBuffer):void
		{
			line.readFrom(reader);
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			line.writeTo(writer);
		}
		
		public function set atlas(value:Zatlas2):void{
			line.atlas=value;
		}
	}
}