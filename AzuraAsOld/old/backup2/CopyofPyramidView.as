package azura.avalon.fi.view
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	
	import azura.common.algorithm.FoldIndex;
	
	import flash.geom.Rectangle;
	
	public class PyramidView extends PyramidFi
	{		
		private var levelOld:int=-1;
		private var levelNew:int;
		private var viewOld:Rectangle=new Rectangle();
		private var user:PvUserI;
		
		public function PyramidView(user:PvUserI)
		{
			this.user=user;
		}	
		
		/**
		 * 
		 * @param level
		 * @param vc256 in center cordinate
		 * 
		 */
		public function look(level:int,vc256:Rectangle):void{	
			//positive coordinate
			var side2:int=FoldIndex.getBound(level)*256/2;
			var view:Rectangle=vc256.clone();
			view.x=Math.floor((view.x-view.width/2+side2)/256);
			view.y=Math.floor((view.y-view.height/2+side2)/256);
			view.width=Math.ceil(view.width/256)+1;
			view.height=Math.ceil(view.height/256)+1;
			
			//			trace("frame= "+view.toString());
			
			levelNew=level;
			var tile:TileFi;
			if(levelNew!=levelOld){				
				if(levelOld!=-1){					
					for each(tile in getOverlapTiles(viewOld,levelOld)){	
						user.fogetTile(tile);
					}
				}
				
				for each(tile in getOverlapTiles(view,levelNew)){
					user.seeTile(tile);
				}
				
				levelOld=levelNew;
			}else{
				var union:Rectangle=view.union(viewOld);
				
				for each(tile in getOverlapTiles(union,levelOld)){
					var inOld:Boolean=tile.intersects(viewOld);
					var inNew:Boolean=tile.intersects(view);
					if(inNew&&!inOld){		
						user.seeTile(tile);
					}else if(!inNew&&inOld){
						user.fogetTile(tile);
					}
				}				
			}
			viewOld=view;
		}
		
		public function clear():void{
			for each(var tile:TileFi in getOverlapTiles(viewOld,levelOld)){	
				user.fogetTile(tile);
			}
			user=null;
			levelOld=-1;
		}
		
		/**
		 * 
		 * @param view in positive cordinate
		 * 
		 */
		private function getOverlapTiles(view:Rectangle,level:int):Vector.<TileFi>{
			var side:int=FoldIndex.getBound(level);
			
			var xFrom:int=Math.max(0,view.x);
			var xTo:int=Math.min(view.right,side);
			var yFrom:int=Math.max(0,view.y);
			var yTo:int=Math.min(view.bottom,side);
			
			var result:Vector.<TileFi>=new Vector.<TileFi>();
			for(var j:int=yFrom;j<yTo;j++)
				for(var i:int=xFrom;i<xTo;i++){
					var tile:TileFi=getTile(i,j,level) as TileFi;
					result.push(tile);
				}
			return result;
		}
	}
}