package old.azura.banshee.naga
{
	import azura.common.algorithm.mover.FramerI;
	import azura.common.algorithm.mover.PlayerOld;
	import azura.common.algorithm.mover.WalkerI;
	
	public class NagaPlayer implements FramerI,WalkerI
	{
		protected var player:PlayerOld;
		protected var _source:Naga;
		
		protected var _angle:int;
		protected var framePercent:Number;
		public function NagaPlayer()
		{
			player=new PlayerOld();
		}
		
		public function get angle():int
		{
			return _angle;
		}
		
		public function get source():Naga
		{
			return _source;
		}
		
		public function set source(value:Naga):void
		{
			//			framePercent=0;
			//			dispose();
			//			if(_source==value)
			//				return;
			if(value!=null)
				_source = value;
			//			updateTexture();
			//			if(value!=null)	
			//				player.resume();
		}
		
		public function get frameCount():int{
			if(_source==null) 
				return 0;
			else
				return _source.frameCount;
		}
		
		protected function get currentFrameIdx():int{
			return framePercent*frameCount;
		}
		
		protected function get currentRow():int{
			if(_source==null)
				return -1;
			else
				return (angle+180/_source.rowCount)%360/360*_source.rowCount;
		}
		
		public function play(cycle:Boolean=true,restart:Boolean=false):void
		{
			player.play(cycle,restart);
		}
		
		public function go():void{
			
		}
		
		public function stand():void{
			trace("NagaPlayer: stand");
		}
		
		public function jumpTo(x:int,y:int,h:int):void{
			//			player.x=x;
			//			foot.y=y-h;
			//			foot.depth=y-h;
			//			x=foot.x;
			//			y=y-h;
		}
		
		/**
		 * 
		 * @param angle [0,360)
		 * 
		 */
		public function turnTo(angle:int):int{
			//			trace("NagaPlayer: "+angle);
			
			//			var oldRow:int=currentRow;
			this._angle=Math.max(0,angle)%360;
			//			var newRow:int=currentRow;
			//			if(oldRow!=newRow)
			updateTexture();
			return currentRow;
		}
		
		public function showFrame(value:int):void{
			var oldPercent:Number=framePercent;
			framePercent=value/frameCount;
			if(!isNaN(oldPercent)&&oldPercent!=framePercent)
				updateTexture();
		}
		
		public function get currentFrame():Frame{
			return _source.getFrame(currentRow,currentFrameIdx);
		}
		
		public function updateTexture():void{
			trace("NagaPlayer.updateTexture: plz override");
		}
		public function dispose():void{
			player.pause();
			//			stand();
		}
	}
}