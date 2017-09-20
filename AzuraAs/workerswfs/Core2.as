package azura.banshee.multithread
{
	import azura.avalon.fi.base.PyramidBase;
	
	import common.algorithm.pathfinding.Floyd;
	import common.algorithm.pathfinding.astar.AStarEidiot;
	import common.collections.ZintBuffer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	import flash.utils.setInterval;
	
	public class Core2 extends Sprite implements CoreI
	{
		
		protected var worker:Worker;
		protected var mainToWorker:MessageChannel;
		protected var workerToMain:MessageChannel;
		
		private var _pathReady:Function;
		
		public function set pathReady(value:Function):void
		{
			_pathReady = value;
		}
		
		public function Core2()
		{
			worker = WorkerDomain.current.createWorker(Workers.azura_banshee_multithread_Core2Worker);
			
			mainToWorker = Worker.current.createMessageChannel(worker);
			workerToMain = worker.createMessageChannel(Worker.current);
			
			worker.setSharedProperty("mainToWorker", mainToWorker);
			worker.setSharedProperty("workerToMain", workerToMain);
			
			workerToMain.addEventListener(Event.CHANNEL_MESSAGE, onWorkerToMain);
			
			worker.start();
		}
		
		protected function onWorkerToMain(event:Event):void {
//			trace("path found");
			var data:ByteArray = workerToMain.receive();
			var zb:ZintBuffer=new ZintBuffer(data);
			var header:String=zb.readUTF();
			if(header == "path"){
				var path:Vector.<Point>=new Vector.<Point>();
				var length:int=zb.readZint();
				for(var i:int=0;i<length;i++){
					var p:Point=new Point(zb.readZint(),zb.readZint());
					path.push(p);
				}
				_pathReady.call(null,path);
			}
		}
		
		public function setBase(data:ZintBuffer):void
		{
			var msg:ZintBuffer=new ZintBuffer();
			msg.writeUTF("base");
			msg.writeBytes_(data);
			mainToWorker.send(msg);
		}
		
		public function find(startX:int, startY:int, endX:int, endY:int):void{
			var msg:ZintBuffer=new ZintBuffer();
			msg.writeUTF("find");
			msg.writeZint(startX);
			msg.writeZint(startY);
			msg.writeZint(endX);
			msg.writeZint(endY);
			mainToWorker.send(msg);
		}
	}
}