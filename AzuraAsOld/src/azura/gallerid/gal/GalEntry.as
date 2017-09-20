package azura.gallerid.gal
{
	public class GalEntry
	{
		internal var mc5:String;
		internal var sourceList:Vector.<GalShellOld>=new Vector.<GalShellOld>();
		
		internal function getData(ret_ByteArray:Function):Boolean{
			var source:GalShellOld=null;
			while(source==null&&sourceList.length>0){
				source=sourceList[0];
				if(source.source==null){
					sourceList.shift();
					source=null;					
				}
			}
			if(source!=null){
				source.source.getData(mc5,ret_ByteArray);
				return true;
			}else{
				return false;
			}
		}
	}
}