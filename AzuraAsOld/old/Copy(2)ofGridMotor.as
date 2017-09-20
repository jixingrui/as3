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
		private var lpt:int;
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
		private var tn:int;
		private var dpre:Number;
		private var _dp:int;
		
		
		//============================== init time==============================
		public function GridMotor(frameWidth:int,frameHeight:int,itemWidth:int,itemHeight:int,down_right:Boolean,visual:GridI){
			this.fw=frameWidth;
			this.fh=frameHeight;
			this.iw=itemWidth;
			this.ih=itemHeight;
			this.down_right=down_right;
			this.dir=(down_right)?1:-1;
			this.visual=visual;
			
			fsp=(fw*(1-dir)+fh*(1+dir))/2;
			fss=(fw*(1+dir)+fh*(1-dir))/2;
			isp=(iw*(1-dir)+ih*(1+dir))/2;
			iss=(iw*(1+dir)+ih*(1-dir))/2;
			
			npv=Math.floor(fsp/isp);
			nsv=Math.floor(fss/iss);
			
			lpm=Math.round((fsp-npv*isp)/(npv+1));
			lph=Math.floor(0.5*(fsp-(npv-1)*lpm-npv*isp));
			lpt=fsp-(npv-1)*lpm-npv*isp-lph;
			lsm=Math.round((fss-nsv*iss)/(nsv+1));
			lsh=Math.floor(0.5*(fss-(nsv-1)*lsm-nsv*iss));
			lst=fss-(nsv-1)*lsm-nsv*iss-lsh;
			
			dpmin=Math.min(0,-(npt-npv)*(isp+lpm)+lpm-lph);
			
			visual.gridPageSize(npv);
			visual.gridMoveShell(0,0);
			visual.showHead(showHead);
			visual.showTail(showTail);
		}
		
		//============================== item time==============================
		public function addItem(item:ItemI):void{
			item.gridIdx=itemList.length;
			itemList.push(item);
			refreshItem();
			
			var pos:Point=idxToPos(it-1);
//			visual.gridAddItem(item);
			visual.gridMoveItem(item,pos.x,pos.y);
		}
		
		public function removeItemAt(idx:int):void{
			var item:ItemI=itemList[idx];
			itemList.splice(idx,1);
//			visual.gridRemoveItem(item);
			refreshItem();
			
			for(var i:int=idx;i<itemList.length;i++){
				item=itemList[i];
				var pos:Point=idxToPos(i);
				visual.gridMoveItem(item,pos.x,pos.y);
			}
		}
		
		private function idxToPos(idx:int):Point{
			var p:int=Math.round(Math.floor(idx/nsv)*(isp+lpm)+lph+0.5*(isp-fsp));
			var s:int=Math.round((idx-nsv*Math.floor(idx/nsv))*(iss+lsm)+lsh+0.5*(iss-fss));
			var pos:Point=new Point();
			pos.x=(p*(1-dir)+s*(1+dir))/2;
			pos.y=(p*(1+dir)+s*(1-dir))/2;
			return pos;
		}
		
		private function refreshItem():void{
			it=itemList.length;
			npt=Math.ceil(it/nsv);
			dpmin=Math.min(0,-(npt-npv)*(isp+lpm)+lpm-lph);
			
			var npptNew:int=npt-npv+1;
			if(nppt!=npptNew){
				nppt=npptNew;
				visual.gridPageCount(nppt);
			}
			checkArrow();			
			refreshAlpha();
		}
		
//		public function removeLastItem():void{
//			var item:ItemI=itemList.pop();
//			visual.gridRemoveItem(item);
//			refreshItem();
//		}
		
		
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
		}
		
		public function dragEnd():void{
			var forward:int=(dp>pDown)?1:-1;
			var dpm:int=-(isp+lpm)*(Math.ceil((-dp+lpm-lph)/(isp+lpm))-(1+forward)/2);
			var dpTo:int=Math.min(0,Math.max(dpm,dpmin));
			
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
			var pFrom:int=dpmin-isp;
			var pTo:int=isp;
			value=Math.max(value,pFrom);
			value=Math.min(value,pTo);
			_dp=value;
			if(down_right)
				visual.gridMoveShell(0,_dp);
			else
				visual.gridMoveShell(_dp,0);
			
			tn=Math.floor((-dp+lpm-lph)/(isp+lpm));
			dpre=-dp+lpm-lph-tn*(isp+lpm);
			
			refreshAlpha();
			checkArrow();
		}
		
		private function checkArrow():void{
			var npxNew:int=Math.max(0,Math.min(nppt-1,Math.round((-dp+lpm-lph)/(lpm+isp))));
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
		}
		
		private function refreshAlpha():void{
			
			for each(var item:ItemI in itemList){
				item.gridVisible=false;
				item.gridAlpha=1;
			}
			
			//solid
			var fromSolid:int=Math.max(0,nsv*(tn+isOne(dpre)));
			var toSolid:int=Math.min(it-1,nsv*(tn+npv)-1);
			for(var idxSolid:int=fromSolid;idxSolid<=toSolid;idxSolid++){
				itemList[idxSolid].gridVisible=true;
			}
			
			//alpha1
			var fromAlpha1:int=Math.max(0,nsv*tn*isOne(dpre));
			var toAlpha1:int=Math.min(it,nsv*(tn+1)*isOne(dpre));
			var alpha1:Number=1-(dpre-lpm)/isp;
			for(var idxAlpha1:int=fromAlpha1;idxAlpha1<toAlpha1;idxAlpha1++){
				itemList[idxAlpha1].gridVisible=true;
				itemList[idxAlpha1].gridAlpha=alpha1;
			}
			
			//alpha2
			var fromAlpha2:int=Math.max(0,nsv*(tn+npv)*isOne(dpre));
			var toAlpha2:int=Math.min(it,nsv*(tn+npv+1)*isOne(dpre));
			var alpha2:Number=1-((isp+lpm)*(tn+npv+1)+dp+lph-lpm-fsp)/isp;
			for(var idxAlpha2:int=fromAlpha2;idxAlpha2<toAlpha2;idxAlpha2++){
				itemList[idxAlpha2].gridVisible=true;
				itemList[idxAlpha2].gridAlpha=alpha2;
			}
		}
		
		public function  clear():void{
			dp=0;
			itemList=new Vector.<ItemI>();
			refreshItem();
//			while(itemList.length>0){
//				var item:ItemI=itemList.pop();
////				visual.gridRemoveItem(item);
//			}
		}
		
		private function isOne(value:int):int{
			if(value==0)
				return 0;
			else
				return 1;
		}
	}
}