package azura.banshee.mass.view.p.old
{
	import azura.common.ui.list.motor.ItemMeta;
	import azura.common.ui.list.motor.ListMotorItemI;
	import azura.common.ui.list.motor.ListMotorMotherI;
	import azura.common.ui.list.motor.VirtualFinger;
	
	public class ListMotorOld
	{
		private var mother:ListMotorMotherI;
		private var childList:Vector.<ItemMeta>=new Vector.<ItemMeta>();
		
		private function get ml():Number{
			return mother.shellLength;
		}
		private function get t():int{
			return childList.length;
		}
		private function cl(i:Number):Number{
			return childList[i].item.listItemLength;
		}
		private var d:Number=0;
		private var b:int=0;
		private var bed:int=0;
		private var maxt:int=0;
		private var xf0:Number=0;
		private var xf0p:Number=0;
		
		private function d0(i:int):Number{
			return childList[i].d0;
		}
		private function scl(i:int):Number{
			return childList[i].sum;
		}
		
		//=================== input ===================
		public function ListMotorOld(mother:ListMotorMotherI){
			this.mother=mother;
		}
		
		public function addChild(child:ListMotorItemI):void{
			var i:int=t;
			var im:ItemMeta=new ItemMeta(child);
			childList.push(im);
			if(i==0){
				xf0=child.listItemLength/2;
				im.sum=child.listItemLength;
			}else{
				var last:ItemMeta=childList[i-1];
				var cl0:Number=cl(i-1)/2;
				var cl1:Number=cl(i)/2;
				im.d0=last.d0+cl(i-1)/2+cl(i)/2;
				im.sum=last.sum+child.listItemLength;
			}
			bed=calcBed();
			calcXT();
		}
		
		private function calcBed():int{
			var mtr:Number=ml;
			var bed:int=0;
			for(var i:int=t-1;i>=0;i--){
				mtr-=cl(i);
				if(mtr<=0){
					bed=i+1;
					break;
				}
			}
			bed=Math.min(bed,t-1);
			return bed;
		}
		
		public function dragStart():void{
			clearVf();
			xf0p=xf0;
		}
		
		public function dragMove(dist:Number):void{
			xf0=xf0p+d;
			d=dist;
			b=getB();
			
			if(xf0==-429){
				trace("stop",this);
			}
			calcXT();
			
//			if(xf0==-432){
//				b=getB();
//			}
		}
		
		private var vf:VirtualFinger;
		public function dragEnd():void{
			//			vf=new VirtualFinger(this);
			//			vf.to(bgd(b));
		}
		
		public function dragStartV():void{
			xf0p=xf0;
		}
		public function dragEndV():void{
			clearVf();
		}
		
		private function clearVf():void{
			if(vf!=null){
				vf.stop();
				vf=null;
			}
		}
		
		public function clear():void{
			
		}
		//======================== function ==================
		private function getChild(i:int):ItemMeta{
			if(i>=t)
				return null;
			else
				return childList[i];
		}
		private function fnext(g:int, xfg:Number):Number{
			return xfg+cl(g)/2+cl(g+1)/2;
		}
		private function gapJ(g:int):Number{
			var mhr:Number=ml;
			var maxn:int=0;
			for(var i:int=g;i<=t-1;i++){
				if(mhr-cl(i)>=0){
					mhr-=cl(i);
					maxn++;
				}else{
					maxn=i-g;
					break;
				}
			}
			return mhr/(maxn+1);
		}
		private function xf(i:int):Number{
			return xf0+d0(i);
		}
		private function getB():int{
			if(xf0>=0)
				return 0;
			else if(xf(bed)<=0)
				return bed;
			else{
				var b:int=0;
				var k:int=getK();
				if(xf(k)>=0)
					b=k;
				else
					b=k+1;
				b=Math.min(b,bed);
				return b;
			}
		}
		private function getK():int{
			if(t<=1)
				return 0;
			else{
				if(-cl(0)/2<=xf0 && xf0<=cl(0)/2)
					return 0;
				else{
					for(var i:int=1;i<=t-1;i++){
						if(cl(0)/2-xf0-scl(i)==0)
							return i+1;
						//						trace(cl(0)/2,xf0,scl(i-1),scl(i),this);
						if((cl(0)/2-xf0-scl(i-1))*(cl(0)/2-xf0-scl(i))<0)
							return i;
					}
				}
			}
			throw new Error();
		}
		private function gapS(b:int):Number{
			//			trace("gapJ b",gapJ(b),this);
			//			if(b==1)
			//				trace("stop",this);
			var xfb:Number=xf(b);
			if(t==0){
				return 0;
			}else if(bed==0){
				return gapJ(b);
			}else{
				var gapb:Number=0;
				var gapt:Number=0;
				var gaph:Number=0;
				if(b==0){
					gapb=gapJ(b);
					gaph=gapb;
					gapt=gapJ(b+1);
					if(0<=xfb&&xfb<=cl(b)/2)
						return (gapb-gapt)*(2*xfb-cl(b))/(cl(b)+cl(b+1))+gapb;
					else
						return gapb;
				}else if(b==bed){
					gapb=gapJ(b);
					gaph=gapJ(b-1);
					gapt=gapb;
					if(cl(b)/2<xfb&&xfb<cl(b-1)/2+cl(b)/2)
						return (gaph-gapb)*cl(b)*(2*xfb-cl(b))/(cl(b-1)+cl(b))/cl(b-1)+gapb;
					else
						return gapt;
				}else{
					gapb=gapJ(b);
					gaph=gapJ(b-1);
					gapt=gapJ(b+1);
					if(0<=xfb&&xfb<=cl(b)/2)
						return (gapb-gapt)*(2*xfb-cl(b))/(cl(b)+cl(b+1))+gapb;
					else
						return (gaph-gapb)*cl(b)*(2*xfb-cl(b))/(cl(b-1)+cl(b))/cl(b-1)+gapb;
				}
			}
		}
		private function calcXT():void{
			var gaps:Number=gapS(b);
			var xfb:Number=xf(b);
			var i:int=b;
			var xfi:Number=xf(i);
			
			if(bed==0){
				childList[i].xt=xfb+gaps;
			}else{
				if(0<i && i<bed){
					if(0<=xfi && xfi<cl(i)/2){
						childList[i].xt=cl(i)/2+gaps+(xfi-cl(i)/2)*(cl(i)/2+cl(i+1)/2+gaps)/(cl(i)/2+cl(i+1)/2);
					}else{
						childList[i].xt=cl(i)/2+gaps+(xfi-cl(i)/2)*(cl(i)/2+cl(i-1)/2+gaps)/(cl(i)/2+cl(i-1)/2);
					}
				}else if(i==0){
					if(0<=xfi && xfi<cl(i)/2){
						childList[i].xt=cl(i)/2+gaps+(xfi-cl(i)/2)*(cl(i)/2+cl(i+1)/2+gaps)/(cl(i)/2+cl(i+1)/2);
					}else{
						childList[i].xt=xfi+gaps;
					}
				}else{
					if(0<=xfi && xfi<cl(i)/2){
						childList[i].xt=xfi+gaps;
					}else{
						childList[i].xt=cl(i)/2+gaps+(xfi-cl(i)/2)*(cl(i)/2+cl(i-1)/2+gaps)/(cl(i)/2+cl(i-1)/2);
					}
				}
			}
			
			var st:int=0;
			var ed:int=Math.max(0,t-1);
			var hl:Number=childList[i].xt;
			var hr:Number=hl;
			
			for(i=b-1;i>=0;i--){
				childList[i].xt=hl-cl(i+1)/2-gaps-cl(i)/2;
				hl=childList[i].xt;
				if(hl+cl(i)/2<0){
					st=i+1;
					break;
				}
			}
			if(b==bed){
				for(i=b+1;i<=t-1;i++){
					childList[i].xt=hr+cl(i-1)/2+gaps+cl(i)/2;
					hr=childList[i].xt;
				}
				ed=t-1;
			}else{
				for(i=b+1;i<=t-1;i++){
					childList[i].xt=hr+cl(i-1)/2+gaps+cl(i)/2;
					hr=childList[i].xt;
					if(childList[i].xt-ml-cl(i)/2>=0){
						ed=i-1;
						break;
					}
				}
			}
			
			var target:ItemMeta;
			for(i=0;i<st;i++){
				target=childList[i];
				target.item.listItemShow=false;
			}
			for(i=st;i<=ed;i++){
				target=childList[i];
				target.item.notifyMove(target.xt-ml/2);
				target.item.listItemShow=true;
			}
			for(i=ed+1;i<t;i++){
				target=childList[i];
				target.item.listItemShow=false;
			}
			
			//			if(b==4){
			//				trace("stop",this);
			//			}
			//			trace("bgd",bgd(b),"b",b,this);
			if(b+1<t)
				trace("b",b,"xt(b)",childList[b].xt,"xt(b+1)",childList[b+1].xt,"xf(b)",xf(b),"xf(b+1)",xf(b+1),"bgd",bgd(b),"gaps",gaps,"xf0",xf0,"bed",bed,"ed",ed,"hr",hr,"hl",hl,this);
		}
		private function bgd(b:int):Number{
			return cl(b)/2-xf(b);
		}
	}
}