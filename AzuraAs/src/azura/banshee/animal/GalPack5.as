package azura.banshee.animal
{
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4;
	import azura.gallerid4.GalPack4;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class GalPack5
	{
		private static var version:int=20170409;
		private var master_:String;
		private var slaveList:Vector.<String>=new Vector.<String>();
		private var sealed:Boolean;
		
		public function GalPack5(){
		}
		
		public function get master():String
		{
			return master_;
		}
		
		public function set master(mc5:String):void{
			if(sealed)
				throw new Error();
			
			master_=mc5;
		}
		
		public function addSlave(slave:String):void{
			if(sealed)
				throw new Error();
			
			slaveList.push(slave);
		}
		
		public function addSlaveList(list:Vector.<String>):void{
			for each(var slave:String in list){
				addSlave(slave);
			}
		}
		
		public function eat(other:GalPack5):void{
			addSlave(other.master);
			addSlaveList(other.slaveList);
		}
		
		private function seal():void{
			if(sealed)
				return;
			
			if(master==null)
				throw new Error();
			
			var slaveSet:Dictionary=new Dictionary();
			for each(var slave:String in slaveList){
				slaveSet[slave]=slave;
			}
			slaveList=new Vector.<String>();
			for each(var unique:String in slaveSet){
				slaveList.push(unique);
			}
			sealed=true;
		}
		
		private function clear():void{
			sealed=false;
			slaveList=new Vector.<String>();
		}
		
		// ============ write ========
		public function toIndex():ZintBuffer{
			seal();
			
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeInt(version);
			zb.writeZint(slaveList.length+1);
			zb.writeUTFZ(master);
			for each(var s:String in slaveList){
				zb.writeUTFZ(s);
			}
			return zb;
		}
		
		public function toPack(file:File):void{
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.WRITE);
			
			var index:ZintBuffer=toIndex();
			fs.writeInt(index.length);
			fs.writeBytes(index);
			
			writeOne(fs,master);			
			for each(var slave:String in slaveList){
				writeOne(fs,slave);
			}
			
			fs.close();
			
//			Toast.show("file saved");
		}
		
		private function writeOne(fs:FileStream,mc5:String):void{
			var plain:ZintBuffer=Gal4.readSync(mc5);
			var cypher:ZintBuffer=Rot.encrypt(plain);
			fs.writeInt(cypher.length);
			fs.writeBytes(cypher);
		}
		
		public function toPackFN(fileName:String):void{
			var file:File=File.desktopDirectory.resolvePath(fileName);
			file.browseForSave("Save file");
			file.addEventListener(Event.SELECT, onSaveSelect);
			
			function onSaveSelect(e:Event):void{
				var saveFile:File = e.target as File;
				var directory:String = saveFile.url;
				var file:File = new File();
				file = file.resolvePath(directory);
				toPack(file);
			}
		}
		
		//================= read ==========
		
		public function fromIndex(zb:ZintBuffer):GalPack5{
			slaveList=new Vector.<String>();
			
			zb.position=0;
			var v:int=zb.readInt();
			if(v!=version)
				trace("warning: version not match",this);
			var size:int=zb.readZint();
			master=zb.readUTFZ();
			for(var i:int=1;i<size;i++){
				slaveList.push(zb.readUTFZ());
			}
			sealed=true;
			return this;
		}
		
		private function readBytes(fs:FileStream):ZintBuffer{
			var length:int=fs.readInt();
			var zb:ZintBuffer=new ZintBuffer();
			fs.readBytes(zb,0,length);
			return zb;
		}
		
		public function fromPack(file:File):GalPack5{
			try
			{
				fromPack5(file);
			} 
			catch(error:Error) 
			{
				trace("GalPack4:",file.name,this);
				clear();
				var gp4:GalPack4=new GalPack4();
				gp4.loadFrom(file);
				master=gp4.master;
				for each(var s:String in gp4.slaveSet){
					slaveList.push(s);
				}
				sealed=true;
			}
			return this;
		}
		
		private function fromPack5(file:File):GalPack5{
			var time:Number=getTimer();
			
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.READ);
			
			var index:ZintBuffer=readBytes(fs);
			fromIndex(index);
			
			loadOne(fs,master);
			for(var i:int=0;i<slaveList.length;i++){
				var mc5:String=slaveList[i];
				loadOne(fs,mc5);
			}
			
			Gal4.flushFileState();
			fs.close();
			
			trace("loading",file.nativePath,"took",getTimer()-time,"ms",this);
			return this;
		}
		
		private function loadOne(fs:FileStream, mc5:String):void{
			var data:ZintBuffer=readBytes(fs);
			Gal4.write(mc5,data,false,false);
		}
		
	}
}