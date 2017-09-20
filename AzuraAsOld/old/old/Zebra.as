package azura.banshee.starling.ass
{
	import azura.banshee.naga.ImageStarling;
	
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	
	public class Zebra extends Sprite
	{
		public static var stripSize:int=100;
		public var idx_Strip:Dictionary=new Dictionary();
				
		public function addStatic(child:ImageStarling):void{
			var line:Strip=getLine(child.depth);
			line.addStatic(child);
		}
		
		public function removeStatic(child:ImageStarling):void{
			var line:Strip=getLine(child.depth);
			line.removeStatic(child);
			checkRemove(line);
		}
		
		public function addDynamic(child:ImageStarling):void{
			var line:Strip=getLine(child.depth);
			line.addDynamic(child);
		}
		
		public function removeDynamic(child:ImageStarling):void{
			var line:Strip=getLine(child.depth);
			line.removeDynamic(child);
			checkRemove(line);
		}
		
		private function checkRemove(line:Strip):void{
			if(line.numChildren==0){
				this.removeChild(line);
				delete idx_Strip[line.idx];
			}
		}
		
		public function clear():void{
			for each(var strip:Strip in idx_Strip){
				strip.clear();
			}
			idx_Strip=new Dictionary();
		}
		
		internal function getLine(depth:int):Strip{
			var idx:int=depth/stripSize;
			var line:Strip=idx_Strip[idx];
			if(line==null){
				line=new Strip(idx,this);
				this.addChild(line);
				sortChildren(Strip.compareIdx);
				idx_Strip[idx]=line;
			}
			return line;
		}
	}
}