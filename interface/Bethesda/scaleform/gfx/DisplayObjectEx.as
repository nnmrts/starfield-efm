package scaleform.gfx
{
	import flash.display.DisplayObject;

	public class DisplayObjectEx
	{
		public function DisplayObjectEx()
		{
			super();
		}

		public static function disableBatching(displayObj:DisplayObject, disabled:Boolean):void
		{
		}

		public static function isBatchingDisabled(displayObj:DisplayObject):Boolean
		{
			return false;
		}

		public static function setRendererString(displayObj:DisplayObject, rendererStr:String):void
		{
		}

		public static function getRendererString(displayObj:DisplayObject):String
		{
			return null;
		}

		public static function setRendererFloat(displayObj:DisplayObject, rendererValue:Number):void
		{
		}

		public static function getRendererFloat(displayObj:DisplayObject):Number
		{
			return Number.NaN;
		}
	}
}
