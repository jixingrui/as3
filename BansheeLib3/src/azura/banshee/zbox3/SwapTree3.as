package azura.banshee.zbox3
{
	import org.osflash.signals.Signal;
	
	public class SwapTree3 extends LoadingTree
	{
		//shadow has body, body does not
		public var body:SwapTree3;
		//body has shadow, shadow does not
		public var shadow:SwapTree3;
		private var _onReplace:Signal;
		
		public function SwapTree3()
		{
			super();
		}
		
		/**
		 * 
		 * register on parent
		 * 
		 */
		public function get onReplaceParent():Signal
		{
			if(_onReplace==null)
				_onReplace=new Signal(SwapTree3);
			return _onReplace;
		}
		
		public function get imShadow():Boolean{
			return body!=null;
		}		
		
		public function get imBody():Boolean{
			return body==null;
		}
		
		public function replaceBy(newGuy:SwapTree3):void{
			//============= todo: body must be before shadow ========
			if(parent_==null)
				throw new Error();
			
//			trace("replacing",this);
			
			if(shadow!=null){
				shadow.dispose();
				shadow=null;
			}
			shadow=newGuy;
			shadow.body=this;
			
			//=================== todo: check if initialize triggers anything else ==========
			if(shadow.iAmInitialized)
				shadow.replaceHappen();
		}
		
		private function replaceHappen():void{
			if(!imShadow)
				throw new Error();
			
			if(body.isDisposed){
				trace("Warning: body disposed, shadow dispose.",this);
				this.dispose();
				return;
			}
			
			//			trace("do replace",Zbox3(this).controller,this);
			body.shadow=null;
			body.dispose();
			body=null;
			
//			trace("replaced",this);
			SwapTree3(parent_).onReplaceParent.dispatch(this);
			//			onReplace.dispatch(this);
			
			//			notifyReplace();
		}
		
		//====================== override ===============
		override public function initialize():void{
			super.initialize();
			if(imShadow)
				replaceHappen();
		}
		
		override public function dispose():void{
			//======= todo: dispose body should also dispose shadow ====
			//======== dispose body from parent.clear should not dispose shadow ===
			//			if(shadow!=null){
			//				throw new Error();
			//				shadow.dispose();
			//			}
			shadow=null;
			body=null;
			super.dispose();
		}
		
		//===================== notify ====================
		//		public function notifyReplace():void{
		//			throw new Error("please override");
		//		}
	}
}