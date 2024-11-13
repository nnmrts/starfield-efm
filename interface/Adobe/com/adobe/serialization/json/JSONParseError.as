package com.adobe.serialization.json
{
	public class JSONParseError extends Error
	{
		private var _location:int;

		private var _text:String;

		public function JSONParseError(message:String = "", errorLocation:int = 0, errorText:String = "")
		{
			super(message);
			name = "JSONParseError";
			this._location = errorLocation;
			this._text = errorText;
		}

		public function get location():int
		{
			return this._location;
		}

		public function get text():String
		{
			return this._text;
		}
	}
}
