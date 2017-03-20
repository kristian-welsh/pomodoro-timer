package com.counter {
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class CounterView {
		private const graphics:TextField = new TextField();
		
		public function CounterView(container:DisplayObjectContainer, x:Number, y:Number, size:uint) {
			var format:TextFormat = new TextFormat("arial", size)
			graphics.defaultTextFormat = format;
			graphics.autoSize = TextFieldAutoSize.LEFT;
			graphics.x = x;
			graphics.y = y;
			container.addChild(graphics);
			setValue(0);
		}
		
		public function setValue(newValue:int):void {
			graphics.text = "" + newValue;
		}
	}
}