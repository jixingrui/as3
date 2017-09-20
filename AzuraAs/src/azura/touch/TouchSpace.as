package azura.touch
{
	import azura.common.algorithm.aabb.AABBTree;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class TouchSpace implements TouchRawI
	{
		internal var tree:AABBTree=new AABBTree();
		
		//scaling view does not affect boxes
		public var scale:Number=1;
		public var dx:Number=0;
		public var dy:Number=0;
		
		private var olderTouching:Touching=new Touching();
		private var newerTouching:Touching=new Touching();
		
		public var pause:Boolean;
		
		public function addBox(box:TouchBox):void{
			box.space=this;
			tree.updateLeaf(box,box.range.toRectangle());
		}
		
		public function removeBox(box:TouchBox):void{
			var idx:int=olderTouching.touchingList.indexOf(box);
			if(idx!=-1)
				olderTouching.touchingList.splice(idx,1);
			tree.removeLeaf(box);
		}
		
		public function moveBox(box:TouchBox):void{
			var rect:Rectangle=box.range.toRectangle();
			tree.updateLeaf(box,rect);
		}
		
		/**
		 * 
		 * @TODO drop to other layers
		 * 
		 */
		public function dropBox(apple:TouchBox):void{
			var found:Vector.<TouchBox>=searchPoint(apple.range.xc,apple.range.yc);
			for each(var target:TouchBox in found){
				target.drop(apple);
			}
		}
		
		//===================== down stream =====================
		public function handDown(touchId:int, x:Number, y:Number):void{
			if(pause)
				return ;
			
			if(tree.numNodes==0)
				return ;
			
			x=x/scale+dx;
			y=y/scale+dy;
			
			var found:Vector.<TouchBox>=searchPoint(x,y);
			for each(var target:TouchBox in found){
				target.handDown(touchId,x,y);
			}
		}
		
		/**
		 * 
		 * @return consumed and stops propagation
		 * 
		 */
		public function handUp(touchId:int, x:Number, y:Number):void
		{
			if(pause)
				return ;
			
			if(tree.numNodes==0)
				return ;
			
			x=x/scale+dx;
			y=y/scale+dy;
			
			var found:Vector.<TouchBox>=searchPoint(x,y);
			for each(var target:TouchBox in found){
				target.handUp(touchId,x-dx,y-dy);
			}
		}
		
		/**
		 * 
		 * @return consumed and stops propagation
		 * 
		 */
		public function handMove(touchId:int, x:Number, y:Number):void
		{
			if(pause)
				return;
			
			if(tree.numNodes==0)
				return;
			
			x=x/scale+dx;
			y=y/scale+dy;
			
			var found:Vector.<TouchBox>=searchPoint(x,y);
			for each(var target:TouchBox in found){
				target.handMove(touchId,x,y);
			}
			
			//================ check out ===============
			if(touchId==olderTouching.touchId){
				var outO:Vector.<TouchBox>=diff(olderTouching.touchingList,found);
				for each(var oldO:TouchBox in outO){
					oldO.handOut(touchId);
				}
				olderTouching.touchingList=found;
			}else if(touchId==newerTouching.touchId){
				var outN:Vector.<TouchBox>=diff(newerTouching.touchingList,found);
				for each(var oldN:TouchBox in outN){
					oldN.handOut(touchId);
				}
				newerTouching.touchingList=found;
			}else{
				olderTouching.touchId=touchId;
				olderTouching.touchingList=found;
				var swap:Touching=olderTouching;
				olderTouching=newerTouching;
				olderTouching=swap;
			}
			
		}
		
		public function handOut(touchId:int):void{
			//this is just a tail from interface. functions elsewhere
		}
		
		public function dispose():void{
			TouchStage.removeLayer(this);
		}
		
		private function searchPoint(x:int,y:int):Vector.<TouchBox>{
			var found:Vector.<TouchBox>=new Vector.<TouchBox>();
			var raw:Vector.<Object>=tree.queryPoint(x,y);
			if(raw.length==0)
				return found;
			
			for each(var r:TouchBox in raw){
				found.push(r);
			}
			found.sort(TouchBox(raw[0]).user.sorter);
			var cut:Vector.<TouchBox>=new Vector.<TouchBox>();
			while(found.length>0){
				var item:TouchBox=found.pop();
				cut.push(item);
				if(item.user.intercept)
					break;
			}
			return cut;
		}
		
		private static function diff(now:Vector.<TouchBox>,next:Vector.<TouchBox>):Vector.<TouchBox>{
			var diff:Vector.<TouchBox>=new Vector.<TouchBox>();
			for each(var old:TouchBox in now){
				if(next.indexOf(old)==-1){
					diff.push(old);
				}
			}
			return diff;
		}
		
//		private function globalToLocal(global:Point):Point{
//			return new Point(global.x*scale+dx,global.y*scale+dy);
//		}
//		
//		private function localToGlobal(local:Point):Point{
//			return new Point((local.x+dx)/scale,(local.y+dy)/scale);
//		}
	}
}