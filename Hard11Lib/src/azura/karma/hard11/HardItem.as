package azura.karma.hard11
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.karma.def.KarmaSpace;
	import azura.karma.run.Karma;
	
	import zz.karma.Hard.K_Item;
	
	[Bindable]
	public class HardItem extends K_Item implements BytesI
	{
		public static var ksHard:KarmaSpace;
		
		public var nameB:String;
		public var nameTailB:String;
		public var numChildrenB:int;
		
		private function update():void{
			nameB=name;
			nameTailB=nameTail;
			numChildrenB=numChildren;
		}
		
		public function HardItem(zb:ZintBuffer=null){
			super(ksHard);
			if(zb!=null)
				fromBytes(zb);
		}
		
		public static function fromKarmaS(k:Karma):HardItem{
			var hi:HardItem=new HardItem();
			hi.fromKarma(k);
			return hi;
		}
		
		override public function fromKarma(karma:Karma):void{
			super.fromKarma(karma);
			update();
		}
		
		public function eat(pray:HardItem):void{
			this.name=pray.name;
			this.nameTail=pray.nameTail;
			this.numChildren=pray.numChildren;
			this.color=pray.color;
			this.data=pray.data;
			update();
		}
		
		public function clone():HardItem{
			var c:HardItem=new HardItem();
			c.name=name;
			c.nameTail=nameTail;
			c.numChildren=numChildren;
			c.color=color;
			c.data=data;
			return c;
		}
		
		
	}
}