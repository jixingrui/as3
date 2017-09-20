package com.helix.ui
{
	import azura.common.algorithm.FastMath;
	
	import com.deadreckoned.assetmanager.AssetManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class HelixTitle extends Sprite
	{
		public var player:HelixPlayer;
		
		private var xDown:int;
		private var yDown:int;
		
		public function HelixTitle(player:HelixPlayer)
		{
			this.player=player;
			
			addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			addEventListener(MouseEvent.MOUSE_UP,onUp);
		}
		
		public function show(urlTitle:String):void{
			var bd:BitmapData=AssetManager.getInstance().get(urlTitle).asset;
			var b:Bitmap=new Bitmap(bd);
			b.x=-bd.width/2;
			b.y=bd.height/2;
			addChild(b);
		}
		
		private function onDown(e:MouseEvent):void{
			xDown=stage.mouseX;
			yDown=stage.mouseY;
		}
		private function onUp(e:MouseEvent):void{
			if(FastMath.dist(xDown,yDown,stage.mouseX,stage.mouseY)>64)
				return;
			player.clickTitle();
		}
		
		public function clear():void{
			removeChildAt(0);
		}
	}
}