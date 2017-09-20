package azura.banshee.layers
{
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.common.graphics.Draw;
	import azura.common.graphics.Shadow;
	
	import com.genome2d.textures.GTexture;
	
	public class Person3 extends ZboxOld
	{
		public var name:ZebraNode;
		public var body:ZebraNode;
		public var shadow:ZebraNode;
		
		public function Person3(parent:ZboxOld)
		{
			super(parent);
			shadow=new ZebraNode(this);
			body=new ZebraNode(this);
			name=new ZebraNode(this);
			name.move(0,-170);
		}
		
//		override protected function scaleChange(scaleGlobal:Number):Number{
//			trace("scale",scaleGlobal,this);
//			return 1;
//		}
	}
}