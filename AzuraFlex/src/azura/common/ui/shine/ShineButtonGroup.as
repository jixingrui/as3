package azura.common.ui.shine 
{
	public class ShineButtonGroup
	{
		private var oldFocus:ShineButton;
		
		public function set focus(newFocus:ShineButton):void
		{
			if(oldFocus==newFocus)
				return;
			
			if(oldFocus!=null){
				oldFocus.normal();
				oldFocus.unselect();
			}
			
			oldFocus = newFocus;
		}
		
		public function normal():void{
			if(oldFocus!=null)
				oldFocus.normal();
		}
		
	}
}