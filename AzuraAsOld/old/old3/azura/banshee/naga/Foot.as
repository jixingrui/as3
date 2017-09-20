package old.azura.banshee.naga
{
	public class Foot
	{
		public var x:int,y:int,depth:int;
		
		
		public static function compare(one:FootHolderI, other:FootHolderI):Number
		{			
			if(one.foot.depth > other.foot.depth) return 1;
			if(one.foot.depth < other.foot.depth) return -1;
			if(one.foot.x > other.foot.x) return 1;
			if(one.foot.x < other.foot.x) return -1;
			return 0;
		} 
	}
}