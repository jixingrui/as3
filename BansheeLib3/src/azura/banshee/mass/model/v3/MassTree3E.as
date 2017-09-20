package azura.banshee.mass.model.v3
{
	import azura.banshee.mass.model.MassBox;
	import azura.banshee.mass.sdk.MassCoderA4;
	import azura.banshee.zbox3.Zbox3;
	
	import org.osflash.signals.Signal;
	
	public class MassTree3E extends MassTree3
	{
		public var selected:MassTreeN3E;
		public var onUpdatePos:Signal=new Signal(int,int);
		
		public function MassTree3E(zbox:Zbox3, sdk:MassCoderA4)
		{
			super(zbox, sdk);
		}
		
		override protected function newRoot():MassTreeN3{
			return new MassTreeN3E(this);
		}
		
		public function updateSelected(box:MassBox):void{
			//			var stateChange:Boolean=selected.box.isState!=box.isState;
			var oldBox:MassBox=selected.box;
			selected.box=box.clone();
			//			if(stateChange){
			//				
			//			}
			if(oldBox.isState==false && box.isState==true){
				selected.parent.slap(selected);
			}else if(oldBox.isState==true && box.isState==false){
				if(selected.parent.firstState!=null)
					selected.parent.slap(selected.parent.firstState);
				else
					selected.parent.keptState=null;
			}
			selected.initList();
			selected.adaptSize();
			//			showVisible();
			checkShow();
		}
		
		public function checkShow():void{
			var r:MassTreeN3E=root as MassTreeN3E;
			checkShow_(r);
			checkColor_(r);
			showVisible();
			if(selected!=null)
				selected.greenBox();
		}
		
		private function checkShow_(n:MassTreeN3E):void{
			for each(var c:MassTreeN3E in n.childList){
				if(c.isLeaf){
					checkDownList(c.parent as MassTreeN3E);
					return;
				}
				checkShow_(c);
			}
		}
		
		private function checkDownList(p:MassTreeN3E):void{
			p.clearKeep();
			for each(var c:MassTreeN3E in p.childList){
				if(c.box.isState==false){
					c.visible=true;
				}else{
					c.closeE();
				}
			}
			
			var cc:int=p.childStateCount;
			if(cc==1)
				p.slap(p.firstState);
			else if(cc>1){
				if(selected==null)
					p.slap(p.firstState);
				else if(selected.box.isState==false)
					p.slap(p.firstState);
				else if(selected.isLeaf==false){
					p.slap(p.firstState);
				}else{
					p.slap(selected);
				}
			}
			//			p.tree.showVisible();
		}
		
		private function checkColor_(n:MassTreeN3E):void{
			n.blueBox();
			for each(var c:MassTreeN3E in n.childList){
				checkColor_(c);
			}
		}
		
		public function selectBox(path:String):void{
			selected=path_MassTreeN3[path] as MassTreeN3E;
			if(selected==null)
				throw new Error();
			checkShow();
		}
		
		public function unselectBox():void{
			selected=null;
			checkShow();
		}
		
	}
}