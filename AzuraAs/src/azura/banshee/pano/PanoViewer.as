package azura.banshee.pano
{
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.controllers.FirstPersonController;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	
	import azura.banshee.engine.starling_away.AwayLayer;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4;
	
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;
	
	public class PanoViewer
	{
		public var al:AwayLayer;
		
		//bg		
		private var cubeTexture:BitmapCubeTexture;
		private var _skyBox:SkyBox; 
		private var mc53:Vector.<String>;
		private var img6:Vector.<BitmapData>;
		private var currentSize:int;
		
		//navigation
		internal var downPanAngle:Number=0;
		internal var downTiltAngle:Number=0;
		internal var downMouseX:Number=0;
		internal var downMouseY:Number=0;
		public var mouseX:Number=0;
		public var mouseY:Number=0;
		
		public var tiltSpeed:Number=0.5;
		
		private var _fov:Number=80;
		
		private var controller:FirstPersonController;
		
		private var acc:Accelerometer;
		
		public function PanoViewer(al:AwayLayer){
			this.al=al;
			al.view.camera.lens = new PerspectiveLens (_fov);  
			al.view.camera.lens.far = 14000;
			al.view.camera.lens.near = 1;
			al.view.camera.x=0;
			al.view.camera.y=0;
			al.view.camera.z=0;
			
			controller = new FirstPersonController(al.view.camera, 0, 0, -90, 90);
			controller.steps=0;
			
		}
		
		public function get fov():Number
		{
			return _fov;
		}
		
		public function set fov(value:Number):void
		{
			_fov = value;
			_fov=Math.max(_fov,50);
			_fov=Math.min(_fov,100);
			PerspectiveLens(al.view.camera.lens).fieldOfView=_fov;
		}
		
		public function load(data:ZintBuffer):void{
			
			clearSky();
			
			currentSize=0;
			img6=new Vector.<BitmapData>(6);
			mc53=new Vector.<String>();
			
			for(var j:int=0;j<3;j++){
				mc53.push(data.readUTFZ());
			}
			
			stepLoading();
		}
		
		private function stepLoading():void{
			
			img6=new Vector.<BitmapData>(6);
			Gal4.readAsync(mc53[currentSize],fileLoaded);
			
			function fileLoaded(item:Gal4):void{
				for(var i:int=0;i<6;i++){
					new ZpanoLoader(mc53[currentSize],i,item.data.readBytesZ()).load(onBitmapReady);
				}						
			}
			
			function onBitmapReady(ll:ZpanoLoader):void{
				img6[ll.direction]=ll.value as BitmapData;
				check6();
			}
		}
		
		private function check6():void{
			var all:Boolean=true;
			for(var i:int=0;i<6;i++){
				if(img6[i]==null)
					all=false;
			}
			
			if(all){
				clearSky();
				
				cubeTexture=new BitmapCubeTexture(img6[0],img6[1],img6[2],img6[3],img6[4],img6[5]);
				_skyBox = new SkyBox(cubeTexture);
				_skyBox.showBounds=false;
				
				al.view.scene.addChild(_skyBox);
				
				if(currentSize<2){
					currentSize++;
					stepLoading();
				}
			}
		}
		
		private function clearSky():void{
//			dragging=false;
			if(_skyBox!=null){
				al.view.scene.removeChild(_skyBox);
				_skyBox.dispose();
				_skyBox=null;
				cubeTexture.dispose();
			}
		}
		
		public function dispose():void{
			if(acc!=null)
				acc.removeEventListener(AccelerometerEvent.UPDATE,onAcc);
			clearSky();
		}
		
		//============================= control ==================
		
		//=================== acc ================
		public function get isAccSupported():Boolean{
			return Accelerometer.isSupported;
		}
		
		public function enableAcc():void{
			if(isAccSupported){
				acc=new Accelerometer();
				acc.addEventListener(AccelerometerEvent.UPDATE,onAcc);
			}
		}
		public function disableAcc():void{
			if(acc!=null){
				acc.removeEventListener(AccelerometerEvent.UPDATE,onAcc);
			}
		}
				
		private var tiltTween_:TweenMax;
		private function killTween():void{
			if(tiltTween_!=null){
				tiltTween_.kill();
				tiltTween_=null;
			}
		}

		private function onAcc(event:AccelerometerEvent):void{
			
			var tiltR:Number=Math.atan2(event.accelerationZ,event.accelerationY);
			var tiltA:Number=FastMath.radian2angle(tiltR);
			
			killTween();
			tiltTween_=TweenMax.to(controller,1,
				{tiltAngle:tiltA, panAngle:(controller.panAngle-event.accelerationX*40)});
		}
		
		//drag
		public function dragStart():Boolean
		{
			downPanAngle = controller.panAngle;
			downTiltAngle = controller.tiltAngle;
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			mouseX=x;
			mouseY=y;
			controller.panAngle = (-0.2 * (dx) + downPanAngle);
			controller.tiltAngle = (-0.2 * (dy) * tiltSpeed + downTiltAngle);
			return false;
		}
		
		public function dragEnd():Boolean
		{
			return false;
		}
	}
}