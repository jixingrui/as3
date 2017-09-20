package azura.hellios.drass6
{
	import common.collections.ZintBuffer;
	
	[Bindable][RemoteClass]
	public class Node
	{		
		public var id:int;
		public var name:String;
		public var soil:ZintBuffer;
		public var idDrass:int;
		public var idxLocal:int;
		public var isUpper:Boolean;
		
		public function Node(data:ZintBuffer){
			id=data.readZint();
			name=data.readUTF();
			soil=data.readBytes_();
		}
	}
}