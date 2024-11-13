package scaleform.gfx
{
	import flash.display.BitmapData;
	import flash.text.TextField;

	public final class TextFieldEx extends InteractiveObjectEx
	{
		public static const VALIGN_NONE:String = "none";

		public static const VALIGN_TOP:String = "top";

		public static const VALIGN_CENTER:String = "center";

		public static const VALIGN_BOTTOM:String = "bottom";

		public static const TEXTAUTOSZ_NONE:String = "none";

		public static const TEXTAUTOSZ_SHRINK:String = "shrink";

		public static const TEXTAUTOSZ_FIT:String = "fit";

		public static const VAUTOSIZE_NONE:String = "none";

		public static const VAUTOSIZE_TOP:String = "top";

		public static const VAUTOSIZE_CENTER:String = "center";

		public static const VAUTOSIZE_BOTTOM:String = "bottom";

		public function TextFieldEx()
		{
			super();
		}

		public static function appendHtml(textField:TextField, htmlText:String):void
		{
		}

		public static function setIMEEnabled(textField:TextField, enabled:Boolean):void
		{
		}

		public static function setVerticalAlign(textField:TextField, alignType:String):void
		{
		}

		public static function getVerticalAlign(textField:TextField):String
		{
			return "none";
		}

		public static function setVerticalAutoSize(textField:TextField, sizeType:String):void
		{
		}

		public static function getVerticalAutoSize(textField:TextField):String
		{
			return "none";
		}

		public static function setTextAutoSize(textField:TextField, sizeType:String):void
		{
		}

		public static function getTextAutoSize(textField:TextField):String
		{
			return "none";
		}

		public static function setImageSubstitutions(textField:TextField, substitutions:Object):void
		{
		}

		public static function updateImageSubstitution(textField:TextField, identifier:String, bitmapData:BitmapData):void
		{
		}

		public static function setNoTranslate(textField:TextField, noTranslate:Boolean):void
		{
		}

		public static function getNoTranslate(textField:TextField):Boolean
		{
			return false;
		}

		public static function setBidirectionalTextEnabled(textField:TextField, enabled:Boolean):void
		{
		}

		public static function getBidirectionalTextEnabled(textField:TextField):Boolean
		{
			return false;
		}

		public static function setSelectionTextColor(textField:TextField, color:uint):void
		{
		}

		public static function getSelectionTextColor(textField:TextField):uint
		{
			return 4294967295;
		}

		public static function setSelectionBkgColor(textField:TextField, color:uint):void
		{
		}

		public static function getSelectionBkgColor(textField:TextField):uint
		{
			return 4278190080;
		}

		public static function setInactiveSelectionTextColor(textField:TextField, color:uint):void
		{
		}

		public static function getInactiveSelectionTextColor(textField:TextField):uint
		{
			return 4294967295;
		}

		public static function setInactiveSelectionBkgColor(textField:TextField, color:uint):void
		{
		}

		public static function getInactiveSelectionBkgColor(textField:TextField):uint
		{
			return 4278190080;
		}
	}
}
