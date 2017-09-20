package azura.banshee.zbox3.collection
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	
	public class ZboxRect3 extends Zbox3Container implements Zbox3ControllerI
	{
		private var left:ZboxLine3;
		private var right:ZboxLine3;
		private var top:ZboxLine3;
		private var bottom:ZboxLine3;
		
		public function ZboxRect3(parent:Zbox3)
		{
			super(parent);
			left=new ZboxLine3(this.zbox);
			right=new ZboxLine3(this.zbox);
			top=new ZboxLine3(this.zbox);
			bottom=new ZboxLine3(this.zbox);
		}
		
		public function paint(color:int,thick:int=1):void{
			left.paint(color,thick);
			right.paint(color,thick);
			top.paint(color,thick);
			bottom.paint(color,thick);
		}
		
		public function resize(width:int,height:int):void{
			zbox.width=width;
			zbox.height=height;
			left.draw(Math.floor(-width/2),Math.floor(-height/2),Math.floor(-width/2),Math.ceil(height/2));
			right.draw(Math.floor(width/2),Math.floor(-height/2),Math.floor(width/2),Math.ceil(height/2));
			top.draw(Math.floor(-width/2),Math.floor(-height/2),Math.ceil(width/2),Math.floor(-height/2));
			bottom.draw(Math.floor(-width/2),Math.floor(height/2),Math.ceil(width/2),Math.floor(height/2));
		}
		
	}
}