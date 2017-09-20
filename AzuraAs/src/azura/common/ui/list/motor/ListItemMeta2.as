package azura.common.ui.list.motor
{
	
	public class ListItemMeta2
	{
		private var item:ListMotorItemI;
		public var xvStart:Number=0;
//		public var xt:Number=0;
		private var pos:Number=0;
		private var _visible:Boolean;
		
		public function ListItemMeta2(item:ListMotorItemI)
		{
			this.item=item;
		}
		
		public function move(pos:Number):void{
			this.pos=pos;
			item.notifyMove(pos);
		}
		
		public function get left():Number{
			return pos-item.listItemLength/2;
		}
		
		public function get right():Number{
			return pos+item.listItemLength/2;
		}
		
		public function get length():Number{
			return item.listItemLength;
		}
		
		
		public function get visible():Boolean
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void
		{
			if(_visible!=value){
				_visible = value;
				item.listItemShow=value;
			}
		}
		
	}
}