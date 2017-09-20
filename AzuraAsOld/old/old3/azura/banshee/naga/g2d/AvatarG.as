package old.azura.banshee.naga.g2d
{
	import old.azura.avalon.ice.GenomeIceOld;
	import old.azura.banshee.naga.AvatarI;
	import old.azura.banshee.naga.Naga;
	import old.azura.banshee.naga.NagaPlayer;
	import azura.common.algorithm.FastMath;
	import azura.common.graphics.Shadow;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	public class AvatarG implements AvatarI
	{
		private static var size_Texture:Dictionary=new Dictionary();
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
			if(nameG!=null)
			{
				container.removeChild(nameG.node);
				nameG.dispose();
				nameG.texture.dispose();
			}
			var nameBd:BitmapData=drawString(name);
			var pid:String="AvatarG"+FastMath.random(0,int.MAX_VALUE);
			var tex:GTexture=GTextureFactory.createFromBitmapData(pid,nameBd);
			nameG=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			nameG.texture=tex;
			container.addChild(nameG.node);
		}
		
		private static function getShadowTexture(size:int):GTexture{
			var tex:GTexture;
			tex=size_Texture[size];
			if(tex!=null)
				return tex;
			tex=GTextureFactory.createFromBitmapData("shadow_"+size, Shadow.draw(size,0));
			size_Texture[size]=tex;
			return tex;
		}
		
		private var container:GNode;
		private var nameG:GSprite;
		private var body:NagaPlayerG;
		private var shadow:GSprite;
		private var shadowNow:int,shadowAverage:int=-1;
		
		private var _name:String;
		
		public function AvatarG()
		{
			body=new NagaPlayerG();
			//			body.ed.addEventListener(Event.FRAME_CONSTRUCTED,onFrameReady);
			body.onFrameReady.add(onFrameReady);
			
			container=GNodeFactory.createNode();
			GenomeIceOld.instance.layerAssG.node.addChild(container);
			
			container.addChild(body.image.sprite.node);
			
			name="";
		}
		
		private function drawString(text:String,color:int=0xff0000ff):BitmapData {
			
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.text = text;
			tf.textColor = color;
			tf.autoSize=TextFormatAlign.LEFT;
			tf.antiAliasType=AntiAliasType.ADVANCED;
			
			var format:TextFormat = new TextFormat();
			format.size=Number(28);
			format.bold=true;
			tf.setTextFormat(format);
			
			var outline:GlowFilter=new GlowFilter(0xffffff,0.5,2.0,2.0,4);
			outline.quality=BitmapFilterQuality.MEDIUM;
			tf.filters=[outline];
			
			tf.cacheAsBitmap = true;
			
			var result:BitmapData=new BitmapData(tf.width,tf.height,true,0x0);
			result.draw(tf);	
			
			return result;
		}
		
		private function onFrameReady():void{
			if(nameG!=null)
				nameG.node.transform.y=-body.currentFrame.yCenter-20;
			
			setShadow();
			//			shadow.node.transform.x=body.image.currentFrame.xCenter;
			//			shadow.node.transform.y=body.image.currentFrame.yCenter;
		}
		
		private function setShadow():void{
			
			var size:int=60;
			
			//			size=Math.max(8,size);
			if(size==shadowNow)
			{
				return;
			}
			
			shadowNow=size;
			
			if(shadow!=null){
				container.removeChild(shadow.node);
			}
			
			var tex:GTexture=getShadowTexture(size);
			
			shadow=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			shadow.texture=tex;
			
			container.removeChild(body.image.sprite.node);
			container.addChild(shadow.node);
			container.addChild(body.image.sprite.node);
			if(nameG!=null){
				container.removeChild(nameG.node);
				container.addChild(nameG.node);
			}
		}
		
		public function turnTo(angle:int):int
		{
			return body.turnTo(angle);
		}
		
		public function set source(value:Naga):void
		{
			//			body.clear();
			if(body==null)
				return;
			
			body.source=value;
			body.updateTexture();
			
			
			//			boundShadow();
		}
		
		//		private function boundShadow():void{
		//			var shadowMin:int=int.MAX_VALUE;
		//			var shadowMax:int=0;
		//			for(var row:int=0;row<body.source.rowCount;row++)
		//				for(var j:int=0;j<body.source.frameCount;j++){
		//					var f:Frame=body.source.getFrame(row,j);
		//					shadowMin=Math.min(shadowMin,f.shadowWidth);
		//					shadowMax=Math.max(shadowMax,f.shadowWidth+1);
		//				}
		//			shadowAverage=(shadowMin+shadowMax)/2;
		//		}
		
		public function set scale(value:Number):void
		{
			//			body.image.scale=value;
			container.transform.scaleX=value;
			container.transform.scaleY=value;
		}
		
		public function set x(value:Number):void
		{
			//			body.image.xFoot=value;
			container.transform.x=value;
		}
		
		public function set y(value:Number):void
		{
			//			body.image.yFoot=value;
			//			body.image.depthFoot=value;
			container.transform.y=value;
			//			container.userData.set("depth",value);
//			container.userData.depth=value;
		}
		
		public function set health(value:Number):void
		{
		}
		
		public function sayText(value:String):void
		{
		}
		
		public function set onTurn(value:Function):void
		{
		}
		
		public function set onSelect(value:Function):void
		{
		}
		
		public function get player():NagaPlayer{
			return body;
		}
		
		public function clear():void{
			
			container.removeChild(body.image.sprite.node);
			body.dispose();
			body=null;
			
			if(shadow!=null){
				container.removeChild(shadow.node);
				shadow.dispose();
				shadow=null;
			}
			
			container.removeChild(nameG.node);
			nameG.dispose();
			nameG.texture.dispose();
			nameG=null;
			
			trace("avatar disposed");
		}
	}
}