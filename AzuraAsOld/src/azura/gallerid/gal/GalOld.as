package azura.gallerid.gal
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class GalOld
	{
		private static var mc5_GalEntry:Dictionary=new Dictionary();
		private static var source_shell:Dictionary=new Dictionary();
		
		private static var memSource:MemSource=new MemSource();
		
		public static function clear():void{
			for each(var shell:GalShellOld in source_shell){
				shell.source.close();
			}
			mc5_GalEntry=new Dictionary();
			source_shell=new Dictionary();
			memSource=new MemSource();
		}
		
		public static function addSource(source:GalleridIOld,cache:Boolean=false):void{
			var shell:GalShellOld=new GalShellOld();
			shell.source=source;
			source_shell[source]=shell;
			for each(var mc5:String in source.mc5List){
				var entry:GalEntry=getCreate(mc5);
				entry.sourceList.push(shell);
			}
			
			if(cache && source is FileStreamSource){
				GalFileOld.copySource(source as FileStreamSource);
			}
		}
		
		private static function getCreate(mc5:String):GalEntry{
			var entry:GalEntry=mc5_GalEntry[mc5];
			if(entry==null){
				entry=new GalEntry();
				entry.mc5=mc5;
				mc5_GalEntry[mc5]=entry;
			}
			return entry;
		}
		
		public static function removeSource(source:GalleridIOld):void{
			var shell:GalShellOld=source_shell[source];
			if(shell==null)
				throw new Error("Gal:source not exist");
			
			shell.source=null;
		}
		
		public static function getData(mc5:String,ret_ByteArray:Function):void{
			var entry:GalEntry=mc5_GalEntry[mc5];
			if(entry==null){
				//				checkStorage(mc5);
				GalFileOld.check(mc5);
				entry=mc5_GalEntry[mc5];
				if(entry==null){
					trace("Gal:"+mc5+" not exist");
					return;				
				}
				//				throw new Error("Gal:mc5 not exist");
			}
			var success:Boolean=entry.getData(ret_ByteArray);
			if(!success){
				delete mc5_GalEntry[mc5];
				throw new Error("Gal:"+mc5+" not exist");
			}
		}
		
		
		public static function cache(data:ByteArray):String{
			var mc5:String = memSource.put(data);
			var entry:GalEntry=getCreate(mc5);
			
			var shell:GalShellOld=new GalShellOld();
			shell.source=memSource;
			
			entry.sourceList.push(shell);
			
			return mc5;
		}
	}
}