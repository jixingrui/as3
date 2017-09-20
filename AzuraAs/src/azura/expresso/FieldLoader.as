package azura.expresso
{
	public class FieldLoader
	{
		public var id:int, type:int;
		public var isList:Boolean;
		public function FieldLoader()
		{
		}
				
		public static function compare(one:FieldLoader,two:FieldLoader):int{
			if(one.id>two.id)
				return 1;
			else if(one.id<two.id)
				return -1;
			else
				return 0;
		}
	}
}