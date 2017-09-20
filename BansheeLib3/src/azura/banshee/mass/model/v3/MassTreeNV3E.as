package azura.banshee.mass.model.v3
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.collection.ZboxRect3;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	
	public class MassTreeNV3E extends MassTreeNV3
	{
		private var _debugBox:ZboxRect3;
		private var _cross:ZboxBitmap3;
		
		private var user:DragGreenBox3;
		
		public function MassTreeNV3E(parentZbox:Zbox3, model:MassTreeN3)
		{
			super(parentZbox, model);
			blueBox();
		}
		
		public function closeE():void{
			zbox.dispose();
		}
		
		override public function showSelfBox():void{
			super.showSelfBox();
			if(_debugBox!=null){
				debugBox.resize(zbox.width,zbox.height);
			}
		}
		
		public function updatePos():void{
			
			if(model.box.x.int_percent==true)
				model.box.x.value=zbox.x;
			if(model.box.y.int_percent==true)
				model.box.y.value=zbox.y;
			
			model.adaptSize();
			MassTree3E(model.tree).onUpdatePos.dispatch(zbox.x,zbox.y);
		}
		
		override protected function enableTouch():void{
			//stop parent
		}
		
		public function blueBox():void{
			
			debugBox.paint(0xff0000ff);
			debugBox.zbox.move(pivotX,pivotY);
			debugBox.resize(zbox.width,zbox.height);
			_cross.zbox.visible=false;
			
			if(user!=null){
				debugBox.zbox.removeGesture(user);
				user=null;
			}
		}
		
		public function greenBox():void{
			
			debugBox.paint(0xff00ff00);				
			debugBox.zbox.move(pivotX,pivotY);
			debugBox.resize(zbox.width,zbox.height);
			_cross.zbox.visible=true;
			
			if(user==null){
				user=new DragGreenBox3();
				user.nve=this;
				debugBox.zbox.addGesture(user);
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
		
		public function get pivotX():Number{
			if(_image==null)
				return 0;
			else
				return _image.zbox.touchDX;
		}
		
		public function get pivotY():Number{
			if(_image==null)
				return 0;
			else
				return _image.zbox.touchDY;
		}
	}
}