package azura.banshee.zebra.zode
{
	import azura.banshee.zebra.atlas.Zatlas;
	import azura.gallerid3.Gallerid;
	
	import org.osflash.signals.Signal;
	
	public class ZatlasOp
	{
		private var node:ZboxOld;
		private var _data:Zatlas;
		public var sheetList:Vector.<ZsheetOp>=new Vector.<ZsheetOp>();
		
		public var idle_loading_loaded:int=0;
		private var ret:Function;
		
		public function ZatlasOp(node:ZboxOld)
		{
			this.node=node;
		}
		
		public function get data():Zatlas
		{
			return _data;
		}
		
		public function set data(value:Zatlas):void
		{
			_data = value;
			for(var i:int=0;i<value.sheetList.length;i++){
				var op:ZsheetOp=new ZsheetOp();
				sheetList.push(op);
				op.usageType=ZsheetOp.Anim;
				op.me5=value.sheetList[i].me5;
			}
		}
		
		/**
		 * 
		 * always return
		 * 
		 */
		public function load(ret_ZatlasOp:Function):void{
//			trace("load atlas",this);
			ret=ret_ZatlasOp;
			
			if(ret_ZatlasOp==null)
				throw new Error();
			
			if(idle_loading_loaded==1)
				return;
			else if(idle_loading_loaded==2){
				ret.call(null,this);
				ret=null;
			}
			
			idle_loading_loaded=1;
			for each(var s:ZsheetOp in sheetList){
				s.onLoaded.addOnce(sheetLoaded);
				node.loadTexture(s);
			}
		}
		
		public function sheetLoaded():void{
			if(ret==null)
				return;
			
			var allDone:Boolean=true;
			for each(var s:ZsheetOp in sheetList){
				if(!s.isLoaded){
					allDone=false;
					break;
				}
			}
			if(allDone){
				idle_loading_loaded=2;
//				trace("loaded atlas",this);
				ret.call(null,this);
				ret=null;
			}
		}
		
		public function sleep():void{
			ret=null;
		}
		
		public function dispose():void{
			idle_loading_loaded=0;
			ret=null;
			_data=null;
			
			for each(var s:ZsheetOp in sheetList){
				s.dispose();
			}
			sheetList=new Vector.<ZsheetOp>();
		}
	}
}