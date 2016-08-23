package com.timer {
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class DisplayTimerView {
		private var time:TextField;
		
		public function DisplayTimerView(container:DisplayObjectContainer, x:Number, y:Number, size:uint) {
			time = new TextField();
			var format:TextFormat = new TextFormat("arial", size)
			time.defaultTextFormat = format;
			time.autoSize = TextFieldAutoSize.LEFT;
			container.addChild(time);
			
			time.x = x;
			time.y = y;
		}
		
		public function updateDisplay(display:String):void {
			time.text = display;
		}
		
		public function show():void {
			time.visible = true;
		}
		
		public function hide():void {
			time.visible = false;
		}
	}
}