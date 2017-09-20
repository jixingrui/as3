package azura.gallerid4
{
	import azura.common.algorithm.crypto.MC5;
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.DictionaryUtil;
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * 
	 * (size:int,master:String,master:ByteArray,[slave:String,slave:ByteArray...])
	 * 
	 */
	public class GalPack4 implements Gal4PackI
	{
		private var _master:String;
		public var slaveSet:Dictionary=new Dictionary();
		
		public function get master():String
		{
			return _master;
		}
		
		//		public static function loadFile(file:File):String{
		//			return new Gal4Pack().loadFrom(file);
		//		}
		
		public function setMaster(data:ByteArray):void{
			if(master!=null)
				throw new Error("already set");
			
			_master=new MC5().fromBytes(data).toString();
			Gal4.write(master,data,true,true);
		}
		
		public function addSlave(mc5:String):void{
			if(slaveSet==null)
				throw new Error("already saved");
			
			slaveSet[mc5]=mc5;
		}
		
		public function addSlaveList(slaveList:Vector.<String>):void{
			if(slaveSet==null)
				throw new Error("already saved");
			
			for each(var slave:String in slaveList){
				slaveSet[slave]=slave;
			}
		}
		
		public function eatSlaves(gp:GalPack4):void{
			for each(var slave:String in gp.slaveSet){
				addSlave(slave);
			}
		}
		
		public function getMc5List(dest:Vector.<String>):void{
			dest.push(master);
			for each(var slave:String in slaveSet){
				dest.push(slave);
			}
		}
		
		// ============ write ========
		public function toIndex():ZintBuffer{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(master);
			var size:int=DictionaryUtil.getLength(slaveSet);
			zb.writeZint(size);
			for each(var s:String in slaveSet){
				zb.writeUTFZ(s);
			}
			zb.position=0;
			return zb;
		}
		
		public function fromIndex(zb:ZintBuffer):GalPack4{
			_master=zb.readUTFZ();
			var size:int=zb.readZint();
			for(var i:int=0;i<size;i++){
				var s:String=zb.readUTFZ();
				slaveSet[s]=s;
			}
			return this;
		}
		
		public function saveToFile(fileName:String):void{
			var file:File=File.desktopDirectory.resolvePath(fileName);
			file.browseForSave("Save file");
			file.addEventListener(Event.SELECT, onSaveSelect);
		}
		
		private function onSaveSelect(e:Event):void{
			var saveFile:File = e.target as File;
			var directory:String = saveFile.url;
			
			//check if by miracle they put the extension in, then add it
			//			if(directory.indexOf(ext) == -1){
			//				directory += ext;
			//			}
			
			var file:File = new File();
			file = file.resolvePath(directory);
			
			saveTo(file);
		}
		
		public function saveTo(file:File):void{
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.WRITE);
			
			var size:int=DictionaryUtil.getLength(slaveSet)+1;
			fs.writeInt(size);
			
			saveOne(fs,master);			
			for each(var slave:String in slaveSet){
				saveOne(fs,slave);
			}
			
			fs.close();
			
//			Toast.show("file saved");
		}
		
		public function writeContent(bag:ZintBuffer):void{
			var size:int=DictionaryUtil.getLength(slaveSet)+1;
			bag.writeInt(size);
			saveOneB(bag,master);
			for each(var slave:String in slaveSet){
				saveOneB(bag,slave);
			}
		}
		
		private function saveOne(fs:FileStream,mc5:String):void{
			fs.writeUTF(mc5);			
			var plain:ByteArray=Gal4.readSync(mc5);
			var cypher:ByteArray=Rot.encrypt(plain);
			fs.writeInt(cypher.length);
			fs.writeBytes(cypher);
			//			trace("save one",mc5,"length",cypher.length);
		}
		
		private function saveOneB(fs:ZintBuffer,mc5:String):void{
			fs.writeUTF(mc5);			
			var plain:ByteArray=Gal4.readSync(mc5);
			var cypher:ByteArray=Rot.encrypt(plain);
			fs.writeInt(cypher.length);
			fs.writeBytes(cypher);
			//			trace("save one",mc5,"length",cypher.length);
		}
		
		//======================= read ======================
		public function isCached(file:File):Boolean{
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.READ);
			var size:int=fs.readInt();
			
			var gpiMaster:Gal4PackItem=loadOne(fs);	
			_master=gpiMaster.mc5;
			
			fs.close();
			
			return gpiMaster.isOnDisk;
		}
		
		public function loadFromPath(path:String):String{
			return loadFrom(new File(path));
		}
		
		public function loadFrom(file:File):String{
			var time:Number=getTimer();
			
			slaveSet=new Dictionary();
			
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.READ);
			var size:int=fs.readInt();
			
			var gpiMaster:Gal4PackItem=loadOne(fs);	
			gpiMaster.write();
			_master=gpiMaster.mc5;
//			if(gpiMaster.isOnDisk)
//				return master;
			
			for(var i:int=1;i<size;i++){
				var gpiSlave:Gal4PackItem=loadOne(fs);
				gpiSlave.write();
				slaveSet[gpiSlave.mc5]=gpiSlave.mc5;
			}
			
			Gal4.flushFileState();
			fs.close();
			
			trace("loading",file.nativePath,"took",getTimer()-time,"ms",this);
			return master;
		}
		
		public function loadFromBytes(zb:ZintBuffer):String{
			slaveSet=new Dictionary();
			
			var size:int=zb.readInt();
			
			var gpiMaster:Gal4PackItem=loadOneB(zb);	
			gpiMaster.write();
			_master=gpiMaster.mc5;
			if(gpiMaster.isOnDisk)
				return master;
			
			for(var i:int=1;i<size;i++){
				var gpiSlave:Gal4PackItem=loadOneB(zb);
				gpiSlave.write();
				slaveSet[gpiSlave.mc5]=gpiSlave.mc5;
			}
			
			Gal4.flushFileState();
			return master;
		}
		
		private function loadOne(fs:FileStream):Gal4PackItem{
			var gpi:Gal4PackItem=new Gal4PackItem();
			gpi.mc5=fs.readUTF();
			gpi.length=fs.readInt();
			fs.readBytes(gpi.cypher,0,gpi.length);
			gpi.isOnDisk=Gal4.contains(gpi.mc5);
			return gpi;
		}
		
		private function loadOneB(zb:ZintBuffer):Gal4PackItem{
			var gpi:Gal4PackItem=new Gal4PackItem();
			gpi.mc5=zb.readUTF();
			gpi.length=zb.readInt();
			zb.readBytes(gpi.cypher,0,gpi.length);
			gpi.isOnDisk=Gal4.contains(gpi.mc5);
			return gpi;
		}
	}
}