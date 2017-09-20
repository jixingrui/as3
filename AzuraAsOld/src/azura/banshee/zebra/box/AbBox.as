package azura.banshee.zebra.box
{
	import azura.common.algorithm.aabb.AABBTree;
	
	import flash.geom.Rectangle;
	
	public class AbBox implements AABBI
	{
		private var root:AbBoxRoot;
		protected var parent:AbBox;
		private var _aabbId:int=-1;
		
		private var _observer:AbBoxI;
		private var _descendentHasObserver:Boolean;
		
		/**
		 *relative to parent 
		 */
		private var xParent:int,yParent:int;
		/**
		 *relative to root 
		 */
		internal var xRoot:int,yRoot:int;
		/**
		 *relative to this, decided by children
		 */
		protected var bbLocal:Rectangle=new Rectangle();
//		/**
//		 *relative to root 
//		 */
//		private var bbRoot:Rectangle=new Rectangle();
		
		//============ branch only ==========
		protected var children:Vector.<AbBox>;
		private var leftChild:AbBox;
		private var rightChild:AbBox;
		private var topChild:AbBox;
		private var bottomChild:AbBox;
		
		public function AbBox(parent:AbBox){
			if(this is AbBoxRoot){
				this.parent=null;
				this.root=this as AbBoxRoot;
			}else if(parent==null){
				throw new Error("Zbox must have parent");
			}else if(parent is AbBoxLeaf){
				throw new Error("ZboxLeaf cannot be parent");
			}else{
				this.parent=parent;
				this.root=parent.root;
				parent.addChild(this);
			}
		}
		
		private function addChild(child:AbBox):void{
			if(children==null){
				children=new Vector.<AbBox>();
				leftChild=child;
				rightChild=child;
				topChild=child;
				bottomChild=child;
			}
			children.push(child);
		}
		
		private function removeChild(child:AbBox):void{
			children.splice(children.indexOf(child),1);
			var temp:Vector.<AbBox>=new Vector.<AbBox>();
			for each(var c:AbBox in children){
				temp.push(c);
			}
			children=null;
			leftChild=null;
			rightChild=null;
			topChild=null;
			bottomChild=null;
			bbLocal=new Rectangle();
			for each(var t:AbBox in temp){
				addChild(child);
			}
		}
		
		public function dispose():void{
			parent.removeChild(this);
			parent=null;
			root=null;
		}
		
		public function get aabbId():int
		{
			return _aabbId;
		}
		
		public function set aabbId(value:int):void
		{
			_aabbId = value;
		}
		
		/**
		 * 
		 * @param x relative to parent
		 * @param y relative to parent
		 * 
		 */
		public function move(x:int,y:int):void{
			if(xParent==x&&yParent==y)
				return;
			
			xParent=x;
			yParent=y;
			
			//			trace("move",x,y,aabbId,this);
			
			updateSelf();
			updateDown();
			updateUp();
		}
		
		private function get descendentHasObserver():Boolean
		{
			return _descendentHasObserver;
		}
		
		private function set descendentHasObserver(value:Boolean):void
		{
			_descendentHasObserver = value;
			if(parent!=null){
				var pHave:Boolean=value;
				if(!pHave){
					for each(var child:AbBox in parent.children){
						if(child._observer!=null||child._descendentHasObserver){
							pHave=true;
							break;
						}
					}
				}
				parent.descendentHasObserver=pHave;
			}
		}
		
		private function get ancestorHasObserver():Boolean
		{
			var pHave:Boolean=false;
			var p:AbBox=parent;
			while(p!=null&&!pHave){
				pHave=(p.observer!=null);
				p=p.parent;
			}
			return pHave;
		}
		
		public function get observer():AbBoxI{
			return _observer;
		}
		
		public function set observer(value:AbBoxI):void
		{
			_observer = value;
			if(parent!=null)
				parent.descendentHasObserver=(value!=null);
		}
		
		private function updateUp():void{
			if(ancestorHasObserver){
				parent.updateUp_(this);
			}
		}
		
		private function updateUp_(child:AbBox):void{
			
			if(leftChild!=child && (child.bbLocal.left+child.xParent)<(leftChild.bbLocal.left+leftChild.xParent)){
				leftChild=child;
			}
			if(rightChild!=child && (child.bbLocal.right+child.xParent)>(rightChild.bbLocal.right+rightChild.xParent)){
				rightChild=child;
			}
			if(topChild!=child && (child.bbLocal.top+child.yParent)<(topChild.bbLocal.top+topChild.yParent)){
				topChild=child;
			}
			if(bottomChild!=child && (child.bbLocal.bottom+child.yParent)>(bottomChild.bbLocal.bottom+bottomChild.yParent)){
				bottomChild=child;
			}
			
			var newLocal:Rectangle=new Rectangle();
			newLocal.left=leftChild.bbLocal.left+leftChild.xParent;
			newLocal.right=rightChild.bbLocal.right+rightChild.xParent;
			newLocal.top=topChild.bbLocal.top+topChild.yParent;
			newLocal.bottom=bottomChild.bbLocal.bottom+bottomChild.yParent;
			
			if(!newLocal.equals(bbLocal)){
				
				//				trace("bbLocal=",bbLocal," newLocal=",newLocal,aabbId,this);
				bbLocal.copyFrom(newLocal);	
				
				updateSelf();				
				updateUp();
			}
		}
		
		private function updateDown():void{
			if(descendentHasObserver){
				for each(var child:AbBox in children){
					child.updateSelf();
					child.updateDown();
				}
			}
		}
		
		
		protected function updateLeafBB():void{
			updateSelf();
			updateUp();
		}
		
		private function updateSelf():void{
			if(parent==null)
				return;
			
			xRoot=parent.xRoot+this.xParent;
			yRoot=parent.yRoot+this.yParent;
			var bbRoot:Rectangle=new Rectangle(); 
			bbRoot.copyFrom(bbLocal);
			bbRoot.x+=xRoot;
			bbRoot.y+=yRoot;
			
			if(_observer!=null){
				//				trace("update",this);
				root.tree.updateLeaf(this,bbRoot);
			}
		}
	}
}