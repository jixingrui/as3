package azura.banshee.zebra.branch
{
	import azura.banshee.zebra.data.wrap.Zatlas2;
	import azura.common.collections.ZintBuffer;
	
	public class ZHline2 implements Zebra2BranchI
	{
		public var fps:int;
		public var line:Zline2=new Zline2();;
		
		public function readFrom(reader:ZintBuffer):void
		{
			fps=reader.readZint();
			line.readFrom(reader);
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			writer.writeZint(fps);
			line.writeTo(writer);
		}
		
		public function set atlas(value:Zatlas2):void{
			line.atlas=value;
		}
	}
}