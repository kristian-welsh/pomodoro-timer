package com.button {
	import com.Colours;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ButtonView extends EventDispatcher {
		static private const TEXT:String = "Start";
		static private const PADDING:Object = {
			"LEFT":10,
			"TOP":5,
			"RIGHT":10,
			"BOTTOM":5
		};
		static private const BORDER_THICKNESS:uint = 2;
		
		private var graphics:Sprite;
		private var label:TextField;
		private var base:Sprite;
		
		public function ButtonView(container:DisplayObjectContainer, x:Number, y:Number, text:String, borderColour:uint, fillColour:uint) {
			graphics = new Sprite();
			
			drawLabel(text, borderColour);
			drawBase(borderColour, fillColour);
			
			graphics.addChild(base);
			graphics.addChild(label);
			
			container.addChild(graphics);
			
			graphics.x = x;
			graphics.y = y;
			
			graphics.addEventListener(MouseEvent.CLICK, dispatchEvent);
		}
		
		public function set x(newX:Number):void {
			graphics.x = newX;
		}
		
		public function set y(newY:Number):void {
			graphics.y = newY;
		}
		
		private function drawLabel(text:String, colour:uint):void {
			label = new TextField();
			
			var format:TextFormat = new TextFormat("arial", 20, colour);
			format.align = TextFormatAlign.CENTER;
			label.defaultTextFormat = format;
			
			label.text = text;
			label.x = PADDING.LEFT;
			label.y = PADDING.TOP;
			label.selectable = false;
			label.width = label.textWidth + 5;
			label.height = label.textHeight + 5;
		}
		
		private function drawBase(borderColour:uint, fillColour:uint):void {
			base = new Sprite();
			base.graphics.lineStyle(BORDER_THICKNESS, borderColour);
			base.graphics.beginFill(fillColour);
			
			base.graphics.lineTo(baseRight(), baseTop());
			base.graphics.lineTo(baseRight(), baseBottom());
			base.graphics.lineTo(baseLeft(), baseBottom());
			base.graphics.lineTo(baseLeft(), baseTop());
			
			base.graphics.endFill();
		}
		
		private function baseTop():Number {
			return 0;
		}
		
		private function baseLeft():Number {
			return 0;
		}
		
		private function baseRight():Number {
			return label.x + label.textWidth + PADDING.LEFT + PADDING.RIGHT - 5
		}
		
		private function baseBottom():Number {
			return label.y + label.textHeight + PADDING.TOP + PADDING.BOTTOM;
		}
	}
}