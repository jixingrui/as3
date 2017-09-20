package azura.common.collections
{
	public class Path
	{
		public var list:Vector.<String>=new Vector.<String>();
		
		public function fromString(string:String):Path{
			var array:Array=string.split(".");
			for(var i:int=0;i<array.length-2;i++){
				list.push(array[i]);
			}
			return this;
		}
		
		public function toString():String{
			var string:String="";
			for each(var car:String in list){
				string+=car+".";
			}
			string+=".";
			return string;
		}
		
		public function get localName():String{
			return list[0];
		}
		
		public function getParent():Path{
			if(list.length<1)
				return null;
			
			var parent:Path=new Path();
			parent.list=this.list.slice(1);
			return parent;
		}
		
		public static function getParentString(path:String):String{
			return new Path().fromString(path).getParent().toString();
		}
	}
}