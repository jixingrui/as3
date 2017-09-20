package azura.banshee.zbox2.collection
{
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.common.collections.BoxC;
	import azura.banshee.zbox2.Zbox2;
	
	public class ZebraRect2 extends Zbox2Container implements Zbox2ControllerI
	{
		private var left:ZebraLine2;
		private var right:ZebraLine2;
		private var top:ZebraLine2;
		private var bottom:ZebraLine2;
		
		public function ZebraRect2(parent:Zbox2)
		{
			super(parent);
			left=new ZebraLine2(this.zbox);
			right=new ZebraLine2(this.zbox);
			top=new ZebraLine2(this.zbox);
			bottom=new ZebraLine2(this.zbox);
		}
		
		public function paint(color:int,thick:int=1):void{
			left.paint(color,thick);
			right.paint(color,thick);
			top.paint(color,thick);
			bottom.paint(color,thick);
		}
		
		public function shape(width:int,height:int):void{
//			zbox.move(0,0);
			zbox.width=width;
			zbox.height=height;
			left.draw(-width/2,-height/2,-width/2,height/2);
			right.draw(width/2,-height/2,width/2,height/2);
			top.draw(-width/2,-height/2,+width/2,-height/2);
			bottom.draw(-width/2,height/2,+width/2,height/2);
		}
		
	}
}