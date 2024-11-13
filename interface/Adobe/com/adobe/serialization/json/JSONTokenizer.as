package com.adobe.serialization.json
{
	public class JSONTokenizer
	{
		private var strict:Boolean;

		private var obj:Object;

		private var jsonString:String;

		private var loc:int;

		private var ch:String;

		private const controlCharsRegExp:RegExp = /[\x00-\x1F]/;

		public function JSONTokenizer(inputString:String, strictMode:Boolean)
		{
			super();
			this.jsonString = inputString;
			this.strict = strictMode;
			this.loc = 0;
			this.nextChar();
		}

		public function getNextToken():JSONToken
		{
			var trueStr:String = null;
			var falseStr:String = null;
			var nullStr:String = null;
			var nanStr:String = null;
			var token:JSONToken = null;
			this.skipIgnored();
			switch (this.ch)
			{
				case "{":
					token = JSONToken.create(JSONTokenType.LEFT_BRACE, this.ch);
					this.nextChar();
					break;
				case "}":
					token = JSONToken.create(JSONTokenType.RIGHT_BRACE, this.ch);
					this.nextChar();
					break;
				case "[":
					token = JSONToken.create(JSONTokenType.LEFT_BRACKET, this.ch);
					this.nextChar();
					break;
				case "]":
					token = JSONToken.create(JSONTokenType.RIGHT_BRACKET, this.ch);
					this.nextChar();
					break;
				case ",":
					token = JSONToken.create(JSONTokenType.COMMA, this.ch);
					this.nextChar();
					break;
				case ":":
					token = JSONToken.create(JSONTokenType.COLON, this.ch);
					this.nextChar();
					break;
				case "t":
					trueStr = "t" + this.nextChar() + this.nextChar() + this.nextChar();
					if (trueStr == "true")
					{
						token = JSONToken.create(JSONTokenType.TRUE, true);
						this.nextChar();
					}
					else
					{
						this.parseError("Expecting 'true' but found " + trueStr);
					}
					break;
				case "f":
					falseStr = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
					if (falseStr == "false")
					{
						token = JSONToken.create(JSONTokenType.FALSE, false);
						this.nextChar();
					}
					else
					{
						this.parseError("Expecting 'false' but found " + falseStr);
					}
					break;
				case "n":
					nullStr = "n" + this.nextChar() + this.nextChar() + this.nextChar();
					if (nullStr == "null")
					{
						token = JSONToken.create(JSONTokenType.NULL, null);
						this.nextChar();
					}
					else
					{
						this.parseError("Expecting 'null' but found " + nullStr);
					}
					break;
				case "N":
					nanStr = "N" + this.nextChar() + this.nextChar();
					if (nanStr == "NaN")
					{
						token = JSONToken.create(JSONTokenType.NAN, NaN);
						this.nextChar();
					}
					else
					{
						this.parseError("Expecting 'NaN' but found " + nanStr);
					}
					break;
				case "\"":
					token = this.readString();
					break;
				default:
					if (this.isDigit(this.ch) || this.ch == "-")
					{
						token = this.readNumber();
					}
					else if (this.ch == "")
					{
						token = null;
					}
					else
					{
						this.parseError("Unexpected " + this.ch + " encountered");
					}
			}
			return token;
		}

		final private function readString():JSONToken
		{
			var backslashCount:int = 0;
			var backtrackIndex:int = 0;
			var endIndex:int = this.loc;
			while (true)
			{
				endIndex = int(this.jsonString.indexOf("\"", endIndex));
				if (endIndex >= 0)
				{
					backslashCount = 0;
					backtrackIndex = endIndex - 1;
					while (this.jsonString.charAt(backtrackIndex) == "\\")
					{
						backslashCount++;
						backtrackIndex--;
					}
					if ((backslashCount & 1) == 0)
					{
						break;
					}
					endIndex++;
				}
				else
				{
					this.parseError("Unterminated string literal");
				}
			}
			var stringToken:JSONToken = JSONToken.create(JSONTokenType.STRING, this.unescapeString(this.jsonString.substr(this.loc, endIndex - this.loc)));
			this.loc = endIndex + 1;
			this.nextChar();
			return stringToken;
		}

		public function unescapeString(inputStr:String):String
		{
			var startIdx:int = 0;
			var escapeChar:String = null;
			var hexDigits:String = null;
			var hexEnd:int = 0;
			var hexIdx:int = 0;
			var hexChar:String = null;
			if (this.strict && Boolean(this.controlCharsRegExp.test(inputStr)))
			{
				this.parseError("String contains unescaped control character (0x00-0x1F)");
			}
			var unescapedStr:String = "";
			var currentIdx:int = 0;
			startIdx = 0;
			var inputLength:int = inputStr.length;
			do
			{
				currentIdx = int(inputStr.indexOf("\\", startIdx));
				if (currentIdx < 0)
				{
					unescapedStr += inputStr.substr(startIdx);
					break;
				}
				unescapedStr += inputStr.substr(startIdx, currentIdx - startIdx);
				startIdx = currentIdx + 2;
				escapeChar = inputStr.charAt(currentIdx + 1);
				switch (escapeChar)
				{
					case "\"":
						unescapedStr += escapeChar;
						break;
					case "\\":
						unescapedStr += escapeChar;
						break;
					case "n":
						unescapedStr += "\n";
						break;
					case "r":
						unescapedStr += "\r";
						break;
					case "t":
						unescapedStr += "\t";
						break;
					case "u":
						hexDigits = "";
						hexEnd = startIdx + 4;
						if (hexEnd > inputLength)
						{
							this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
						}
						hexIdx = startIdx;
						while (hexIdx < hexEnd)
						{
							hexChar = inputStr.charAt(hexIdx);
							if (!this.isHexDigit(hexChar))
							{
								this.parseError("Excepted a hex digit, but found: " + hexChar);
							}
							hexDigits += hexChar;
							hexIdx++;
						}
						unescapedStr += String.fromCharCode(parseInt(hexDigits, 16));
						startIdx = hexEnd;
						break;
					case "f":
						unescapedStr += "\f";
						break;
					case "/":
						unescapedStr += "/";
						break;
					case "b":
						unescapedStr += "\b";
						break;
					default:
						unescapedStr += "\\" + escapeChar;
						break;
				}
			}
			while (startIdx < inputLength);

			return unescapedStr;
		}

		final private function readNumber():JSONToken
		{
			var numberStr:String = "";
			if (this.ch == "-")
			{
				numberStr += "-";
				this.nextChar();
			}
			if (!this.isDigit(this.ch))
			{
				this.parseError("Expecting a digit");
			}
			if (this.ch == "0")
			{
				numberStr += this.ch;
				this.nextChar();
				if (this.isDigit(this.ch))
				{
					this.parseError("A digit cannot immediately follow 0");
				}
				else if (!this.strict && this.ch == "x")
				{
					numberStr += this.ch;
					this.nextChar();
					if (this.isHexDigit(this.ch))
					{
						numberStr += this.ch;
						this.nextChar();
					}
					else
					{
						this.parseError("Number in hex format require at least one hex digit after \"0x\"");
					}
					while (this.isHexDigit(this.ch))
					{
						numberStr += this.ch;
						this.nextChar();
					}
				}
			}
			else
			{
				while (this.isDigit(this.ch))
				{
					numberStr += this.ch;
					this.nextChar();
				}
			}
			if (this.ch == ".")
			{
				numberStr += ".";
				this.nextChar();
				if (!this.isDigit(this.ch))
				{
					this.parseError("Expecting a digit");
				}
				while (this.isDigit(this.ch))
				{
					numberStr += this.ch;
					this.nextChar();
				}
			}
			if (this.ch == "e" || this.ch == "E")
			{
				numberStr += "e";
				this.nextChar();
				if (this.ch == "+" || this.ch == "-")
				{
					numberStr += this.ch;
					this.nextChar();
				}
				if (!this.isDigit(this.ch))
				{
					this.parseError("Scientific notation number needs exponent value");
				}
				while (this.isDigit(this.ch))
				{
					numberStr += this.ch;
					this.nextChar();
				}
			}
			var parsedNum:Number = Number(numberStr);
			if (isFinite(parsedNum) && !isNaN(parsedNum))
			{
				return JSONToken.create(JSONTokenType.NUMBER, parsedNum);
			}
			this.parseError("Number " + parsedNum + " is not valid!");
			return null;
		}

		final private function nextChar():String
		{
			return this.ch = this.jsonString.charAt(this.loc++ );
		}

		final private function skipIgnored():void
		{
			var lastLoc:int = 0;
			do
			{
				lastLoc = this.loc;
				this.skipWhite();
				this.skipComments();
			}
			while (lastLoc != this.loc);

		}

		private function skipComments():void
		{
			if (this.ch == "/")
			{
				this.nextChar();
				switch (this.ch)
				{
					case "/":
						do
						{
							this.nextChar();
						}
						while (this.ch != "\n" && this.ch != "");

						this.nextChar();
						break;
					case "*":
						this.nextChar();
						while (true)
						{
							if (this.ch == "*")
							{
								this.nextChar();
								if (this.ch == "/")
								{
									break;
								}
							}
							else
							{
								this.nextChar();
							}
							if (this.ch == "")
							{
								this.parseError("Multi-line comment not closed");
							}
						}
						this.nextChar();
						break;
					default:
						this.parseError("Unexpected " + this.ch + " encountered (expecting '/' or '*' )");
				}
			}
		}

		final private function skipWhite():void
		{
			while (this.isWhiteSpace(this.ch))
			{
				this.nextChar();
			}
		}

		final private function isWhiteSpace(char:String):Boolean
		{
			if (char == " " || char == "\t" || char == "\n" || char == "\r")
			{
				return true;
			}
			if (!this.strict && char.charCodeAt(0) == 160)
			{
				return true;
			}
			return false;
		}

		final private function isDigit(char:String):Boolean
		{
			return char >= "0" && char <= "9";
		}

		final private function isHexDigit(char:String):Boolean
		{
			return this.isDigit(char) || char >= "A" && char <= "F" || char >= "a" && char <= "f";
		}

		final public function parseError(message:String):void
		{
			throw new JSONParseError(message, this.loc, this.jsonString);
		}
	}
}
