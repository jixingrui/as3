package com.helix.ui
{
	import azura.common.algorithm.FastMath;
	
	import com.deadreckoned.assetmanager.AssetManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import com.helix.data.HelixItem;
	
	public class HelixThumb extends Sprite
	{
		public var item:HelixItem;
		public var player:HelixPlayer;
		
		private var xDown:int;
		private var yDown:int;
		
		public function HelixThumb(item:HelixItem,player:HelixPlayer)
		{
			this.item=item;
			this.player=player;
			var bd:BitmapData=AssetManager.getInstance().get(item.urlThumb).asset;
			var b:Bitmap=new Bitmap(bd);
			b.x=-bd.width/2;
			b.y=-bd.height/2;
			addChild(b);

			addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			addEventListener(MouseEvent.MOUSE_UP,onUp);
		}
		
		private function onDown(e:MouseEvent):void{
			xDown=stage.mouseX;
			yDown=stage.mouseY;
		}
		private function onUp(e:MouseEvent):void{
			if(FastMath.dist(xDown,yDown,stage.mouseX,stage.mouseY)>64)
				return;
			
			trace("click",item.target,this);
			player.click(item.target);
		}
		
	}
}