package zmask.old
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3ReplicaI;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Zshard
	{
		public var host:Zbox3;
//		protected var renderer:Zbox3ReplicaI;
		private var bb:Rectangle;
		
		public function Zshard(host:Zbox3){
			this.host=host;
			host.shardList.push(this);
			this.renderer=host.renderer.newSprite();
		}
		
		public function getBB(axis:Point,angle:Number):Rectangle{
			var rad:Number=FastMath.angle2radian(angle);
			return FastMath.rotateRectangle(axis,bb,rad);
		}
		
		public function display(zs:Zframe2):void{
			bb=zs.boundingBox;
			renderer.display(zs);
			host.renderer.sortChildren();
		}
		
		public function set visible(value:Boolean):void{
			renderer.visible=value;
		}
		
		public function clear():void{
			renderer.clear();
		}
		
		public function dispose():void{
			renderer.dispose();
			host.removeDisplay(this);
			renderer=null;
			host=null;
		}
	}
}
