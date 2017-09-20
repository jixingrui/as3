package old.azura.avalon.ice
{
	
	import old.azura.avalon.base.PyramidBaseOld;
	import old.azura.avalon.ice.swamp.Skin;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.mover.WalkerI;
	import azura.common.algorithm.pathfinding.BhStrider;
	import azura.common.algorithm.pathfinding.Path;
	
	import flash.geom.Point;
	import azura.common.algorithm.Neck;
	import azura.avalon.ice.Stone;
	
	public class MummyOld extends Stone implements WalkerI
	{
		private static var stride60:Number=2;
		/**
		 * n pixels/tick.
		 */
		public var stride:int=stride60;
		
		public var currentFc:Point=new Point();
		public var currentTp:Point;
		private var nextTp:Point;
		
		private var pathTp:Path=new Path();
		private var pathFc:Path;
		
//		public var map:PyramidBase;
		private var _mover:WalkerI;
		private var stand_go:Boolean=true;
		
		[Bindable]
		public var skin:Skin=new Skin();
		
		public var ready:Boolean=false;
		
		public function MummyOld(){
			pathFc=new Path(this);
		}
		
		public function get map():PyramidBaseOld{
			return GlobalState.primePlain._base;
		}
		
		public function clear():void{
//			map=null;
			//			_mover=null;
			pathTp=new Path();
			ready=false;
		}
		
		public function set mover(value:WalkerI):void
		{
			_mover = value;
			//			pathFc=new Path(value);
		}
		
		/**
		 * 
		 * @param track top and positive
		 * 
		 */
		public function goAlong(trackTp:Vector.<Point>):void{
			if(trackTp==null||trackTp.length==0)
				throw new Error("Mummy: path is empty");
			
			//filter
			var roadClear:Boolean=true;
			while(roadClear && currentTp!=null && trackTp.length>1){
				var first:Point=trackTp.shift();
				var second:Point=trackTp[0];
				var bh:BhStrider=new BhStrider(currentTp.x,currentTp.y,second.x,second.y);
				while(roadClear && bh.next(1)>0){
					roadClear&&=map.isRoad(bh.xNow,bh.yNow);
				}
				if(!roadClear){
					trackTp.unshift(first);
				}
			}
			
			var trackFc:Vector.<Point>=new Vector.<Point>();
			if(currentFc!=null)
				trackFc.push(currentFc);
			for(var i:int=0;i<trackTp.length;i++){
				var tp:Point=trackTp[i];
				var fc:Point=Neck.tpToFc(tp.x,tp.y,map.width);
				trackFc.push(fc);
			}
			pathTp.go(trackTp);
			pathFc.go(trackFc);
			
			currentTp=pathTp.next(1);//cannot be null
			nextTp=pathTp.next(1);//can be null
			
			pathFc.next(stride);
			stand_go=false;
			if(_mover!=null)
				_mover.go();
			
		}
		
		public function jump(xTc:int,yTc:int):void{
//			trace("Mummy jump "+xTc+","+yTc);
			
			ready=true;
			
			currentTp=Neck.tcToTp(xTc,yTc,map.bound);
			currentFc=Neck.tpToFc(currentTp.x,currentTp.y,map.bound);
//			currentFc.x+=4;
//			currentFc.y+=4;
			
			pathTp.jump(currentTp.x,currentTp.y);
			pathFc.jump(currentFc.x,currentFc.y);
			
			tick();
			tick();
		}
		
		public function stop():void{
		}
		
		public function tick():void{
			
			if(!ready)
				return;
			
			stride=Math.round(stride60*60/FPS.fps);
//			stride=stride60;
			
//			trace("fps="+FPS.fps+" stride="+stride);
			
			var fc:Point=pathFc.next(stride);
			if(fc!=null){
				
				currentFc=fc;
				
				if(currentTp==null)
					currentTp=Neck.fcToTp(fc.x,fc.y,map.bound);
				
				var h:int=map.getHeight(currentTp.x,currentTp.y)*map.scale*Math.SQRT2/2;
				if(_mover!=null)
					_mover.jumpTo(currentFc.x,currentFc.y,h);
				
				if(nextTp!=null && currentTp!=nextTp){
					var pTp:Point=Neck.fcToTp(fc.x,fc.y,map.bound);
					var distC:Number=FastMath.dist(pTp.x,pTp.y,currentTp.x,currentTp.y);
					var distN:Number=FastMath.dist(pTp.x,pTp.y,nextTp.x,nextTp.y);
					if(distC>distN){
						currentTp=nextTp;
						var next:Point=pathTp.next(1);
						if(next!=null){
							nextTp=next;
						}
					}
				}
			}else{
				if(stand_go==false){
					stand_go=true;
					if(_mover!=null)
						_mover.stand();
				}
			}
		}
		
		
		public function jumpTo(x:int, y:int, h:int):void
		{
			if(_mover!=null)
				_mover.jumpTo(x,y,h);
		}
		
		public function turnTo(angle:int):int
		{
			if(_mover!=null)
				return _mover.turnTo(angle);
			else
				return 0;
		}
		
		public function go():void
		{
			if(_mover!=null)
				_mover.go();
		}
		
		public function stand():void
		{
			if(_mover!=null)
				_mover.stand();
		}
	}
}