package azura.common.ui.grid.old
{
	public class Grid
	{
		private var width:int,height:int,itemWidth:int,itemHeight:int;
		private var cols:int,rows:int;
		private var gapX:int,gapY:int;
		
		public function Grid(width:int,height:int,itemWidth:int,itemHeight:int,minGapX:int=1,minGapY:int=1)
		{
			this.width=width;
			this.height=height;
			this.itemWidth=itemWidth;
			this.itemHeight=itemHeight;
			
			this.cols=(width-minGapX)/(itemWidth+minGapX);
			this.rows=(height-minGapY)/(itemHeight+minGapY);
			cols=Math.max(1,cols);
			rows=Math.max(1,rows);
			
			this.gapX=(width-itemWidth*cols)/(cols+1);
			this.gapY=(height-itemHeight*rows)/(rows+1);
		}
		
		/**
		 * 
		 * @param itemList
		 * @return those cannot be displayed
		 * 
		 */
		public function display(itemList:Vector.<ItemI>):Vector.<ItemI>{
			var gridX:int;
			var gridY:int;
			for each(var item:ItemI in itemList){
				var x:int=gridX*itemWidth+(gridX+1)*gapX;
				var y:int=gridY*itemHeight+(gridY+1)*gapY;
				item.showAt(x,y);
				gridX++;
				if(gridX==cols)
				{
					gridX=0;
					gridY++;
					if(gridY==rows){
						break;
					}
				}
			}
			return null;
		}
	}
}