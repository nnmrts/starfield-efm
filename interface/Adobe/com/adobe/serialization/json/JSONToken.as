package com.adobe.serialization.json
{
	public final class JSONToken
	{
		internal static const token:JSONToken = new JSONToken();

		public var type:int;

		public var value:Object;

		public function JSONToken(tokenType:int = -1, tokenValue:Object = null)
		{
			super();
			this.type = tokenType;
			this.value = tokenValue;
		}

		internal static function create(tokenType:int = -1, tokenValue:Object = null):JSONToken
		{
			token.type = tokenType;
			token.value = tokenValue;
			return token;
		}
	}
}
