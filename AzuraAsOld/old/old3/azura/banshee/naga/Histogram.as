package old.azura.banshee.naga
{
	import azura.common.collections.LBSet;

	public class Histogram
	{
		public var shadowDx:int;
		public var shadowWidth:int;
		
		private var line:Vector.<int>;
		private var max:int;
		
		public function Histogram(lbs:LBSet,width:int)
		{
			line=new Vector.<int>(width,true);
			for each(var pos:int in lbs.getTrueList()){
				var x:int=pos%width;
				line[x]++;
				max=Math.max(max,line[x]);
			}
			
			var bound:int=Math.sqrt(max);
//			var bound:int=max*0.2;
			
			var left:int;
			for(left=0;left<width;left++){
				if(line[left]>bound)
					break;
			}
			var right:int;
			for(right=width-1;right>=0;right--){
				if(line[right]>bound)
					break;
			}
			if(left>=right){
				shadowDx=0;
				shadowWidth=0;
			}else{
				shadowDx=(left+right)/2-width/2;
				shadowWidth=right-left;
			}
		}
	}
}