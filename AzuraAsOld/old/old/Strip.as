package azura.banshee.starling.ass
{
	import azura.banshee.naga.ImageContainerI;
	import azura.banshee.naga.ImageStarling;
	
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Strip extends Sprite
	{
		private static var workDelayFrame:int=10;
		private var workDelay:int;
		
		private var host:Zebra;
		internal var idx:int;
		
		private var moved:Boolean;
		private var dynamicCount:int;
		
		private var dynamic_dynamic:Dictionary=new Dictionary();
		
		public function Strip(idx:int,host:Zebra)
		{
			this.idx=idx;
			this.host=host;
			super.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			function onEnterFrame(event:Event):void{
				if(moved){
					workDelay++;
				}
				if(workDelay>workDelayFrame){
					moved=false;
					workDelay=0;	
					
					if(dynamicCount==0){
						flatten();
					}else{
						moved=true;						
						sortChildren(ImageStarling.compareFoot);
					}
				}
				
			}
		}
		
		public function onUpdatePos(event:Event):void{
			var child:ImageStarling=event.target as ImageStarling;
			var newLine:Strip=host.getLine(child.depth);
			if(newLine==this){
				moved=true;
			}else{
				removeDynamic(child);
				newLine.addDynamic(child);
			}			
		}
		
		public function addStatic(child:ImageStarling):void{
			addChild(child);
			moved=true;
//			sortChildren(compareIdx);
		}
		
		public function removeStatic(child:ImageStarling):void{
			removeChild(child);
			moved=true;
		}
		
		public function addDynamic(child:ImageStarling):void{
			child.addEventListener(Event.CHANGE,onUpdatePos);
			dynamic_dynamic[child]=child;
			addChild(child);
			moved=true;
			dynamicCount++;
			workDelay=workDelayFrame;
			
			if(isFlattened)
				unflatten();
		}
		
		public function removeDynamic(child:ImageStarling):void{
			child.removeEventListener(Event.CHANGE,onUpdatePos);
			delete dynamic_dynamic[child];
			removeChild(child);
			dynamicCount--;
			moved=true;
		}
		
		public function clear():void{
			removeChildren();
			unflatten();
		}
		
		public static function compareIdx(one:Strip, other:Strip):Number
		{			
			if(one.idx > other.idx) return 1;
			if(one.idx < other.idx) return -1;
			return 0;
		} 
		
	}
}