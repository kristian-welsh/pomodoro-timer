package com{
	import com.button.ButtonView;
	import com.counter.CounterModel;
	import com.counter.CounterView;
	import com.events.GeneralEvent;
	import com.timer.DisplayTimerModel;
	import com.timer.DisplayTimerView;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class Main extends Sprite {
		static public const MARGIN:Number = 15;
		
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
		
		private var counterView:CounterView;
		private var counterModel:CounterModel;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var doc:DisplayObjectContainer = new Sprite();
			initModels();
			initViews(doc);
			initControllers();
			
			doc.x = MARGIN;
			doc.y = MARGIN;
			stage.addChild(doc);
		}
		
		private function initModels():void {
			pomodoroModel = new DisplayTimerModel(25);
			breakModel = new DisplayTimerModel(5);
			counterModel = new CounterModel();
		}
		
		private function initViews(container:DisplayObjectContainer):void {
			pomodoroView = new DisplayTimerView(container, 70, 60, 50); // 370 is magic, need alignemnt
			breakView = new DisplayTimerView(container, 70, 60, 50);
			
			pomodoroButtonView = new ButtonView(container, 0, 0, "pomodoro", Colours.DARK_BLUE, Colours.LIGHT_BLUE);
			breakButtonView = new ButtonView(container, 200, 0, "break", Colours.DARK_BLUE, Colours.LIGHT_BLUE);
			startButtonView = new ButtonView(container, 0, 150, "start", Colours.DARK_GREEN, Colours.LIGHT_GREEN);
			stopButtonView = new ButtonView(container, 100, 150, "stop", Colours.DARK_RED, Colours.LIGHT_RED);
			resetButtonView = new ButtonView(container, 200, 150, "reset", Colours.DARK_GREY, Colours.LIGHT_GREY);
			
			counterView = new CounterView(container, 150, 5, 20);
			
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
			
			pomodoroModel.addEventListener(DisplayTimerModel.TIMER_COMPLETE, function(event:GeneralEvent = null):void {
				playBeep();
				counterModel.increment();
			});
			breakModel.addEventListener(DisplayTimerModel.TIMER_COMPLETE, playBeep);
			
			counterModel.addEventListener(CounterModel.COUNTER_UPDATE, function(event:GeneralEvent = null):void {
				counterView.setValue(event.data as int);
			});
			
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
			startTimer();
		}
		
		private function breakTimer(e:Event = null):void {
			currentTimer = breakModel;
			breakModel.show();
			pomodoroModel.hide();
			pomodoroModel.reset();
			startTimer();
		}
	}

}