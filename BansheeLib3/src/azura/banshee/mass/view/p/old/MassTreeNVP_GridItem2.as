package azura.banshee.mass.view.p.old
{
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.view.p.MassTreeNVP2;
	import azura.banshee.mass.view.p.MassTreeVP2;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.collections.BoxC;
	import azura.common.ui.grid.ItemI2;
	
	public class MassTreeNVP_GridItem2 extends MassTreeNVP2 implements ItemI2
	{
		public function MassTreeNVP_GridItem2(parentZbox:Zbox3,parentNode:MassTreeNVP2, model:MassTreeN, tree:MassTreeVP2)
		{
			super(parentZbox, parentNode, model, tree);
		}
		
		override protected function relativePosition():void{
			var nb:BoxC=model.box.localizeBox(parent.zbox.width,parent.zbox.height);
			zbox.width=nb.bb.width;
			zbox.height=nb.bb.height;
			
			MassTreeNVP_Grid2(parent).notifyChildUpdate(this);
		}
		
		override public function updatePos():void{
			//			trace("grid item update pos",this);
			super.updatePos();
			gridMoveItem(dx,dy);
		}
		
		public var dx:Number=0;
		public var dy:Number=0;
		public function gridMoveItem(x:Number,y:Number):void{
			//			trace("grid move item",x,y,this);
			this.dx=x;
			this.dy=y;
			zbox.move(dx,dy);
		}
		
		public function set gridAlpha(value:Number):void
		{
			zbox.alpha=value;
		}
		
		public function get gridVisible():Boolean
		{
			return zbox.visible;
		}
		
		public function set gridVisible(value:Boolean):void
		{
//			trace("set grid item visible=",value,zbox.oid,this);
			
			zbox.visible=value;
//			if(value)
//				doActionActivate();
		}
	}
}