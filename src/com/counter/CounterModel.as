package com.counter {
	import com.Model;
	
	public class CounterModel extends Model {
		public static const COUNTER_UPDATE:String = "Counter Update Event";
		
		private var counter:int = 0;
		
		public function increment():void {
			++counter;
			updateViews(COUNTER_UPDATE, counter);
		}
	}
}