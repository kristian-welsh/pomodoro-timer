package com.timer {
	import com.Model;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class DisplayTimerModel extends Model {
		static public const SHOW:String = "Show Event";
		static public const HIDE:String = "Hide Event";
		static public const DISPLAY_UPDATE:String = "Display Update Event";
		static public const TIMER_COMPLETE:String = "Timer Complete Event";
		
		private var timer:Timer;
		private var display:String;
		
		/**
		 * Accepts a number of minutes to run, and manages a timer with a digital clock display updates.
		 * @param	numMins
		 */
		public function DisplayTimerModel(numMins:uint) {
			super();
			timer = new Timer(1000, numMins * 60);
			timer.addEventListener(TimerEvent.TIMER, updateViewDisplay);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
		}
		
		public function start():void {
			timer.start();
		}
		
		public function stop():void {
			timer.stop();
		}
		
		public function reset():void {
			timer.reset();
			updateViewDisplay();
		}
		
		public function show(e:TimerEvent = null):void {
			updateViews(SHOW);
			updateViewDisplay();
		}
		
		public function hide(e:TimerEvent = null):void {
			updateViews(HIDE);
		}
		
		public function updateViewDisplay(e:TimerEvent = null):void {
			updateViews(DISPLAY_UPDATE, getDisplayString());
		}
		
		private function timerComplete(e:TimerEvent):void {
			updateViews(TIMER_COMPLETE);
			timer.reset();
		}
		
		private function numMinsSet():uint {
			return timer.repeatCount / 60;
		}
		
		private function getDisplayString():String {
			return padNum(numWholeMinsLeft()) + ":" + padNum(numSecsLeft());
		}
		
		private function padNum(input:uint):String {
			return zeroPadding(input, 10) + input;
		}
		
		// full general case solution would take time i don't have
		private function zeroPadding(input:uint, magnitude:uint):String {
			return (input < magnitude ? "0" : "");
		}
		
		private function numWholeMinsLeft():uint {
			return Math.floor((timer.repeatCount - timer.currentCount) / 60);
		}
		
		private function numSecsLeft():uint {
			return (timer.repeatCount - timer.currentCount) % 60;
		}
	}
}