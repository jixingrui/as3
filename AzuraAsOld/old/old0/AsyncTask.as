package common.async
{
	public class AsyncTask extends AsyncKeeper
	{
		private var que:Que;
		internal var worker:AsyncUserA;
		
		internal var working:Boolean=false;
		internal var inQue:Boolean=false;
		
		function AsyncTask(que:Que, worker:AsyncUserA, disposeDelay:int){
			super(disposeDelay);
			this.que=que;
			this.worker=worker;
		}
		
		override internal function addUser(user:AsyncUserA):void{
			user.task=this;
			super.addUser(user);
		}
		
		internal function work():void{
			if(working||super.allDiscarded()){
				que.aWorkDone();
			}else if(box!=null){
				que.aWorkDone();
				super.checkService();
			}else{
				working=true;
				worker.process(this);
			}
		}
		
		public function submit(value:AsyncBoxI):void{
			if(value==null)
				throw new Error("AsycTask: cannot submit null");
			if(this.box!=null)
				throw new Error("AsycTask: cannot submit twice");
			
			this.box=value;
			working=false;
			que.aWorkDone();
			super.checkService();
		}
		
		override internal function dispose():void{
			if(box!=null)
				box.dispose();
			box=null;
			delete que.key_AsyncTask[worker.key];
		}
		
	}
}