package azura.karma.run.bean
{
	import azura.karma.run.Karma;

	public class KarmaList
	{
		private var list:Vector.<Karma>=new Vector.<Karma>();
		private var fork:Vector.<int>;
		public function KarmaList(fork:Vector.<int>)
		{
			this.fork=fork;
		}
		
		public function push(karma:Karma):void{
			if(fork.indexOf(karma.type)==-1)
				throw new Error();
			
			list.push(karma);
		}
		
		public function clear(){
			list.splice(0,list.length);
		}
		
		public function getList():Vector.<Karma>{
			return list;
		}
	}
}