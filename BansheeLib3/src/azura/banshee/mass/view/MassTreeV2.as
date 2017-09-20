package azura.banshee.mass.view
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTree;
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.sdk.MassSdkI2;
	import azura.banshee.mass.view.p.grid.MassTreeNVP_List3;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.algorithm.mover.TimerI;
	import azura.common.algorithm.mover.TimerFps;
	import azura.common.collections.Path;
	
	import flash.utils.Dictionary;
	
	public class MassTreeV2 implements TimerI
	{
		public var model:MassTree;
		public var root:MassTreeNV2;
		public var path_MassTreeNV2:Dictionary=new Dictionary();
		
		public function MassTreeV2(parent:Zbox3,data:MassTree,user:MassSdkI2)
		{
			this.model=data;
			if(user!=null)
				this.model.user=user;
			
			TimerFps.setTimer(12,this);
		}
		
		public function tick():void{
			//			trace("tick",this);
			root.updateFrame();
		}
		
		public function move(x:Number,y:Number):void{
			root.zbox.move(x,y);
		}
		
		public function changeScreenSize(w:int,h:int):void{
			root.zbox.width=w;
			root.zbox.height=h;
			root.zbox.changeViewBubbleDown();
			
			root.updateSize();
		}
		
		public function getBox(path:String):MassTreeNV2{
			return path_MassTreeNV2[path];
		}
		
		public function dispose():void{
			root.zbox.dispose();
		}
		
	}
}

