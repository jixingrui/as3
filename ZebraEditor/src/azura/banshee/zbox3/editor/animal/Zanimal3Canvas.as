package azura.banshee.zbox3.editor.animal
{
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.Zebra3;
	import azura.banshee.zbox3.editor.EditorCanvas3;
	import azura.banshee.zbox3.editor.RotaterG5;
	
	public class Zanimal3Canvas
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
		
		public function showZebra(zebra:Zebra3):void{
			actor.zbox.move(0,0);
			actor.feedZebra(zebra);
		}
		
		public function deactivate():void{
			actor.zbox.dispose();
			ec.space.removeGesture(rotator);
		}
		
	}
}