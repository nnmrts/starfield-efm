package scaleform.gfx
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	public final class Extensions
	{
		public static var CLIK_addedToStageCallback:Function;

		public static var gfxProcessSound:Function;

		public static const EDGEAA_INHERIT:uint = 0;

		public static const EDGEAA_ON:uint = 1;

		public static const EDGEAA_OFF:uint = 2;

		public static const EDGEAA_DISABLE:uint = 3;

		public static var isGFxPlayer:Boolean = false;

		public function Extensions()
		{
			super();
		}

		public static function set enabled(isEnabled:Boolean):void
		{
		}

		public static function get enabled():Boolean
		{
			return false;
		}

		public static function set noInvisibleAdvance(value:Boolean):void
		{
		}

		public static function get noInvisibleAdvance():Boolean
		{
			return false;
		}

		public static function getTopMostEntity(x:Number, y:Number, mouseEnabled:Boolean = true):DisplayObject
		{
			return null;
		}

		public static function getMouseTopMostEntity(mouseEnabled:Boolean = true, controllerIdx:uint = 0):DisplayObject
		{
			return null;
		}

		public static function setMouseCursorType(cursorType:String, controllerIdx:uint = 0):void
		{
		}

		public static function getMouseCursorType(controllerIdx:uint = 0):String
		{
			return "";
		}

		public static function get numControllers():uint
		{
			return 1;
		}

		public static function get visibleRect():Rectangle
		{
			return new Rectangle(0, 0, 0, 0);
		}

		public static function getEdgeAAMode(displayObj:DisplayObject):uint
		{
			return EDGEAA_INHERIT;
		}

		public static function setEdgeAAMode(displayObj:DisplayObject, mode:uint):void
		{
		}

		public static function setIMEEnabled(textField:TextField, enabled:Boolean):void
		{
		}

		public static function get isScaleform():Boolean
		{
			return false;
		}
	}
}
