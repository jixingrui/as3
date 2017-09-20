package azura.banshee.naga
{
	import azura.avalon.maze.ice.Neck;
	import azura.expresso.Datum;
	
	import common.collections.ZintBuffer;
	import common.loaders.GlobalState;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	public class GroundItem extends EventDispatcher
	{
		public static const head:int=0;
		public static const ass:int=1;
		public static const foot:int=2;
		public static const invisible:int=3;
		
		public static var GroundItem_GroundItem:Dictionary=new Dictionary();
		
		public var xTp:int,yTp:int;
		public var angle:int,h:int;
		public var dx:int,dy:int,dangle:int;
		[Bindable]
		public var head_ass_foot_invisible:int=3;
		public var md5Naga:String;
		public var datum:Datum;
		
		public var gip:GroundItemPlayerI;
		
		public function GroundItem(datum:Datum,gip:GroundItemPlayerI){
			this.datum=datum;
			this.gip=gip;
			gip.gi=this;
			decodeD();
		}
		
		public function decode(zb:ZintBuffer):void{
			datum.decode(zb);
			decodeD();
		}
		
		public function encode():ZintBuffer{
			encodeD();
			return datum.toBytes();
		}
		
		
		public function get xFc():int{
			return Neck.tpToFc(xTp,yTp,GlobalState.primePlain.bound).x;
		}
		public function get yFc():int{
			return Neck.tpToFc(xTp,yTp,GlobalState.primePlain.bound).y;
		}
		
		public function encodeD():void{
			throw new Error("please override GroundItem.encodeD");
		}
		
		public function decodeD():void{
			throw new Error("please override GroundItem.decodeD");
		}
		
		public function click():void{
			trace("please override GroundItem.click");
		}
				
		public function dispose():void{
			gip.dispose();
		}		
	}
}