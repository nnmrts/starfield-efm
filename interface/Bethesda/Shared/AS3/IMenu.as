package Shared.AS3
{
	import Shared.GlobalFunc;
	import flash.display.InteractiveObject;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class IMenu extends BSDisplayObject
	{
		private var _bRestoreLostFocus:Boolean;

		private var safeX:Number = 0;

		private var safeY:Number = 0;

		private var textFieldSizeMap:Object = new Object();

		public function IMenu()
		{
			super();
			this._bRestoreLostFocus = false;
			GlobalFunc.MaintainTextFormat();
		}

		public function get SafeX():Number
		{
			return this.safeX;
		}

		public function get SafeY():Number
		{
			return this.safeY;
		}

		override public function onAddedToStage():void
		{
			stage.stageFocusRect = false;
			stage.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusLostEvent);
			stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onMouseFocusEvent);
		}

		override public function onRemovedFromStage():void
		{
			stage.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusLostEvent);
			stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onMouseFocusEvent);
		}

		public function SetSafeRect(safeRectX:Number, safeRectY:Number):*
		{
			this.safeX = safeRectX;
			this.safeY = safeRectY;
			this.onSetSafeRect();
		}

		protected function onSetSafeRect():void
		{
		}

		private function onFocusLostEvent(event:FocusEvent):*
		{
			if (this._bRestoreLostFocus)
			{
				this._bRestoreLostFocus = false;
				stage.focus = event.target as InteractiveObject;
			}
			this.onFocusLost(event);
		}

		public function onFocusLost(event:FocusEvent):*
		{
		}

		protected function onMouseFocusEvent(event:FocusEvent):*
		{
			if (event.target == null || !(event.target is InteractiveObject))
			{
				stage.focus = null;
			}
			else
			{
				this._bRestoreLostFocus = true;
			}
		}

		public function ShrinkFontToFit(textField:TextField, maxVisibleLines:int):*
		{
			var currentSize:int = 0;
			var textFormat:TextFormat = textField.getTextFormat();
			if (this.textFieldSizeMap[textField] == null)
			{
				this.textFieldSizeMap[textField] = textFormat.size;
			}
			textFormat.size = this.textFieldSizeMap[textField];
			textField.setTextFormat(textFormat);
			var scrollLines:int = textField.maxScrollV;
			while (scrollLines > maxVisibleLines && textFormat.size > 4)
			{
				currentSize = textFormat.size as int;
				textFormat.size = currentSize - 1;
				textField.setTextFormat(textFormat);
				scrollLines = textField.maxScrollV;
			}
		}
	}
}
