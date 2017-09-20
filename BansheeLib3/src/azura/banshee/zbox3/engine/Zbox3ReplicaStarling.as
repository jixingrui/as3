package azura.banshee.zbox3.engine
{
	import azura.banshee.engine.TextureResI;
	import azura.banshee.zbox3.container.Zbox3ReplicaI;
	import azura.common.algorithm.FastMath;
	//	import azura.common.ui.alert.Toast;
	
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class Zbox3ReplicaStarling implements Zbox3ReplicaI
	{
		private var container:Sprite=new Sprite();
		private var displayer:Image;
		private var _smoothing:Boolean;
		
		public function Zbox3ReplicaStarling(upLink:Sprite){
			upLink.addChild(container);
		}
		
		public function get smoothing():Boolean
		{
			return _smoothing;
		}
		
		public function set smoothing(value:Boolean):void
		{
			_smoothing = value;
			updateSmoothing();
		}
		
		private function updateSmoothing():void{
			if(displayer==null)
				return;
			//			displayer.textureSmoothing=TextureSmoothing
			if(_smoothing)
				displayer.textureSmoothing=TextureSmoothing.BILINEAR;
			else{
				displayer.pixelSnapping=true;
				displayer.textureSmoothing=TextureSmoothing.NONE;
			}
		}
		
		public function get starlingSprite():Sprite{
			return container;
		}
		
		public function replicate():Zbox3ReplicaI
		{
			return new Zbox3ReplicaStarling(this.container);
		}
		
		public function removeChild(child:Zbox3ReplicaI):void
		{
			var c:Zbox3ReplicaStarling=child as Zbox3ReplicaStarling;
			container.removeChild(c.container);
		}
		
		public function swapChildren(idx1:int, idx2:int):void
		{
			container.swapChildrenAt(idx1,idx2);
		}
		
		public function set visible(value:Boolean):void
		{
			container.visible=value;
		}
		
		public function get visible():Boolean
		{
			return container.visible;
		}
		
		public function set alpha(value:Number):void
		{
			container.alpha=value;
		}
		
		public function get alpha():Number{
			return container.alpha;
		}
		
		public function set scaleX(value:Number):void
		{
			container.scaleX=value;
			x=x_;
		}
		
		public function set scaleY(value:Number):void
		{
			container.scaleY=value;
			y=y_;
		}
		
		public function set rotation(angle:Number):void
		{
			var rad:Number=FastMath.angle2radian(angle);
			container.rotation=rad;
		}
		
		private var x_:Number=0;
		private var y_:Number=0;
		public function set x(value:Number):void
		{
			x_=value;
			container.x=x_*container.scaleX;
		}
		
		public function set y(value:Number):void
		{
			y_=value;
			container.y=y_*container.scaleY;
		}
		
		public function set width(value:Number):void
		{
			container.width=value;
		}
		
		public function set height(value:Number):void
		{
			container.height=value;
		}
		
		public function set clipRect(rect:Rectangle):void
		{
			//			container.clipRect=rect;
			var quad:Quad=new Quad(rect.width,rect.height);
			quad.x=rect.x;
			quad.y=rect.y;
			container.mask=quad;
		}
		//===================== display =====================
		public function display(res:TextureResI):void{
			//			trace("display",this);
			//happens when walking out of ground image
			if(res.texture==null){
				trace("warning: no texture here",this);
				return;
			}
			
			if(res.width==0||res.height==0){
				trace("Error: resource has invalid size: "+res.width+" "+res.height,this);
				return;
			}
			
			if(displayer!=null){
				displayer.dispose();
				container.removeChild(displayer);
				displayer=null;
			}
			displayer=new Image(res.texture as Texture);
			updateSmoothing();
			
			if(res.center_LT==true){
				displayer.x=Math.round(-res.pivotX-res.width/2);
				displayer.y=Math.round(-res.pivotY-res.height/2);
			}else{
				displayer.x=-res.pivotX;
				displayer.y=-res.pivotY;
			}
			//warning: displayer.scaleX and displayer.width may interfere
			displayer.scaleX=scaleXImage_;
			displayer.scaleY=scaleYImage_;
			
			container.addChild(displayer);
			var idx:int=container.getChildIndex(displayer);
			if(idx>0){
				for(var i:int=idx;i>0;i--){
					swapChildren(i,i-1);
				}
			}
		}		
		
		public function unDisplay():void
		{
			if(displayer!=null){
				container.removeChild(displayer);				
				displayer.dispose();
				displayer=null;
			}
		}
		
		private var scaleXImage_:Number=1;
		private var scaleYImage_:Number=1;
		public function set scaleXImage(value:Number):void
		{
			scaleXImage_=value;
			if(displayer!=null)
				displayer.scaleX=value;
		}
		public function get scaleXImage():Number{
			return scaleXImage_;
		}
		
		public function set scaleYImage(value:Number):void
		{
			scaleYImage_=value;
			if(displayer!=null)
				displayer.scaleY=value;
		}
		
	}
}