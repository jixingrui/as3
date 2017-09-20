package com.helix.grid
{
	import azura.common.ui.grid.ItemI;
	import azura.common.ui.grid.GridI;

	public class GridMotorVertical
	{
		private var visual:GridI;
		public var itemList:Vector.<ItemI>=new Vector.<ItemI>();
		
		private var W:int;
		private var H:int;
		private var w0:int;
		private var h0:int;
		
		private var mv:int;
		private var nv:int;
		
		private var rwm:int;
		private var rwl:int;
		private var rwr:int;
		private var rh:int;
		
		private var lb:int;
		
		private var _dy:int;
		private var M:int;
		
		private var oneMoreStep:int;
		
		public function GridMotorVertical(visual:GridI)
		{
			this.visual=visual;
		}
		
		public function get dy():int
		{
			return _dy;
		}
		
		public function set dy(value:int):void
		{
			_dy = value;
			var dyFrom:int=-Math.max(h0/2,lb+h0/2);
			var dyTo:int=h0/2;
			_dy=Math.max(_dy,dyFrom);
			_dy=Math.min(_dy,dyTo);
			//			trace(dy,dyFrom,dyTo);
			visual.gridMove(0,_dy);
			refreshAlpha();
		}
		
		public function setSize(frameWidth:int,frameHeight:int,itemWidth:int,itemHeight:int):void{
			this.W=frameWidth;
			this.H=frameHeight;
			this.w0=itemWidth;
			this.h0=itemHeight;
			
			mv=Math.floor(H/h0);
			nv=Math.floor(W/w0);
			
			rwm=Math.round((W-nv*w0)/(nv+1));
			rwl=(W-(nv-1)*rwm-nv*w0)/2;
			rwr=W-(nv-1)*rwm-nv*w0-rwl;
			rh=Math.floor((H-mv*h0)/(mv+1));
		}
		
		private function idxToX(idx:int):int{
			return (idx%nv)*(w0+rwm)+rwl+w0/2-W/2;
		}
		
		private function idxToY(idx:int):int{
			return Math.floor(idx/nv)*(h0+rh)+rh+h0/2-H/2;
		}
		
		public function dragMove(dest:int):void{
			//			TweenMax.to(this,1,{y:dy+itemheight});
			//			visual.gridTweenTo(Math.floor(dy/h0)*h0);
			
			if(dest>0){
				visual.hitHead();
			}else if(dest<-lb){
				visual.hitTail();
			}else if(dest>dy){
				oneMoreStep=-1;
			}else{
				oneMoreStep=1;
			}
			
//			trace("dest=",dest,"dy=",dy);
			
			dy=dest;
//			motorMove(dest);
			//			tween();
		}
		
//		public function motorMove(dy:int):void{
//			this.dy=dy;
//			var dyFrom:int=-Math.max(h0/2,lb+h0/2);
//			var dyTo:int=h0/2;
//			dy=Math.max(dy,dyFrom);
//			dy=Math.min(dy,dyTo);
////			trace(dy,dyFrom,dyTo);
//			visual.gridMove(0,dy);
//			refreshAlpha();
//		}
		
		private function refreshAlpha():void{
			var i:int=Math.floor(-dy/(h0+rh));
			var z:int=isOne(dy%(h0+rh));
			
			for each(var item:ItemI in itemList){
				item.gridVisible=false;
			}
			
			//solid
			var fromSolid:int=Math.max(nv*(i+z),0);
			var toSolid:int=Math.min(nv*(i+mv)-1,itemList.length-1);
			for(var idxSolid:int=fromSolid;idxSolid<=toSolid;idxSolid++){
				itemList[idxSolid].gridVisible=true;
			}
			
			//upper alpha
			var fromA1:int=Math.max(nv*i*z,0);
			var toA1:int=Math.min(nv*(i+1)*z,itemList.length);
			var a1:Number=1+(dy%(h0+rh)+rh)/h0;
			for(var idxA1:int=fromA1;idxA1<toA1;idxA1++){
				itemList[idxA1].gridVisible=true;
				itemList[idxA1].gridAlpha=a1;
			}
			
			//lower alpha
			var fromA2:int=Math.max(nv*(i+mv)*z,0);
			var toA2:int=Math.min(nv*(i+mv+1)*z,itemList.length);
			var a2:Number=1-((h0+rh)*(i+mv+1)+dy-H)/h0;
			for(var idxA2:int=fromA2;idxA2<toA2;idxA2++){
				itemList[idxA2].gridVisible=true;
				itemList[idxA2].gridAlpha=a2;
			}
			
//			trace("lsdfksdfj",toA2);
			
			//to integer position
			var ddym:int=-dy+dy%(h0+rh)+(h0+rh)*(1-Math.round(a1)+oneMoreStep);
			var ddy:int=-Math.max(0,Math.min(ddym,(M-mv)*(h0+rh)));
//			visual.gridTweenTo(ddy);
		}
		
		public function addItem(item:ItemI):void{
			var idx:int=itemList.length;
			
			item.gridIdx=idx;
			
			itemList.push(item);
			visual.gridAddItem(item);
			
			item.gridMove(idxToX(idx),idxToY(idx));
			
			M=Math.ceil(itemList.length/nv);
			lb=M*h0+(M+1)*rh-H;
			
			refreshAlpha();
		}
		
		public function removeLastItem():void{
			var item:ItemI=itemList.pop();
			visual.gridRemoveItem(item);
			M=Math.ceil(itemList.length/nv);
			lb=M*h0+(M+1)*rh-H;
		}
		
		public function  clear():void{
			while(itemList.length>0){
				var item:ItemI=itemList.pop();
				visual.gridRemoveItem(item);
			}
			dy=0;
		}
		
		private function isOne(value:int):int{
			if(value==0)
				return 0;
			else
				return 1;
		}
	}
}