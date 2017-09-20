package azura.common.ui.grid.old
{
	public class PageMotor
	{
		private var pageList:Vector.<PageI>=new Vector.<PageI>();
		private var moving:Boolean;
		
		public function addPage(page:PageI):void{
			if(pageList.length==0)
				page.show();
			pageList.push(page);
		}
		
		public function moveOver():void{
			moving=false;
		}
		
		public function turnRight():void{
			if(moving)
				return;
			
			moving=true;
			
			var current:PageI=pageList.shift();
			var right:PageI=pageList.shift();
			
			current.moveOut(true);
			right.moveIn(false);
			
			pageList.push(current);
			pageList.unshift(right);
		}
		
		public function turnLeft():void{
			if(moving)
				return;
			
			moving=true;
			
			var current:PageI=pageList.shift();
			var left:PageI=pageList.pop();
			
			current.moveOut(false);
			left.moveIn(true);
			
			pageList.unshift(current);
			pageList.unshift(left);
		}
		
	}
}