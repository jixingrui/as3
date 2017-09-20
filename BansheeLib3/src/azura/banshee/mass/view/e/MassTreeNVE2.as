package azura.banshee.mass.view.e
{
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.view.MassTreeNV2;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.collection.ZboxRect3;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	
	public class MassTreeNVE2 extends MassTreeNV2
	{
		private var _debugBox:ZboxRect3;
		private var _cross:ZboxBitmap3;
		private var user:DragGreenBox2;
		
		private var none_blue_green:int;
		
		public function MassTreeNVE2(parentZbox:Zbox3,parentNode:MassTreeNVE2,model:MassTreeN,tree:MassTreeVE2)
		{
			super(parentZbox,parentNode,model,tree);
			if(model.box.isHlist || model.box.isVlist){
				for each(var childData:MassTreeN in model.childList){
					newChild(childData);
				}
			}
		}
		
		override protected function newChild(childData:MassTreeN):MassTreeNV2{
			return new MassTreeNVE2(zbox,this,childData,tree as MassTreeVE2);
		}
		
		public function get treeE():MassTreeVE2{
			return tree as MassTreeVE2;
		}
		
		
//		override public function updateFrame():void{
//			super.updateFrame();
//			if(isRoot)
//				return;
//			else if(treeE.selectedBox==null)
//				blueBox();
//			else if(this.model.path==treeE.selectedBox)
//				greenBox();
//			else
//				blueBox();
//		}
		
		private function greenBox():void{
			//			if(none_blue_green==2)
			//				return;
			none_blue_green=2;
			
			debugBox.paint(0xff00ff00);				
			debugBox.zbox.move(pivotX,pivotY);
			debugBox.resize(zbox.width,zbox.height);
			_cross.zbox.visible=true;
			
			if(user==null){
				user=new DragGreenBox2();
				user.nve=this;
				debugBox.zbox.addGesture(user);
			}
		}
		
		private function blueBox():void{
			//			if(none_blue_green==1)
			//				return;
			none_blue_green=1;
			
			debugBox.paint(0xff0000ff);
			debugBox.zbox.move(pivotX,pivotY);
			debugBox.resize(zbox.width,zbox.height);
			_cross.zbox.visible=false;
			
			if(user!=null){
				debugBox.zbox.removeGesture(user);
				user=null;
			}
		}
		
		private function get debugBox():ZboxRect3
		{
			if(_debugBox==null){
				_debugBox=new ZboxRect3(this.zbox);
				_debugBox.zbox.sortValue=-1;
				zbox.sortOne(_debugBox.zbox);
				
				_cross=new ZboxBitmap3(this.zbox);
				_cross.zbox.sortValue=-1;
				var cbd:BitmapData=Draw.cross(5,5,1);
				_cross.fromBitmapData(cbd);
			}
			return _debugBox;
		}
		
		override public function notifyChangeView():void{
		}
		
	}
}