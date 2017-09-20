package azura.banshee.zbox3.editor
{
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.Zebra3;
	
	public class ZebraDisplay5Canvas
	{
		public var ec:EditorCanvas3;
		public var actor:ZebraC3;
		private var rotator:RotaterG5;
		
		public function activate(ec:EditorCanvas3):void
		{
			this.ec=ec;
			
			actor=new ZebraC3(ec.space);
			
			rotator=new RotaterG5(actor);
			ec.space.addGesture(rotator);
		}
		
		public function deactivate():void{
			actor.zbox.dispose();
			ec.space.removeGesture(rotator);
		}
		
		public function showZebra(zebra:Zebra3):void{
			actor.zbox.move(0,0);
			actor.feedZebra(zebra);
		}
		
	}
}