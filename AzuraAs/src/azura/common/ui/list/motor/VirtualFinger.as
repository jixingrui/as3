package azura.common.ui.list.motor
{
	import com.greensock.TweenMax;

	public class VirtualFinger
	{
		private var host:ListMotor2;
		public function VirtualFinger(host:ListMotor2)
		{
			this.host=host;
		}
		
		private var tween:TweenMax;

		private var _d:Number=0;
		public function get d():Number
		{
			return _d;
		}

		public function set d(value:Number):void
		{
			_d = value;
			host.dragMoveV(_d);
		}

		public function to(d:Number):void{
//			trace("to",d,this);
			host.dragStartV();
			_d=0;
			tween=TweenMax.to(this,0.5,{d:d,onComplete:onComplete});
		}
		
		private function onComplete():void{
//			trace("stop",this);
			host.dragEndV();
		}
		
		public function stop():void{
			tween.kill();
		}
		
	}
}