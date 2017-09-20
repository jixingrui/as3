package azura.junior.service
{
	import azura.karma.hard11.HardReaderI;
	import azura.karma.run.Karma;
	
	import mx.binding.utils.BindingUtils;
	
	import zz.karma.JuniorEdit.K_Concept;
	
	
	[Bindable]
	public class ConceptReader extends K_Concept implements HardReaderI
	{
		
		public function ConceptReader(){
			super(JuniorC_SC.ksJunior);
		}
		
		public function init():void
		{
			ioType=IoType.internal_;
//			flashy=true;
			counterTrigger=1;
			note="";
		}
				
	}
}