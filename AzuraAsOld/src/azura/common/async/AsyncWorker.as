package azura.common.async
{
	public class AsyncWorker extends AsyncDisposer
	{
		private var que:AsyncQue;
		
		internal var isWorking:Boolean=false;
		internal var isInQue:Boolean=false;
		
		function AsyncWorker(que:AsyncQue, first:AsyncLoader, disposeDelay:int,manualCancel:Boolean){
			super(first,disposeDelay,manualCancel);
			this.que=que;
		}
		
		override internal function addUser(user:AsyncLoader):void{
			user.task=this;
			super.addUser(user);
		}
		
		internal function work():void{
			if(isReady){
				super.checkService();
				que.aWorkDone();
			}else if(isWorking||super.allCanceled()){
				que.aWorkDone();
			}else{
				isWorking=true;
				first.process();
			}
		}
		
		public function submit():void{			
			isWorking=false;
			super.ready();
			super.checkService();
			que.aWorkDone();
		}
		
		override internal function removeTask():void{
			que.removeWorker(first.key);
		}
		
	}
}