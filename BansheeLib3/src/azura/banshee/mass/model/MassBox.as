package azura.banshee.mass.model
{
	import azura.banshee.zebra.Zfont;
	import azura.common.collections.bitset.BitSet;
	import azura.common.collections.BoxC;
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.label.IntPercent;
	
	[Bindable]
	public class MassBox 
	{
		public static var STATE:int=0;
		public static var HLIST:int=1;
		public static var VLIST:int=2;
		public static var DRAG:int=3;
		public static var ZOOM:int=4;
		public static var FILL_2:int=5;
		public static var FILL_1:int=6;
		public static var INTERCEPT:int=7;
		public static var RECEIVER:int=8;
		public static var KEEP:int=9;

		public var propSet:BitSet=new BitSet();
		
		/**
		 * [1,2,3]
		 * [4,5,6]
		 * [7,8,9] 
		 */
		public var align:int=5;
		
		public var x:IntPercent=new IntPercent();
		public var y:IntPercent=new IntPercent();
		public var w:IntPercent=new IntPercent();
		public var h:IntPercent=new IntPercent();
		
		public var me5_zebra:String;
		public var zfont:Zfont=new Zfont();
		
		public var from_device:int;
		public var from_mass:String;
		
		public function MassBox()
		{
		}
		
		public function clone():MassBox{
			var c:MassBox=new MassBox();
			var zb:ZintBuffer=this.toBytes();
			zb.position=0;
			c.fromBytes(zb);
			return c;
		}
		
		public function get isState():Boolean{
			return propSet.getBitAt(STATE);
		}
		
		public function get isHlist():Boolean{
			return propSet.getBitAt(HLIST);			
		}
		
		public function get isVlist():Boolean{
			return propSet.getBitAt(VLIST);			
		}
		
		public function get isList():Boolean{
			return isHlist||isVlist;
		}
		
		public function get isDrag():Boolean{
			return propSet.getBitAt(DRAG);
		}
		
		public function get isZoom():Boolean{
			return propSet.getBitAt(ZOOM);
		}
		
		public function get isF2():Boolean{
			return propSet.getBitAt(FILL_2);
		}
		
		public function get isF1():Boolean{
			return propSet.getBitAt(FILL_1);
		}
		
		public function get isInterceptive():Boolean{
			return propSet.getBitAt(INTERCEPT);
		}
		
		public function get isReceiver():Boolean{
			return propSet.getBitAt(RECEIVER);
		}
		
//		public function get isKeep():Boolean{
//			return propSet.getBitAt(KEEP);
//		}
		
		/**
		 * 
		 * @param width of parent
		 * @param height of parent
		 * 
		 */
		public function localizeBox(widthParent:Number,heightParent:Number):BoxC{
			var lb:BoxC=new BoxC();
			lb.bb.width=w.translate(widthParent);
			if(lb.bb.width<=0)
				lb.bb.width=widthParent+lb.bb.width;
			lb.bb.height=h.translate(heightParent);
			if(lb.bb.height<=0)
				lb.bb.height=heightParent+lb.bb.height;
			
			if(align==1||align==4||align==7){
				lb.pos.x=x.translate(widthParent)-widthParent/2+lb.bb.width/2;
			}else if(align==2||align==5||align==8){
				lb.pos.x=x.translate(widthParent);
			}else{
				lb.pos.x=x.translate(widthParent)+widthParent/2-lb.bb.width/2;
			}
			
			if(align==1||align==2||align==3){
				lb.pos.y=y.translate(heightParent)-heightParent/2+lb.bb.height/2;
			}else if(align==4||align==5||align==6){
				lb.pos.y=y.translate(heightParent);
			}else{
				lb.pos.y=y.translate(heightParent)+heightParent/2-lb.bb.height/2;
			}
			
			return lb;
		}
		
		public function init():void
		{
			propSet.clear();
			align=5;
			x.string='0';
			y.string='0';
			w.string='50%';
			h.string='50%';
			me5_zebra='';
			zfont=new Zfont();
			from_device=0;
			from_mass='';
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			propSet.fromBytes(zb.readBytesZ());
			align=zb.readZint();
			x.readFrom(zb);
			y.readFrom(zb);
			w.readFrom(zb);
			h.readFrom(zb);
			me5_zebra=zb.readUTFZ();
			zfont.fromBytes(zb.readBytesZ());
			from_device=zb.readZint();
			from_mass=zb.readUTFZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytesZ(propSet.toBytes());
			zb.writeZint(align);
			x.writeTo(zb);
			y.writeTo(zb);
			w.writeTo(zb);
			h.writeTo(zb);
			zb.writeUTFZ(me5_zebra);
			zb.writeBytesZ(zfont.toBytes());
			zb.writeZint(from_device);
			zb.writeUTFZ(from_mass);
			return zb;
		}
		
	}
}