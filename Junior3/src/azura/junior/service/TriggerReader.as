package azura.junior.service
{
	import azura.karma.hard11.HardReaderI;
	import azura.karma.run.Karma;
	
	import mx.binding.utils.BindingUtils;
	
	import zz.karma.JuniorEdit.K_Trigger;
	
	[Bindable]
	public class TriggerReader extends K_Trigger implements HardReaderI
	{
		public var on_:Number;
		public var off_:Number;
		
		public function TriggerReader(){
			super(JuniorC_SC.ksJunior);
//			BindingUtils.bindProperty(this,"on",this,"on_");
//			BindingUtils.bindProperty(this,"off",this,"off_");
		}
		
		override public function fromKarma(karma:Karma):void{
			super.fromKarma(karma);
			on_=on;
			off_=off;
		}
		
		public function init():void
		{
			on=1;
			off=0;
		}
		
	}
}