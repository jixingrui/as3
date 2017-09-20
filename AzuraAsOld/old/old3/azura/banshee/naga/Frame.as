package old.azura.banshee.naga
{
	import azura.gallerid.Gal_PackOld;
	
	import azura.common.collections.BitSet;
	import azura.common.collections.LBSet;
	import azura.common.collections.ZintBuffer;
	
	public class Frame
	{
		public var xOnSheet:int, yOnSheet:int;
		public var width:int, height:int;
		public var xLeftTop:int, yLeftTop:int;
		public var xCenter:int, yCenter:int;
		public var md5Sheet:Vector.<String>=new Vector.<String>();
		private var lbs:LBSet;
		private var bs:BitSet;
		
		private var histo:Histogram;
		
		public var idx:int;
		
		public function Frame(zb:ZintBuffer)
		{
			xOnSheet=zb.readZint();
			yOnSheet=zb.readZint();
			width=zb.readZint();
			height=zb.readZint();
			xLeftTop=zb.readZint();
			yLeftTop=zb.readZint();
			xCenter=zb.readZint();
			yCenter=zb.readZint();
			md5Sheet.push(zb.readUTF());
			md5Sheet.push(zb.readUTF());
			md5Sheet.push(zb.readUTF());
			lbs=new LBSet(zb.readBytes_());
			
//			bs=lbs.toBitSet();
		}
		
//		public function hit(x:int,y:int):Boolean{
//			return bs.getBitAt(x+y*width);
//		}
		
		public function get shadowDx():int{
			if(histo==null){
				histo=new Histogram(lbs,width);
			}
			return histo.shadowDx;
		}
		
		public function get shadowWidth():int{
			if(histo==null){
				histo=new Histogram(lbs,width);
			}
			return histo.shadowWidth;
		}
		
		public function extractMd5(gp:Gal_PackOld):void{
			gp.addSlave(md5Sheet[0]);
			gp.addSlave(md5Sheet[1]);
			gp.addSlave(md5Sheet[2]);
		}
		
//		public function loadTexture(ret_FrameLoader:Function,priority:Boolean):void{	
//			fl=FrameLoader.load(this,ret_FrameLoader);
//		}
		
//		public function dispose():void{
//			fl.dispose();
//		}
	}
}
