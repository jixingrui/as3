package zexia.common.pano
{
	import azura.banshee.engine.Statics;
	
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.mouserOld.MouserDragI;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.RemoveTintPlugin;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class MouseMove implements MouserDragI
	{
		private var host:LayerZpanoPure;
		
		private var tx:TweenMax;
		private var ty:TweenMax;
		private var te:uint;
		
		public function MouseMove(host:LayerZpanoPure)
		{
			this.host=host;
			
			Statics.stage.addEventListener(MouseEvent.MOUSE_WHEEL,onRoll);
		}
		
		private function onRoll(me:MouseEvent):void{
			host.fov-=me.delta/3;
		}
		
		public function onDragStart(md:MouserDrag):void
		{
			if(tx!=null)
				tx.kill();
			if(ty!=null)
				ty.kill();
			
			host.dragging = true;

			host.mouseX=md.position.x;
			host.mouseY=md.position.y;
			host.downMouseX = md.position.x;
			host.downMouseY = md.position.y;
			
			host.downPanAngle = host.al.camera.panAngle;
			host.downTiltAngle = host.al.camera.tiltAngle;
		}
		
		public function onDragMove(md:MouserDrag):void
		{
			dragMove(md.position.x,md.position.y);
		}
		
		public function dragMove(x:int,y:int):void{
			host.dragging=true;
			
			if(tx!=null)
				tx.kill();
			if(ty!=null)
				ty.kill();
			
			tx=TweenMax.to(host,1,{mouseX:x});
			ty=TweenMax.to(host,1,{mouseY:y});
		}
		
		public function onDragEnd(md:MouserDrag):void
		{
			clearTimeout(te);
			te=setTimeout(stop,1000);
		}
		
		private function stop():void{
			host.dragging=false;
		}
	}
}