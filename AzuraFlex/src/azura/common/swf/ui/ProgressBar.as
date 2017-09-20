// Not copyrighted.  Use it however you want.
package azura.common.swf.ui
{
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	
	import spark.components.supportClasses.Range;
	
	/**
	 * A spark-based progress bar component.
	 */
	public class ProgressBar extends Range
	{
		public function ProgressBar()
		{
			super();
			snapInterval = 0;
			minimum = 0;
			maximum = 1;
		}
		
//		private var _maximum:Number;
		
		private var _eventSource:IEventDispatcher;
		
		[Bindable]
		override public function get maximum():Number
		{
			return super.maximum;
		}

		override public function set maximum(value:Number):void
		{
			super.maximum=value;
//			_maximum = value;
		}

		/**
		 * An optional IEventDispatcher dispatching progress events.  The progress events will
		 * be used to update the <code>value</code> and <code>maximum</code> properties.
		 */
		public function get eventSource():IEventDispatcher
		{
			return _eventSource;
		}
		
		/**
		 * @private
		 */
		public function set eventSource(value:IEventDispatcher):void
		{
			if (_eventSource != value)
			{
				removeEventSourceListeners();
				_eventSource = value;
				addEventSourceListeners();
			}
		}
		
		/**
		 * @private
		 * Removes listeners from the event source.
		 */
		protected function removeEventSourceListeners():void
		{
			if (eventSource)
			{
				eventSource.removeEventListener(ProgressEvent.PROGRESS, eventSource_progressHandler);
			}
		}
		
		/**
		 * @private
		 * Adds listeners to the event source.
		 */
		protected function addEventSourceListeners():void
		{
			if (eventSource)
			{
				eventSource.addEventListener(ProgressEvent.PROGRESS, eventSource_progressHandler, 
					false, 0, true);
			}
		}
		
		/**
		 * @private
		 * Updates the <code>value</code> and <code>maximum</code> properties when progress
		 * events are dispatched from the <code>eventSource</code>.
		 */
		protected function eventSource_progressHandler(event:ProgressEvent):void
		{
			value = event.bytesLoaded;
			maximum = event.bytesTotal;
		}
	}
}