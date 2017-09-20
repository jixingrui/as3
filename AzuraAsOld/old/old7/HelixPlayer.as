package com.helix.ui
{
	import azura.banshee.engine.mouse.MouseDUMI;
	import azura.banshee.engine.mouse.MouseMon;
	import azura.common.algorithm.FastMath;
	
	import com.deadreckoned.assetmanager.Asset;
	import com.deadreckoned.assetmanager.AssetManager;
	import com.greensock.TweenLite;
	import com.helix.data.Gallery;
	import com.helix.data.Helix;
	import com.helix.data.HelixItem;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	import mx.events.ItemClickEvent;
	
	import org.osflash.signals.Signal;
	
	public class HelixPlayer extends Sprite implements MouseDUMI
	{
		public static var onSelect:Signal=new Signal(String);
		
		public static 	var r:int;
		public static var vGap:int=480/12;
		
		private var gallery:Gallery;
		private var current:Helix;
		
		private var helixSp:Sprite=new Sprite();
		private var rad:Number;
		private var array:Array=new Array();
		
		private var downMouseX:int;
		private var downMouseY:int;
//		private var isDown:Boolean;
		private var downAngle:int;
		private var downY:int;
		
		private var _rotYLastSort:Number=99999;
		private var _rotY:Number=0;
		
		private var title:HelixTitle;
		
		public function play(gallery:Gallery):void{
			this.gallery=gallery;
			this.addChild(helixSp);
			title=new HelixTitle(this);
			this.addChild(title);
			
//			title.x=stage.stageWidth/2;			
			title.y=-stage.stageHeight/2;
			r=stage.stageWidth;
			
			current=gallery.id_Helix[gallery.entrance];
			
			show();
		}
		
		public function set mouseActive(value:Boolean):void{
			if(value){
				MouseMon.register(this);
			}else{
				MouseMon.unregister(this);
			}
		}
		
		public function clickTitle():void{
			if(current.back!=null){
				TweenLite.to(helixSp,1,{z:10000,onComplete:onRemove});
				current=current.back;
			}
		}
		
		public function get rotY():Number
		{
			return _rotY;
		}
		
		public function set rotY(value:Number):void
		{
			_rotY = value;
			helixSp.rotationY=value;
			if(Math.abs(value-_rotYLastSort)>60){
				sortDepth();
				_rotYLastSort=value;
			}
		}
		
		private function show():void{
			
			title.show(current.urlTitle);
			
//			helixSp.x=stage.stageWidth/2;
//			helixSp.y=-stage.stageHeight/2;
//			helixSp.z=r;
			
			trace(stage.stageWidth,stage.stageHeight);
			
//			helixSp.x*=2;
//			helixSp.y*=2;
			
			rotY=0;
			downAngle=0;
			downY=0;
			
			var i:int;
			var angle:int;
			for(i=0;i<current.itemList.length;i++){
				var item:HelixItem=current.itemList[i];
				angle=30*i%360;
				rad = FastMath.toRadians(angle);
				
				var thumb:HelixThumb=new HelixThumb(item,this);
				array.push(thumb);
				thumb.x = -Math.sin(-rad) * r;
				thumb.z = -Math.cos(rad) * r;
//				thumb.scaleX=Math.cos(rad) * r;
//				thumb.scaleY=Math.cos(rad) * r;
				thumb.y = -i*vGap;
				thumb.rotationY=FastMath.toDegrees(-rad);
				helixSp.addChild(thumb);
			}
			sortDepth();
			
			TweenLite.to(helixSp,1,{z:r+0});
		}
		
		public function click(target:String):void{
			if(!current.isLeaf){
				TweenLite.to(helixSp,1,{z:10000,onComplete:onRemove});
				current=gallery.id_Helix[target];
			}else{
				onSelect.dispatch(target);
			}
		}
		
		private function onRemove():void{
			while(array.length>0){
				var thumb:HelixThumb=array.pop();
				helixSp.removeChild(thumb);
			}
			title.clear();
			TweenLite.killTweensOf(this);
			TweenLite.killTweensOf(helixSp);
			show();
		}
		
		public function mouseDown(x:int, y:int):Boolean
		{
			downMouseX=stage.mouseX;
			downMouseY=stage.mouseY;
			downAngle=helixSp.rotationY;
			downY=helixSp.y;
			return true;
		}
		
		public function mouseMove(x:int, y:int):void
		{
			var dx:int=stage.mouseX-downMouseX;
			var deltaAngle:Number=dx*0.2;
			var deltaY:Number=-deltaAngle/360*12*vGap;
			
			TweenLite.to(this, 2, {rotY:downAngle-deltaAngle});
			TweenLite.to(helixSp, 2, {y:downY+deltaY});
			
//			helixSp.z+=dx;
//			title.x+=dx*0.2;
		}
		
		public function mouseUp(x:int, y:int):void
		{
			if(stage.mouseY-downMouseY>240){
				TweenLite.killTweensOf(this);
				TweenLite.killTweensOf(helixSp);
				TweenLite.to(helixSp, .5, {y:helixSp.y+12*vGap});
			}else if(downMouseY-stage.mouseY>240){
				TweenLite.killTweensOf(this);
				TweenLite.killTweensOf(helixSp);
				TweenLite.to(helixSp, .5, {y:helixSp.y-12*vGap});
			}
		}
		
		public function get priority():int
		{
			return 0;
		}
		
		private function sortDepth():void {
			array.sort(sortOnZ)
			for (var i:int = 0; i < array.length; i++ ) {
				helixSp.setChildIndex(array[i],i)
			}
		}
		
		private function sortOnZ(objA:DisplayObject,objB:DisplayObject):int {
			var posA:Vector3D = objA.transform.matrix3D.position;
			posA = helixSp.transform.matrix3D.deltaTransformVector(posA);
			var posB:Vector3D = objB.transform.matrix3D.position;
			posB = helixSp.transform.matrix3D.deltaTransformVector(posB);
			return posB.z-posA.z;
		}
	}
}