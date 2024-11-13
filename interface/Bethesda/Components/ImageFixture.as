package Components
{
	import Shared.AS3.Data.BSUIDataManager;
	import Shared.AS3.Events.CustomEvent;
	import Shared.Components.ContentLoaders.ImageLoaderClip;
	import Shared.Components.ContentLoaders.SymbolLoaderClip;
	import Shared.EnumHelper;
	import flash.display.Bitmap;
	import flash.display.MovieClip;

	public class ImageFixture extends MovieClip
	{
		private static const REQUEST_IMAGE:String = "ImageFixtureEvent_RequestImage";

		private static const UNREGISTER_IMAGE:String = "ImageFixtureEvent_UnregisterImage";

		private static const NONE_LOADED:int = EnumHelper.GetEnum(0);

		private static const SWF_LOADED:int = EnumHelper.GetEnum();

		private static const IN_LOADED:int = EnumHelper.GetEnum();

		private static const EX_LOADED:int = EnumHelper.GetEnum();

		public static const FT_INVALID:int = EnumHelper.GetEnum(-1);

		public static const FT_INTERNAL:int = EnumHelper.GetEnum();

		public static const FT_EXTERNAL:int = EnumHelper.GetEnum();

		public static const FT_SYMBOL:int = EnumHelper.GetEnum();

		public var BoundClip_mc:MovieClip;

		private var _State:int = NONE_LOADED;

		private var _ImageLoader:ImageLoaderClip;

		private var _SymbolLoader:SymbolLoaderClip;

		private var _ImageName:String = "";

		private var _BufferName:String = "";

		private var _RequestSent:Boolean = false;

		private var _FixtureType:int = FT_INVALID;

		public function ImageFixture()
		{
			super();
			this._ImageLoader = new ImageLoaderClip();
			this._SymbolLoader = new SymbolLoaderClip();
			this.addChild(this._ImageLoader);
			this.addChild(this._SymbolLoader);
			if (this.BoundClip_mc != null)
			{
				this._ImageLoader.BoundClip_mc = this.BoundClip_mc;
				this._SymbolLoader.BoundClip_mc = this.BoundClip_mc;
			}
		}

		public function set fixtureType(newType:int):void
		{
			this._FixtureType = newType;
		}

		public function get fixtureType():int
		{
			return this._FixtureType;
		}

		public function get imageInstance():Bitmap
		{
			return this._ImageLoader.imageInstance;
		}

		public function get symbolInstance():MovieClip
		{
			return this._SymbolLoader.symbolInstance;
		}

		public function set centerClip(isCentered:Boolean):void
		{
			this._ImageLoader.centerClip = isCentered;
			this._SymbolLoader.centerClip = isCentered;
		}

		public function set clipSizer(sizerName:String):void
		{
			this._SymbolLoader.clipSizer = sizerName;
		}

		public function set clipAlpha(alphaValue:Number):void
		{
			this._ImageLoader.clipAlpha = alphaValue;
			this._SymbolLoader.clipAlpha = alphaValue;
		}

		public function set clipScale(scaleValue:Number):void
		{
			this._ImageLoader.clipScale = scaleValue;
			this._SymbolLoader.clipScale = scaleValue;
		}

		public function set clipRotation(rotationValue:Number):void
		{
			this._ImageLoader.clipRotation = rotationValue;
			this._SymbolLoader.clipRotation = rotationValue;
		}

		public function set clipWidth(widthValue:Number):void
		{
			this._ImageLoader.clipWidth = widthValue;
			this._SymbolLoader.clipWidth = widthValue;
		}

		public function set clipHeight(heightValue:Number):void
		{
			this._ImageLoader.clipHeight = heightValue;
			this._SymbolLoader.clipHeight = heightValue;
		}

		public function set clipYOffset(yOffset:Number):void
		{
			this._ImageLoader.clipYOffset = yOffset;
			this._SymbolLoader.clipYOffset = yOffset;
		}

		public function set clipXOffset(xOffset:Number):void
		{
			this._ImageLoader.clipXOffset = xOffset;
			this._SymbolLoader.clipXOffset = xOffset;
		}

		public function set onLoadAttemptComplete(callback:Function):void
		{
			this._ImageLoader.onLoadAttemptComplete = callback;
			this._SymbolLoader.onLoadAttemptComplete = callback;
		}

		public function set errorClassName(className:String):void
		{
			this._ImageLoader.errorClassName = className;
			this._SymbolLoader.errorClassName = className;
		}

		public function set loadingClassName(className:String):void
		{
			this._ImageLoader.loadingClassName = className;
			this._SymbolLoader.loadingClassName = className;
		}

		public function LoadImageFixtureFromUIData(fixtureData:Object, bufferName:String):void
		{
			this.fixtureType = fixtureData.iFixtureType;
			switch (fixtureData.iFixtureType)
			{
				case FT_INTERNAL:
					this.LoadInternal(fixtureData.sDirectory + fixtureData.sImageName, bufferName);
					break;
				case FT_EXTERNAL:
					this.LoadExternal(fixtureData.sDirectory + fixtureData.sImageName, bufferName);
					break;
				case FT_SYMBOL:
					this.LoadSymbol(fixtureData.sImageName, fixtureData.sDirectory);
					break;
				default:
					trace("ImageFixture::LoadImageFixtureFromUIData: Fixture type is invalid, cannot load.");
			}
		}

		public function LoadSymbol(symbolName:String, directory:String = ""):void
		{
			if (this._ImageName != symbolName || this._State != SWF_LOADED)
			{
				this.Unload();
				this._ImageName = symbolName;
				this._State = SWF_LOADED;
				this._SymbolLoader.LoadSymbol(symbolName, directory);
			}
			else if (this._SymbolLoader.onLoadAttemptComplete != null)
			{
				this._SymbolLoader.onLoadAttemptComplete.call();
			}
		}

		public function LoadInternal(imagePath:String, bufferName:String):void
		{
			if (this._ImageName != imagePath || this._State != IN_LOADED)
			{
				this.Unload();
				this._ImageName = imagePath;
				this._State = IN_LOADED;
				this._BufferName = bufferName;
				this.LoadBitmap();
			}
			else if (this._ImageLoader.onLoadAttemptComplete != null)
			{
				this._ImageLoader.onLoadAttemptComplete.call();
			}
		}

		public function LoadExternal(imagePath:String, bufferName:String):void
		{
			if (this._ImageName != imagePath || this._State != EX_LOADED)
			{
				this.Unload();
				this._ImageName = imagePath;
				this._State = EX_LOADED;
				this._BufferName = bufferName;
				this.LoadBitmap();
			}
			else if (this._ImageLoader.onLoadAttemptComplete != null)
			{
				this._ImageLoader.onLoadAttemptComplete.call();
			}
		}

		public function Unload():void
		{
			this.UnloadBitmap();
			this._SymbolLoader.Unload();
			this._State = NONE_LOADED;
			this._ImageName = "";
			this._BufferName = "";
		}

		private function LoadBitmap():void
		{
			BSUIDataManager.dispatchEvent(
					new CustomEvent(
						REQUEST_IMAGE,
						{
							"imageName": this._ImageName,
							"isExternal": this._State == EX_LOADED,
							"bufferName": this._BufferName
						}
					)
				);
			this._RequestSent = true;
			this._ImageLoader.LoadImage(this._ImageName);
		}

		private function UnloadBitmap():void
		{
			this._ImageLoader.Unload();
			if (this._RequestSent)
			{
				BSUIDataManager.dispatchEvent(
						new CustomEvent(
							UNREGISTER_IMAGE,
							{
								"imageName": this._ImageName,
								"isExternal": this._State == EX_LOADED,
								"bufferName": this._BufferName
							}
						)
					);
				this._RequestSent = false;
			}
		}
	}
}
