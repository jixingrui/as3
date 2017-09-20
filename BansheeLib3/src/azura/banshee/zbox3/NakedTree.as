package azura.banshee.zbox3
{
	import azura.common.algorithm.FastMath;

	public class NakedTree
	{		
		internal var parent_:NakedTree;
		internal var childList:Vector.<NakedTree>;
		
		public var oid:int;
//		private static var count:int;
		
		public function NakedTree()
		{
			oid=FastMath.random(0,999999);
//			count++;
			//			trace("count=",count,"create:",oid,this);
		}
		
		
		public function addChild(child:NakedTree):void{
			if(childList==null)
				childList=new Vector.<NakedTree>();
			var idx:int=childList.indexOf(child);
			if(idx!=-1)
				throw new Error();
			childList.push(child);
		}
		
		public function removeChild(child:NakedTree):void{
			if(childList==null)
				throw new Error();
			var idx:int=childList.indexOf(child);
			if(idx==-1)
				throw new Error();
			childList.splice(idx,1);
			if(childList.length==0)
				childList=null;
		}
		
		public function clear():void{
			if(childList!=null){
				var copy:Vector.<NakedTree>=childList.slice();
				for each(var c:NakedTree in copy){
					c.dispose();
				}
			}
			childList=null;
			notifyClear();
		}
		
		public function dispose():void{
			clear();
			if(isDisposed)
				throw new Error();
			if(parent_==null)
				throw new Error();
			parent_.removeChild(this);
			parent_=null;
			
//			count--;
			//			trace("count=",count,"dispose:",oid,this);
		}
		
		//================== abstract =============
		
		public function get isRoot():Boolean{
			throw new Error();
		}
		
		public function get isDisposed():Boolean{
			throw new Error();
		}
		
		public function notifyClear():void{
			throw new Error();
		}
	}
}