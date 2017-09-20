package azura.banshee.starling.layers
{
	import azura.banshee.naga.starling.ImageStarling;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import common.graphics.Shadow;
	
	public class LayerShadow extends Sprite
	{
		public static var instance:LayerShadow;
		
		public function LayerShadow()
		{
			instance=this;
		}
		
		public function resize(w:int,h:int):void{
			this.x=w/2;
			this.y=h/2;
		}
		
		public function look(xc:int,yc:int):void{
			this.x=-xc+super.stage.stageWidth/2;
			this.y=-yc+super.stage.stageHeight/2;
		}
		
		public function clear():void{
			removeChildren();
		}
		
		public function addShadow(size:int,ringColor:int=0):ImageStarling{
			var tex:Texture=Texture.fromBitmapData(Shadow.draw(size,ringColor));
			var shadow:ImageStarling=new ImageStarling(tex);
			shadow.xOffset=shadow.width/2;
			shadow.yOffset=shadow.height/2;
			shadow.updatePos();
			this.addChild(shadow);
			
			return shadow;
		}
	}
}