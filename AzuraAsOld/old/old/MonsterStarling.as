package azura.banshee.starling.swamp
{
	import azura.banshee.naga.starling.Foot;
	import azura.banshee.naga.starling.FootI;
	
	import starling.display.Sprite;
	
	public class MonsterStarling extends Sprite implements FootI
	{
		public function MonsterStarling()
		{
			super();
		}
		
		private var _foot:Foot=new Foot();
		public function get foot():Foot
		{
			return _foot;
		}
	/**
	 * 
	 */
	}
}