package azura.banshee.zebra.branch
{
	import azura.banshee.zebra.data.wrap.Zatlas2;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	public class Zmatrix2 implements Zebra2BranchI
	{
		public var fps:int;
		public var rowList:Vector.<Zline2>=new Vector.<Zline2>();
		
		public function Zmatrix2()
		{
		}
		
		public function get rowCount():int{
			return rowList.length;
		}
		
		public function getFrame(rowIdx:int,zUp:int,frameIdx:int):Zframe2{
			//			var row:Zline2=rowList[rowIdx];
			return rowList[rowIdx].getFrame(zUp,frameIdx);
		}
		
		//		public function getFrame(angle:int,zUp:int,frameIdx:int):Zframe2{
		//			var rowIdx:int=(angle+180/rowList.length)%360/360*rowList.length;
		//			var row:Zline2=rowList[rowIdx];
		//			return row.getFrame(zUp,frameIdx);
		//		}
		
		public function set atlas(value:Zatlas2):void{
			for each(var row:Zline2 in rowList){
				row.atlas=value;
			}
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			fps=reader.readZint();
			var length:int=reader.readZint();
			for(var i:int=0;i<length;i++){
				var line:Zline2=new Zline2();
				line.readFrom(reader);
				rowList.push(line);
			}
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			writer.writeZint(fps);
			writer.writeZint(rowList.length);
			for each(var row:Zline2 in rowList){
				row.writeTo(writer);
			}
		}
	}
}