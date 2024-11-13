package com.adobe.serialization.json
{
	public class JSONDecoder
	{
		private var strict:Boolean;

		private var value:*;

		private var tokenizer:JSONTokenizer;

		private var token:JSONToken;

		public function JSONDecoder(jsonString:String, strictMode:Boolean)
		{
			super();
			this.strict = strictMode;
			this.tokenizer = new JSONTokenizer(jsonString, strictMode);
			this.nextToken();
			this.value = this.parseValue();
			if (strictMode && this.nextToken() != null)
			{
				this.tokenizer.parseError("Unexpected characters left in input stream");
			}
		}

		public function getValue():*
		{
			return this.value;
		}

		final private function nextToken():JSONToken
		{
			return this.token = this.tokenizer.getNextToken();
		}

		final private function nextValidToken():JSONToken
		{
			this.token = this.tokenizer.getNextToken();
			this.checkValidToken();
			return this.token;
		}

		final private function checkValidToken():void
		{
			if (this.token == null)
			{
				this.tokenizer.parseError("Unexpected end of input");
			}
		}

		final private function parseArray():Array
		{
			var array:Array = new Array();
			this.nextValidToken();
			if (this.token.type == JSONTokenType.RIGHT_BRACKET)
			{
				return array;
			}
			if (!this.strict && this.token.type == JSONTokenType.COMMA)
			{
				this.nextValidToken();
				if (this.token.type == JSONTokenType.RIGHT_BRACKET)
				{
					return array;
				}
				this.tokenizer.parseError("Leading commas are not supported.  Expecting ']' but found " + this.token.value);
			}
			while (true)
			{
				array.push(this.parseValue());
				this.nextValidToken();
				if (this.token.type == JSONTokenType.RIGHT_BRACKET)
				{
					break;
				}
				if (this.token.type == JSONTokenType.COMMA)
				{
					this.nextToken();
					if (!this.strict)
					{
						this.checkValidToken();
						if (this.token.type == JSONTokenType.RIGHT_BRACKET)
						{
							return array;
						}
					}
				}
				else
				{
					this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
				}
			}
			return array;
		}

		final private function parseObject():Object
		{
			var propertyName:String = null;
			var obj:Object = new Object();
			this.nextValidToken();
			if (this.token.type == JSONTokenType.RIGHT_BRACE)
			{
				return obj;
			}
			if (!this.strict && this.token.type == JSONTokenType.COMMA)
			{
				this.nextValidToken();
				if (this.token.type == JSONTokenType.RIGHT_BRACE)
				{
					return obj;
				}
				this.tokenizer.parseError("Leading commas are not supported.  Expecting '}' but found " + this.token.value);
			}
			while (true)
			{
				if (this.token.type == JSONTokenType.STRING)
				{
					propertyName = String(this.token.value);
					this.nextValidToken();
					if (this.token.type == JSONTokenType.COLON)
					{
						this.nextToken();
						obj[propertyName] = this.parseValue();
						this.nextValidToken();
						if (this.token.type == JSONTokenType.RIGHT_BRACE)
						{
							break;
						}
						if (this.token.type == JSONTokenType.COMMA)
						{
							this.nextToken();
							if (!this.strict)
							{
								this.checkValidToken();
								if (this.token.type == JSONTokenType.RIGHT_BRACE)
								{
									return obj;
								}
							}
						}
						else
						{
							this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
						}
					}
					else
					{
						this.tokenizer.parseError("Expecting : but found " + this.token.value);
					}
				}
				else
				{
					this.tokenizer.parseError("Expecting string but found " + this.token.value);
				}
			}
			return obj;
		}

		final private function parseValue():Object
		{
			this.checkValidToken();
			switch (this.token.type)
			{
				case JSONTokenType.LEFT_BRACE:
					return this.parseObject();
				case JSONTokenType.LEFT_BRACKET:
					return this.parseArray();
				case JSONTokenType.STRING:
				case JSONTokenType.NUMBER:
				case JSONTokenType.TRUE:
				case JSONTokenType.FALSE:
				case JSONTokenType.NULL:
					return this.token.value;
				case JSONTokenType.NAN:
					if (!this.strict)
					{
						return this.token.value;
					}
					this.tokenizer.parseError("Unexpected " + this.token.value);
					break;
			}
			this.tokenizer.parseError("Unexpected " + this.token.value);
			return null;
		}
	}
}
