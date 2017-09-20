package azura.common.ui.grid
{
	
	import com.greensock.TweenMax;
	
	import flash.geom.Point;
	
	public class GridMotor
	{
		private var tween:TweenMax;
		private var visual:GridI;
		public var itemList:Vector.<ItemI>=new Vector.<ItemI>();
		private var showHead:Boolean=true;
		private var showTail:Boolean=true;
		private var pDown:int;
		
		//init time
		public var artd:int;
		private var down_right:Boolean;
		private var dir:int;
		
		private var fw:int;
		private var fh:int;
		private var iw:int;
		private var ih:int;
		
		private var fsp:Number;
		private var fss:Number;
		private var isp:Number;
		private var iss:Number;
		
		private var npv:int;
		private var nsv:int;
		
		private var lpm:int;
		private var lph:int;
		private var lsm:int;
		private var lsh:int;
		private var lst:int;
		
		//item time
		private var it:int;
		private var npt:int;
		private var nppt:int;
		private var dpmin:int;
		private var npx:int;
		
		//drag time
		private var forward:int;
		private var nNear:int;
		private var nFar:int;
		private var _dp:int;
		
		
		//============================== init time==============================
		public function GridMotor(visual:GridI,frameWidth:int,frameHeight:int,itemWidth:int,itemHeight:int,down_right:Boolean,artd:int=1000){
			
			this.visual=visual;
			this.down_right=down_right;
			this.dir=(down_right)?1:-1;
			this.artd=artd;
			
			resize(frameWidth,frameHeight,itemWidth,itemHeight);
		}
		
		public function resize(frameWidth:int,frameHeight:int,itemWidth:int,itemHeight:int):void{
			this.fw=frameWidth;
			this.fh=frameHeight;
			this.iw=itemWidth;
			this.ih=itemHeight;			
			
			initTime();
			itemTime();
			dragTime();
			moveAllItem();
		}
		
		private function initTime():void{
			fsp=(fw*(1-dir)+fh*(1+dir))/2;
			fss=(fw*(1+dir)+fh*(1-dir))/2;
			isp=(iw*(1-dir)+ih*(1+dir))/2;
			iss=(iw*(1+dir)+ih*(1-dir))/2;
			
			npv=Math.floor(fsp/isp);
			nsv=Math.floor(fss/iss);
			
			lpm=Math.floor((fsp-npv*isp)/(npv+1));
			lph=Math.floor(0.5*(fsp-npv*isp-lpm*(npv-1)));
			lsm=Math.floor((fss-nsv*iss)/(nsv+1));
			lsh=Math.floor(0.5*(fss-nsv*iss-lsm*(nsv-1)));
			lst=fss-nsv*iss-lsm*(nsv-1)-lsh;
			
			visual.gridPageSize(npv);
			visual.gridMoveShell(0,0);
			visual.showHead(showHead);
			visual.showTail(showTail);
		}
		
		public function  clear():void{
			initTime();
			itemList=new Vector.<ItemI>();
			itemTime();
			dp=0;
		}
		
		//============================== item time==============================
		public function addItem(item:ItemI):void{
			itemList.push(item);
			itemTime();
			dragTime();
			
			var pos:Point=idxToPos(it-1);
			visual.gridMoveItem(item,pos.x,pos.y);
			item.gridMoveItem(pos.x,pos.y);
		}
		
		public function removeItemAt(idx:int):void{
			var item:ItemI=itemList[idx];
			itemList.splice(idx,1);
			itemTime();
			dragTime();
			moveAllItem();
		}
		
		private function moveAllItem():void{
			for(var i:int=0;i<itemList.length;i++){
				var item:ItemI=itemList[i];
				var pos:Point=idxToPos(i);
				visual.gridMoveItem(item,pos.x,pos.y);
				item.gridMoveItem(pos.x,pos.y);
			}
		}
		
		private function itemTime():void{
			it=itemList.length;
			npt=Math.ceil(it/nsv);
			dpmin=Math.min(0,-(npt-npv)*(isp+lpm));
			
			var npptNew:int=npt-npv+1;
			if(nppt!=npptNew){
				nppt=npptNew;
				visual.gridPageCount(nppt);
			}
		}
		
		private function idxToPos(idx:int):Point{
			var p:int=(isp+lpm)*Math.floor(idx/nsv)+lph+isp/2;
			var s:int=(iss+lsm)*(idx-nsv*Math.floor(idx/nsv))+iss/2;
			var pos:Point=new Point();
			var temp:Number=s-(fss-lsh-lst)/2;
			pos.x=Math.round(p*(1-dir)/2+temp*(1+dir)/2);
			pos.y=Math.round(p*(1+dir)/2+temp*(1-dir)/2);
			return pos;
		}
		
		public function indexOf(item:ItemI):int{
			return itemList.indexOf(item);
		}
		
		//============================== drag time==============================
		public function dragStart():void{
			if(tween!=null){
				tween.kill();
				tween=null;					
			}
			pDown=dp;
		}
		
		public function dragMove(dx:int,dy:int):void{
			var delta:int;
			if(down_right)
				delta=dy;
			else
				delta=dx;
			
			dp=pDown+delta;
			forward=(dp>pDown)?1:-1;
		}
		
		public function dragEnd():void{
			tweenGrid();
		}
		
		private function tweenGrid():void{
			var dpTo:int=-(nNear+(1-forward)/2)*(isp+lpm);
			dpTo=Math.min(dpTo,0);
			dpTo=Math.max(dpTo,dpmin);
			
			if(pDown!=dp){
				tween=TweenMax.to(this,.5,{dp:dpTo});
			}
		}
		
		public function get dp():int
		{
			return _dp;
		}
		
		public function set dp(value:int):void
		{
			_dp=value;
			dragTime();
		}
		
		private function dragTime():void{
			
			//bound dp
			var pFrom:int=dpmin-artd;
			var pTo:int=artd;
			_dp=Math.max(_dp,pFrom);
			_dp=Math.min(_dp,pTo);
			
			//update var
			nNear=Math.floor(Math.max(0,-dp)/(isp+lpm));			
			nFar=Math.ceil(Math.max(0,-dp)/(isp+lpm))+npv-1;
			nFar=Math.max(nFar,0);
			
			//move
			if(down_right)
				visual.gridMoveShell(0,dp);
			else
				visual.gridMoveShell(dp,0);
			
			checkIndicators();
		}
		
		private function checkIndicators():void{
			
			//bound indicator
			var npxNew:int=Math.max(0,Math.min(nppt-1,Math.round(-dp/(lpm+isp))));
			if(npx!=npxNew){
				npx=npxNew;
				visual.gridAtPage(npx);
			}
			
			var showHeadNew:Boolean=(npx!=0);
			if(showHead!=showHeadNew)
			{
				showHead=showHeadNew;
				visual.showHead(showHead);
			}
			
			var showTailNew:Boolean=(nppt>0)&&(npx!=nppt-1);
			if(showTail!=showTailNew){
				showTail=showTailNew;
				visual.showTail(showTail);
			}
			
			//visible
			for each(var item:ItemI in itemList){
				item.gridVisible=false;
				item.gridAlpha=1;
			}
			var fromSolid:int=nsv*nNear;
			var toSolid:int=Math.min(it-1,nsv*nFar+nsv-1);
			for(var idxSolid:int=fromSolid;idxSolid<=toSolid;idxSolid++){
				itemList[idxSolid].gridVisible=true;
			}
			
			//alpha1
			var fromAlpha1:int=nsv*nNear;
			var toAlpha1:int=nsv*nNear+nsv-1;
			toAlpha1=Math.min(toAlpha1,it-1);
			var alpha1:Number=1-(Math.max(0,-dp-lph)-nNear*(isp+lpm))/isp;
			alpha1=Math.min(1,alpha1);
			alpha1=Math.max(0,alpha1);
			for(var idxAlpha1:int=fromAlpha1;idxAlpha1<=toAlpha1;idxAlpha1++){
				itemList[idxAlpha1].gridAlpha=alpha1;
			}
			
			//alpha2
			var fromAlpha2:int=nsv*nFar;
			var toAlpha2:int=nsv*nFar+nsv-1;
			toAlpha2=Math.min(toAlpha2,it-1);
			var alpha2:Number=1-((nFar+1)*(isp+lpm)-lpm+lph+dp-fsp)/isp;
			alpha2=Math.min(1,alpha2);
			alpha2=Math.max(0,alpha2);
			for(var idxAlpha2:int=fromAlpha2;idxAlpha2<=toAlpha2;idxAlpha2++){
				itemList[idxAlpha2].gridAlpha=alpha2;
			}
		}
		
		private function isOne(value:Number):int{
			if(value==0)
				return 0;
			else
				return 1;
		}
	}
}