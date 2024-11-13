package Shared.Components.ContentLoaders
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;

	public class SymbolLoaderClip extends BaseLoaderClip
	{
		private var _SymbolInstance:MovieClip = null;

		private var _SymbolName:String = "";

		public function SymbolLoaderClip()
		{
			super();
		}

		public function get symbolInstance():MovieClip
		{
			return this._SymbolInstance;
		}

		public function LoadSymbol(symbolName:String, swfPath:String = ""):void
		{
			if (this._SymbolName != symbolName)
			{
				this.Unload();
				this._SymbolName = symbolName;
				this.LoadSymbolHelper(swfPath);
			}
			else if (_OnLoadAttemptComplete != null)
			{
				_OnLoadAttemptComplete();
			}
		}

		override public function Unload():void
		{
			super.Unload();
			this.destroySymbol();
		}

		override protected function onLoadFailed(event:Event):void
		{
			trace("WARNING: SymbolLoaderClip:onLoadFailed | " + this._SymbolName);
			super.onLoadFailed(event);
		}

		override protected function onLoaded(event:Event):void
		{
			this.LoadSymbolHelper();
			super.onLoaded(event);
		}

		private function destroySymbol():void
		{
			RemoveDisplayObject(this._SymbolInstance);
			this._SymbolName = "";
		}

		private function LoadSymbolHelper(swfPath:String = ""):void
		{
			var request:URLRequest = null;
			var loaderContext:LoaderContext = null;
			var symbolLoaded:Boolean = this.SymbolSetup();

			if (!symbolLoaded)
			{
				if (swfPath != "")
				{
					request = new URLRequest(swfPath + ".swf");
					loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
					super.Load(request, loaderContext);
				}
				else
				{
					trace("SymbolLoaderClip: Load Symbol Failure [" + this._SymbolName + "]");
					this.Unload();
					ShowError();
					if (_OnLoadAttemptComplete != null)
					{
						_OnLoadAttemptComplete();
					}
				}
			}
		}

		private function SymbolSetup():Boolean
		{
			var symbolClass:Class = null;
			if (this._SymbolName != "" && ApplicationDomain.currentDomain.hasDefinition(this._SymbolName))
			{
				symbolClass = getDefinitionByName(this._SymbolName) as Class;
				if (symbolClass != null)
				{
					this._SymbolInstance = new symbolClass();
					if (this._SymbolInstance != null)
					{
						this._SymbolInstance.name = "SymbolInstance";
						AddDisplayObject(this._SymbolInstance);
						if (_OnLoadAttemptComplete != null)
						{
							_OnLoadAttemptComplete();
						}
					}
				}
			}
			return this._SymbolInstance != null;
		}
	}
}
