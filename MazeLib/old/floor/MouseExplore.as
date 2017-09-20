package floor
{
	import a.Statics;
	
	import azura.banshee.engine.mouse.MouseDUMI;
	import azura.banshee.zebra.node.Bounder;
	import azura.common.ui.mouse.WatcherDrag;
	import azura.common.ui.mouse.WatcherEvent;
	import azura.common.ui.mouse.WatcherZoom;
	
	import flash.geom.Point;
	import flash.system.System;
	
	public class MouseExplore
	{
		private var host:LayerStationFloors;
		private var downRoot:Point;
		
		private var bounder:Bounder;
		
		private var wd:WatcherDrag;
		private var wz:WatcherZoom;
		
		public var imgWidth:int;
		public var imgHeight:int;
		
		public function MouseExplore(host:LayerStationFloors)
		{
			this.host=host;
			
			wd=new WatcherDrag(Statics.stage);
			wd.addEventListener(WatcherEvent.DRAG_START,onDragStart);
			wd.addEventListener(WatcherEvent.DRAG_MOVE,onDragMove);
			wd.addEventListener(WatcherEvent.DRAG_END,onDragEnd);
			
			wz=new WatcherZoom(Statics.stage);
			wz.addEventListener(WatcherEvent.ZOOM,onZoom);
			
		}
		
		public function onDragStart(we:WatcherEvent):void{
			
			var hit:Boolean=host.root.click(we.position.x,we.position.y);
			if(hit)
				return;
			
			downRoot=new Point(host.root.xRoot,host.root.yRoot);
			
			bounder=new Bounder(Statics.stage.stageWidth/host.root.scaleLocal,Statics.stage.stageHeight/host.root.scaleLocal,imgWidth,imgHeight);
		}
		public function onDragMove(we:WatcherEvent):void{
			if(downRoot==null)
				return;
			
			var dx:Number=-we.delta.x/host.root.scaleLocal;
			var dy:Number=-we.delta.y/host.root.scaleLocal;			
			
			if(bounder==null){
				bounder=new Bounder(Statics.stage.stageWidth/host.root.scaleLocal,Statics.stage.stageHeight/host.root.scaleLocal,imgWidth,imgHeight);	
			}
			bounder.bound(downRoot.x+dx,downRoot.y+dy);
			
			host.root.lookAt(bounder.x,bounder.y);
		}
		public function onDragEnd(we:WatcherEvent):void{
		}
		public function onZoom(we:WatcherEvent):void{
			host.zoom(we.scaleX,we.scaleY);
		}
		public function dispose():void{
			wd.removeEventListener(WatcherEvent.DRAG_START,onDragStart);
			wd.removeEventListener(WatcherEvent.DRAG_MOVE,onDragMove);
			wd.removeEventListener(WatcherEvent.DRAG_END,onDragEnd);
			wz.removeEventListener(WatcherEvent.ZOOM,onZoom);
			wd.dispose();
			wz.dispose();
			wd=null;
			wz=null;
			host=null;
		}
		
	}
}