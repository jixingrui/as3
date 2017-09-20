package azura.avalon.maze.ui
{
	import com.deadreckoned.assetmanager.AssetManager;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	import spark.core.SpriteVisualElement;
	
	public class StateRollerOld extends SpriteVisualElement
	{
		public var change:Signal=new Signal(int);
		private var idx:int=-1;
		private var bm:Bitmap;
		private var source:XMLList;
		
		public function StateRollerOld()
		{
			super();
			bm=new Bitmap();
			addChild(bm);
			addEventListener(MouseEvent.MOUSE_DOWN,onClickLocal);
			function onClickLocal(event:MouseEvent):void{
				roll();
			}
		}
		
		public function set xml(value:XMLList):void{
			source=value;
			idx=-1;
			roll();
		}
		
		private function roll():void{
			if(source==null)
				return;
			
			idx++;
			if(source.state[idx]==null){
				idx=-1;
				roll();
			}
			var url:String=source.state[idx].image;
			bm.bitmapData=AssetManager.getInstance().get(url).asset;
			change.dispatch(idx);
			
			bm.x=-bm.bitmapData.width/2;
			bm.y=-bm.bitmapData.height/2;
		}
	}
}