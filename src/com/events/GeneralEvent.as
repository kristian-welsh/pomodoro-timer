package com.events {
	import flash.events.Event;
	
	public class GeneralEvent extends Event {
		public var data:Object;
		
		public function GeneralEvent(eventCode:String, data:Object) {
			super(eventCode);
			this.data = data;
		}
	}
}