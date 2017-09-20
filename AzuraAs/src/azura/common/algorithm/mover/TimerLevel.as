package azura.common.algorithm.mover
{
	public class TimerLevel
	{
		private var fps:Number;
		private var userList:Vector.<TimerI>=new Vector.<TimerI>();		
		private var lastTime:int;
		
		public function TimerLevel(fps:Number){
			this.fps=fps;
		}
		
		internal function add(user:TimerI):void{
			var idx:int=userList.indexOf(user);
			if(idx>=0){
				trace("warning:duplicate add",this);			
				return;
			}
			
			userList.push(user);
		}
		
		internal function remove(user:TimerI):void{
			var idx:int=userList.indexOf(user);
			if(idx<0)
				throw new Error();
			
			userList.splice(idx,1);
		}
		
		internal function tick(time:int):void{
			var tickTime:int=lastTime+1000/fps;
			if(time>tickTime){
				lastTime=time;
				
				for each(var user:TimerI in userList){
					user.tick();
				}
			}
		}
	}
}