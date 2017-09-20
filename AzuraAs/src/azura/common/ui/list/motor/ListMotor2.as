package azura.common.ui.list.motor
{
	import azura.common.algorithm.FastMath;
	
	import flash.sampler.getInvocationCount;
	
	public class ListMotor2
	{
		private var mother:ListMotorMotherI;
		private var childList:Vector.<ListItemMeta2>=new Vector.<ListItemMeta2>();
		
		private var sumLength:int=0;
		private var v0:Number=0;
		private var v0D:Number=0;//hand down
		private var foot:int=0;
		private var endB:int=0;
		private var _b:int=0;
		
		private var gapPrev:Number=0;
		private var gapNext:Number=0;
		private var vtDelta:Number=0;
		private var gaps:Number=0;
		
		private var dir:int=0;
		
		public function ListMotor2(mother:ListMotorMotherI){
			this.mother=mother;
		}
		
		public function get b():int
		{
			return _b;
		}
		
		public function set b(value:int):void
		{
			if(_b==value)
				return;
			_b = value;
			mother.changeBoss(value);
		}
		
		public function addChild(child:ListMotorItemI):void{
			var im:ListItemMeta2=new ListItemMeta2(child);
			im.xvStart=sumLength+child.listItemLength/2;
			childList.push(im);
			sumLength+=child.listItemLength;
			updateAll();
			endB=findLastB();
		}
		
		public function dragStart():void{
			clearVf();
			dragStartV();
		}
		
		public function dragMove(dist:Number):void{
			dragMoveV(dist);
		}
		
		private var vf:VirtualFinger;
		public function dragEnd():void{
			dragEndV();
			vf=new VirtualFinger(this);
			vf.to(stablePos()-v0);
		}
		
		public function dragStartV():void{
			v0D=v0;
		}
		public function dragMoveV(dist:Number):void{
			dir=FastMath.sign(dist);
			v0=v0D+dist;
			updateAll();
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
		private function getChild(i:int):ListItemMeta2{
			if(i<0 || i>=childList.length)
				return null;
			else
				return childList[i];
		}
		private function updateAll():void{
			
			foot=findFoot();
			b=findBoss();
			
			var gs:int=Math.min(foot,endB);
			var start:ListItemMeta2=getChild(gs);
			
			gapPrev=gapJ(gs);
			if(gs==endB){
				gapNext=gapPrev;
			}else{
				gapNext=gapJ(foot+1);
			}
			var percent:Number=-(v0+start.xvStart-start.length/2)/start.length;
			var pLimit:Number=percent;
			pLimit=Math.max(0,pLimit);
			pLimit=Math.min(1,pLimit);
			gaps=gapPrev+pLimit*(gapNext-gapPrev);
			//			trace("percent",percent,"gaps",gaps,this);
			
			var current:ListItemMeta2=getChild(gs);
			var pin:Number=current.length/2+gaps-(start.length+gaps*2)*percent;
			current.move(pin-mother.shellLength/2);
			var i:int;
			for(i=gs+1;i<childList.length;i++){
				pin+=current.length/2+gaps;
				current=childList[i];
				pin+=current.length/2+gaps;
				current.move(pin-mother.shellLength/2);
				//				trace("pin right",pin,this);
			}			
			current=getChild(gs);
			pin=current.length/2+gaps-(start.length+gaps*2)*percent;
			for(i=gs-1;i>=0;i--){
				pin-=current.length/2+gaps;
				current=childList[i];
				pin-=current.length/2+gaps;
				current.move(pin-mother.shellLength/2);
				//				trace("pin left",pin,this);
			}
			
			updateVisible();
			
		}
		
		private function updateVisible():void{
			var bound:Number=mother.shellLength/2;
			for(var i:int=0;i<childList.length;i++){
				var current:ListItemMeta2=getChild(i);
				if((-bound<=current.left && current.left<=bound)||
					(-bound<=current.right && current.right<=bound)){
					current.visible=true;
				}else{
					current.visible=false;
				}
			}
		}
		
		private function findFoot():int{
			if(childList.length==0)
				return -1;
			
			var child:ListItemMeta2=null;
			var left:Number=0;
			var right:Number=0;
			
			for(var i:int=0;i<childList.length;i++){
				child=childList[i];
				left=v0+child.xvStart-child.length/2;
				right=v0+child.xvStart+child.length/2;
				if(left>0)
					return i;
				else if(left<=0 && right>0){
					return i;
				}
			}
			
			return childList.length-1;
		}
		private function stablePos():Number{
			var bb:int=b-dir;
			bb=Math.max(0,bb);
			bb=Math.min(endB,bb);
			var target:ListItemMeta2=getChild(bb);
			return -target.xvStart+target.length/2;
		}
		private function stablePosStatic():Number{
			var bb:int=b;
			bb=Math.max(0,bb);
			bb=Math.min(endB,bb);
			var target:ListItemMeta2=getChild(bb);
			return -target.xvStart+target.length/2;
		}
		
		private function findBoss():int{
			var boss:int=0;
			var footer:ListItemMeta2=getChild(foot);
			if(footer==null)
				return -1;
			
			if(v0+footer.xvStart<0)
				boss=foot+1;
			else
				boss=foot;
			boss=Math.min(boss,endB);
			boss=Math.max(boss,0);
			return boss;
		}
		
		private function gapJ(b:int):Number{
			var mhr:Number=mother.shellLength;
			var maxn:int=0;
			for(var i:int=b;i<childList.length;i++){
				var child:ListItemMeta2=childList[i];
				if(mhr-child.length>=0){
					mhr-=child.length;
					maxn++;
				}else{
					maxn=i-b;
					break;
				}
			}
			return mhr/(maxn*2);
		}
		
		//========================== sync =================
		public function autoTo(idx:int):void{
			b=idx;                                                   
			dragEndV();
			vf=new VirtualFinger(this);
			vf.to(stablePosStatic()-v0);
		}
		
		//========================== yida ==================
		private function findLastB():int{
			var mtr:Number=mother.shellLength;
			var bed:int=0;
			for(var i:int=childList.length-1;i>=0;i--){
				var child:ListItemMeta2=childList[i];
				mtr-=child.length;
				if(mtr<=0){
					bed=i+1;
					break;
				}
			}
			return Math.min(bed,childList.length-1);
		}
	}
}