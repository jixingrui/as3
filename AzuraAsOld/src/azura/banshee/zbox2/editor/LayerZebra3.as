package azura.banshee.zbox2.editor
{
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zbox2.zebra.ZebraC2;
	
	public class LayerZebra3 
	{
		public var ec:EditorCanvas;
		public var actor:ZebraC2;
		private var rotator:RotaterG3;
		
		public function activate(ec:EditorCanvas):void
		{
			this.ec=ec;
			
			actor=new ZebraC2(ec.space);
			
			rotator=new RotaterG3(actor);
			ec.space.addGesture(rotator);
		}
		
		public function showZebra(zebra:Zebra2Old):void{
			actor.zbox.move(0,0);
			actor.feed(zebra);
		}
		
		public function deactivate():void{
			actor.zbox.dispose();
			ec.space.removeGesture(rotator);
		}
		
	}
}