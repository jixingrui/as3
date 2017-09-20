package old.azura.banshee.naga
{
	
	import azura.gallerid.Gal_PackOld;
	
	import azura.common.collections.ZintBuffer;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	
	public class Naga 
	{
		private var atlas:Atlas;
		private var index:Vector.<Vector.<int>>=new Vector.<Vector.<int>>();
		private var rowIdx:int;
		
		private var data_:ByteArray;
		
		function Naga(data:ByteArray)
		{
			if(data==null){
				return;
			}
			data_=new ZintBuffer(data);
			
			var zb:ZintBuffer=new ZintBuffer(data);
			var rowCount:int=zb.readZint();
			var idx:int=0;
			for(var i:int=0;i<rowCount;i++){
				var row:Vector.<int>=new Vector.<int>();
				var rowLength:int=zb.readZint();
				for(var j:int=0;j<rowLength;j++){
					row.push(idx++);
				}
				index.push(row);
			}
			atlas=new Atlas(zb.readBytes_(),true);
//			currentRow=index[0];
			
			//			for(i=0;i<rowCount;i++){
			//				for(idx=0;idx<row.length;idx++){
			//					getFrame(i,idx).idx=idx;
			//				}
			//			}
		}
		
		public function encode():ByteArray{
			return new ZintBuffer(data_);
		}
		
		//		public function dispose():void{
		//			atlas.dispose();
		//		}
		
		public function get currentRow():Vector.<int>
		{
			if(index.length>rowIdx)
				return index[rowIdx];
			else
				return null;
		}
		
		public function getFrame(row:int,frame:int):Frame{
			if(index.length<row)
				return null;
			
			rowIdx=row%rowCount;
//			currentRow=index[row];
			frame%=currentRow.length;
			var idx:int=currentRow[frame];
			//			trace("row: "+row+" idx: "+idx);
			return atlas.getFrame(idx);
		}
		
		public function get rowCount():int{
			return index.length;
		}
		
		public function get frameCount():int{
			if(currentRow==null)
				return 0;
			else
				return currentRow.length;
		}
		
		public function extractMd5(gp:Gal_PackOld):void{
			atlas.extractMd5(gp);
		}
	}
}