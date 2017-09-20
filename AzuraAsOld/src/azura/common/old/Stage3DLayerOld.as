package azura.common.old
{
	import flash.display.Stage;
	import flash.display.Stage3D;
	
	public class Stage3DLayerOld 
	{
		public var active:Boolean=true;
		public var stage:Stage;
		public var stage3D:Stage3D;
			
		public final function boot(stage:Stage, stage3D:Stage3D):void
		{
			this.stage=stage;
			this.stage3D=stage3D;
			initialize();
		}
		
		protected function initialize():void{
			throw new Error("Stage3DLayer: please overrride");
		}
				
		public function reboot():void{
		}
		
		public function update():void
		{
			throw new Error("Stage3DLayer: please overrride");
		}
	}
}