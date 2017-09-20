package azura.banshee.mass.view.e
{
	import azura.banshee.mass.model.MassBox;
	import azura.banshee.mass.model.MassTree;
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.sdk.MassSdkI2;
	import azura.banshee.mass.view.MassTreeV2;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.collections.Path;
	
	import flash.text.TextField;
	
	import org.osflash.signals.Signal;
	
	import starling.text.TextField;
	
	public class MassTreeVE2 extends MassTreeV2
	{
		public var selectedBox:String;
//		private var panel:MassPanel2;
		public var onUpdatePos:Signal=new Signal(int,int);
		
		public function MassTreeVE2(parent:Zbox3,data:MassTree,sdk:MassSdkI2)
		{
			super(parent,data,sdk);
			root=new MassTreeNVE2(parent,null,data.root,this);
		}
		
		public function selectBox(path:Path):void{
			onUpdatePos.removeAll();
			
//			this.panel=panel;
			var oldBox:MassTreeN=null;
			if(selectedBox!=null){
				oldBox=model.path_MassTreeN[selectedBox];
			}
			var newPath:String=path.toString();
			var newBox:MassTreeN=model.path_MassTreeN[newPath];
			if(newBox==null)
				throw new Error();
			
			if(oldBox==null && newBox!=null){
				//unselected -> selected
				if(newBox.box.isState && newBox.parent.firstState!=newBox)
					model.activate(newPath);
			}else if(oldBox!=null && newBox==null){
				//selected -> unselected : handled in unselectBox()
			}else if(oldBox!=null && newBox!=null){
				if(oldBox.box.isState && newBox.box.isState){
					//state -> state
					model.activate(newPath);
				}else if(oldBox.box.isState && !newBox.box.isState){
					//state -> normal
					if(oldBox.parent.firstState!=oldBox){
						model.activate(oldBox.parent.firstState.path);
					}
				}else if(!oldBox.box.isState && newBox.box.isState){
					//normal -> state
					if(newBox.parent.keptState!=newBox){
						model.activate(newPath);
					}
				}
			}
			
			selectedBox=newPath;
		}
		
		public function unselectBox():void{
			onUpdatePos.removeAll();
			if(selectedBox!=null){
				var ne:MassTreeN=model.path_MassTreeN[selectedBox];
				if(ne.box.isState && ne.parent.firstState!=ne){
					ne.parent.slap(ne.parent.firstState);
				}
			}
			selectedBox=null;
		}
		
		public function updateSelected(box:MassBox):void{
			box=box.clone();
			var nve:MassTreeNVE2=pathToNode(selectedBox.toString());
			
			if(nve.model.box.isState!=box.isState){
				nve.model.box=box;
				if(nve.model.box.isState){
					//the selected changed to state box
					nve.parent.model.keptState=nve.model;
				}else{
					//the selected changed to regular box
					nve.parent.model.keptState=nve.parent.model.firstState;
				}
			}else if(nve.model.box.isF2!=box.isF2){
				nve.model.box=box;
				nve.refreshBg();
			}else if(nve.model.box.isF1!=box.isF1){
				nve.model.box=box;
				nve.refreshBg();
			}else{
				nve.model.box=box;
			}
//			nve.showSelfBox();
			nve.updateSize();
		}
		
		public function pathToNode(path:String):MassTreeNVE2{
			return path_MassTreeNV2[path] as MassTreeNVE2;
		}
		
		internal function updatePos(nve:MassTreeNVE2):void{
			if(nve.model.box.x.int_percent==true)
				nve.model.box.x.value=nve.zbox.x;
			if(nve.model.box.y.int_percent==true)
				nve.model.box.y.value=nve.zbox.y;
//			panel.updatePos(nve.zbox.x,nve.zbox.y);
			onUpdatePos.dispatch(nve.zbox.x,nve.zbox.y);
		}
	}
}