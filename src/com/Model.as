package com {
	import com.events.GeneralEvent;
	import flash.events.EventDispatcher;
	
	public class Model extends EventDispatcher {
		
		public function Model() {
			
		}
		
		protected function updateViews(eventCode:String, data:Object = null):void {
			data = data || { };
			dispatchEvent(new GeneralEvent(eventCode, data));
		}
	}
}