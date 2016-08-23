package com{
	import com.button.ButtonView;
	import com.events.GeneralEvent;
	import com.timer.DisplayTimerModel;
	import com.timer.DisplayTimerView;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	public class Main extends Sprite {
		private var pomodoroModel:DisplayTimerModel;
		private var breakModel:DisplayTimerModel;
		private var currentTimer:DisplayTimerModel;
		
		private var pomodoroView:DisplayTimerView;
		private var breakView:DisplayTimerView;
		
		private var startButtonView:ButtonView;
		private var stopButtonView:ButtonView;
		private var resetButtonView:ButtonView;
		private var pomodoroButtonView:ButtonView;
		private var breakButtonView:ButtonView;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initModels();
			initViews(stage);
			initControllers();
		}
		
		private function initModels():void {
			pomodoroModel = new DisplayTimerModel(25);
			breakModel = new DisplayTimerModel(5);
		}
		
		private function initViews(container:DisplayObjectContainer):void {
			pomodoroView = new DisplayTimerView(container, 370, 110, 50); // 370 is magic, need alignemnt
			breakView = new DisplayTimerView(container, 370, 110, 50);
			
			pomodoroButtonView = new ButtonView(container, 300, 50, "pomodoro", Colours.DARK_BLUE, Colours.LIGHT_BLUE);
			breakButtonView = new ButtonView(container, 500, 50, "break", Colours.DARK_BLUE, Colours.LIGHT_BLUE);
			startButtonView = new ButtonView(container, 300, 200, "start", Colours.DARK_GREEN, Colours.LIGHT_GREEN);
			stopButtonView = new ButtonView(container, 400, 200, "stop", Colours.DARK_RED, Colours.LIGHT_RED);
			resetButtonView = new ButtonView(container, 500, 200, "reset", Colours.DARK_GREY, Colours.LIGHT_GREY);
			
			pomodoroModel.addEventListener(DisplayTimerModel.DISPLAY_UPDATE, function(event:GeneralEvent):void {
				pomodoroView.updateDisplay("" + event.data);
			});
			breakModel.addEventListener(DisplayTimerModel.DISPLAY_UPDATE, function(event:GeneralEvent):void {
				breakView.updateDisplay("" + event.data);
			});
			pomodoroModel.addEventListener(DisplayTimerModel.SHOW, function(event:GeneralEvent = null):void {
				pomodoroView.show();
			});
			breakModel.addEventListener(DisplayTimerModel.SHOW, function(event:GeneralEvent = null):void {
				breakView.show();
			});
			pomodoroModel.addEventListener(DisplayTimerModel.HIDE, function(event:GeneralEvent = null):void {
				pomodoroView.hide();
			});
			breakModel.addEventListener(DisplayTimerModel.HIDE, function(event:GeneralEvent = null):void {
				breakView.hide();
			});
			pomodoroModel.addEventListener(DisplayTimerModel.TIMER_COMPLETE, playBeep);
			breakModel.addEventListener(DisplayTimerModel.TIMER_COMPLETE, playBeep);
			
			pomadoroTimer();
		}
		
		private function playBeep(e:Event = null):void {
			var request:URLRequest = new URLRequest("../assets/alarm.mp3");
			var sound:Sound = new Sound();
			sound.load(request);
			sound.play();
		}
		
		private function initControllers():void {
			startButtonView.addEventListener(MouseEvent.CLICK, startTimer);
			stopButtonView.addEventListener(MouseEvent.CLICK, stopTimer);
			resetButtonView.addEventListener(MouseEvent.CLICK, resetTimer);
			pomodoroButtonView.addEventListener(MouseEvent.CLICK, pomadoroTimer);
			breakButtonView.addEventListener(MouseEvent.CLICK, breakTimer);
		}
		
		private function startTimer(e:Event = null):void {
			currentTimer.start();
		}
		
		private function stopTimer(e:Event = null):void {
			currentTimer.stop();
		}
		
		private function resetTimer(e:Event = null):void {
			currentTimer.reset();
		}
		
		private function pomadoroTimer(e:Event = null):void {
			currentTimer = pomodoroModel;
			pomodoroModel.show();
			breakModel.hide();
			breakModel.reset();
		}
		
		private function breakTimer(e:Event = null):void {
			currentTimer = breakModel;
			breakModel.show();
			pomodoroModel.hide();
			pomodoroModel.reset();
		}
	}

}