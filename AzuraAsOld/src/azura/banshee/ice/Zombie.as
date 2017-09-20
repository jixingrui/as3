package azura.banshee.ice
{
	import azura.common.collections.ZintBuffer;
	
	public class Zombie
	{
		public var id:int,version:int;
		public var x:int,y:int,z:int;
		private var _angle:int;
		public var skin:Skin;
		
		public var posChanged:Boolean=true;
		public var skinChanged:Boolean=true;
		
		public function get angle():int
		{
			return _angle;
		}
		
		public function set angle(value:int):void
		{
			_angle = value;
		}
		
		public function fromBytes(zb:ZintBuffer):void{
			var old:Zombie=clone();
			
			id=zb.readZint();
			version=zb.readZint();
			x=zb.readZint();
			y=zb.readZint();
			z=zb.readZint();
			angle=zb.readZint();
			skin=new Skin();
			skin.fromBytes(zb.readBytesZ());
			
			check(old);
		}
		
		public function check(old:Zombie):void{
			if(id!=old.id)
				throw new Error("wrong Zombie");
			if(version!=old.version)
				skinChanged=true;
			if(x!=old.x||y!=old.y||z!=old.z||angle!=old.angle)
				posChanged=true;
		}
		
		public function clone():Zombie{
			var c:Zombie=new Zombie();
			c.id=id;
			c.version=version;
			c.x=x;
			c.y=y;
			c.z=z;
			c.angle=angle;
			if(skin!=null)
				c.skin=skin.clone();
			return c;
		}
				
		public function toString():String{
			return "Zombie id="+id+" version="+version+" x="+x+" y="+y;
		}
	}
}