package azura.banshee.multithread
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	import azura.avalon.fi.base.PyramidBase;
	
	import common.algorithm.pathfinding.Floyd;
	import common.algorithm.pathfinding.astar.AStarEidiot;
	import common.collections.ZintBuffer;
	
	public class Core2Worker extends Sprite
	{
		protected var mainToWorker:MessageChannel;
		protected var workerToMain:MessageChannel;
		
		private var _base:PyramidBase;
		private var astar:AStarEidiot;
		private var floyd:Floyd;
		
		public function Core2Worker()
		{
			stage.frameRate=60;
			mainToWorker = Worker.current.getSharedProperty("mainToWorker");
			workerToMain = Worker.current.getSharedProperty("workerToMain");
			mainToWorker.addEventListener(Event.CHANNEL_MESSAGE, onMainToWorker);
		}
		
		protected function onMainToWorker(event:Event):void {
			var data:ByteArray = mainToWorker.receive();
			var zb:ZintBuffer=new ZintBuffer(data);
			var header:String=zb.readUTF();
			if(header == "base"){
				_base = new PyramidBase(zb.readBytes_());				
				astar=new AStarEidiot(_base,8000);
				floyd=new Floyd(_base);
			}
			else if(header == "find"){
				var startX:int=zb.readZint();
				var startY:int=zb.readZint();
				var endX:int=zb.readZint();
				var endY:int=zb.readZint();
				
				var raw:Vector.<Point>=astar.find(startX,startY,endX,endY);
				if(raw==null)
					return ;
				
				var fpath:Vector.<Point>=floyd.process(raw);
				if(fpath.length<2)
					return ;
				
				var ret:ZintBuffer=new ZintBuffer();
				ret.writeUTF("path");
				ret.writeZint(fpath.length);
				for each(var p:Point in fpath){
					ret.writeZint(p.x);
					ret.writeZint(p.y);
				}
				workerToMain.send(ret);
			}
		}
	}
}