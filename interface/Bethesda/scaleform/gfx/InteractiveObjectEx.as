package scaleform.gfx
{
	import flash.display.InteractiveObject;

	public class InteractiveObjectEx extends DisplayObjectEx
	{
		public function InteractiveObjectEx()
		{
			super();
		}

		public static function setHitTestDisable(object:InteractiveObject, disabled:Boolean):void
		{
		}

		public static function getHitTestDisable(object:InteractiveObject):Boolean
		{
			return false;
		}

		public static function setTopmostLevel(object:InteractiveObject, topmost:Boolean):void
		{
		}

		public static function getTopmostLevel(object:InteractiveObject):Boolean
		{
			return false;
		}
	}
}
