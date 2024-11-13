package Shared.Components.ContentLoaders
{
	import Shared.GlobalFunc;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;

	public class BaseLoaderClip extends MovieClip
	{
		protected var _Loader:Loader = new Loader();

		public var ErrorClip_mc:MovieClip;

		public var LoadingClip_mc:MovieClip;

		public var BoundClip_mc:MovieClip;

		private var _ErrorClassName:String = "ErrorClip";

		private var _LoadingClassName:String = "LoadingClip";

		private var _errorClipDefinedOnStage:Boolean = false;

		private var _loadingClipDefinedOnStage:Boolean = false;

		protected var _OnLoadAttemptComplete:Function = null;

		protected var ClipAlpha:Number = 1;

		protected var ClipScale:Number = 1;

		protected var ClipRotation:Number = 0;

		protected var ClipWidth:Number = 0;

		protected var ClipHeight:Number = 0;

		protected var ClipXOffset:Number = 0;

		protected var ClipYOffset:Number = 0;

		protected var CenterClip:Boolean = false;

		protected var ClipSizer:String = "";

		public function BaseLoaderClip()
		{
			super();
			addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStageEvent);
		}

		public function set errorClassName(newClassName:String):void
		{
			var wasVisible:Boolean = false;
			if (this._ErrorClassName != newClassName)
			{
				this._ErrorClassName = newClassName;
				wasVisible = this.ErrorClip_mc != null && this.ErrorClip_mc.visible;
				this.RemoveDisplayObject(this.ErrorClip_mc);
				this.ErrorClip_mc = this.RecreateClipFromClass(this._ErrorClassName, "ErrorClip_mc");
				this.ErrorClip_mc.visible = wasVisible;
			}
		}

		public function set loadingClassName(newClassName:String):void
		{
			var wasVisible:Boolean = false;
			if (this._LoadingClassName != newClassName)
			{
				this._LoadingClassName = newClassName;
				wasVisible = this.LoadingClip_mc != null && this.LoadingClip_mc.visible;
				this.RemoveDisplayObject(this.LoadingClip_mc);
				this.LoadingClip_mc = this.RecreateClipFromClass(this._LoadingClassName, "LoadingClip_mc");
				this.LoadingClip_mc.visible = wasVisible;
			}
		}

		public function set clipAlpha(param1:Number):void
		{
			this.ClipAlpha = param1;
		}

		public function set clipScale(param1:Number):void
		{
			this.ClipScale = param1;
		}

		public function set clipRotation(param1:Number):void
		{
			this.ClipRotation = param1;
		}

		public function set clipWidth(param1:Number):void
		{
			this.ClipWidth = param1;
		}

		public function set clipHeight(param1:Number):void
		{
			this.ClipHeight = param1;
		}

		public function get clipWidth():Number
		{
			return this.ClipWidth;
		}

		public function get clipHeight():Number
		{
			return this.ClipHeight;
		}

		public function get clipScale():Number
		{
			return this.ClipScale;
		}

		public function set clipYOffset(param1:Number):void
		{
			this.ClipYOffset = param1;
		}

		public function get clipYOffset():Number
		{
			return this.ClipYOffset;
		}

		public function set clipXOffset(param1:Number):void
		{
			this.ClipXOffset = param1;
		}

		public function get clipXOffset():Number
		{
			return this.ClipXOffset;
		}

		public function set centerClip(param1:Boolean):void
		{
			this.CenterClip = param1;
		}

		public function get centerClip():Boolean
		{
			return this.CenterClip;
		}

		public function get onLoadAttemptComplete():Function
		{
			return this._OnLoadAttemptComplete;
		}

		public function set onLoadAttemptComplete(param1:Function):void
		{
			this._OnLoadAttemptComplete = param1;
		}

		public function set clipSizer(param1:String):void
		{
			this.ClipSizer = param1;
		}

		public function get clipSizer():String
		{
			return this.ClipSizer;
		}

		protected function get loader():Loader
		{
			return this._Loader;
		}

		protected function Load(request:URLRequest, context:LoaderContext = null):void
		{
			this.ShowLoading();
			this._Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaded);
			this._Loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
			this._Loader.load(request, context);
		}

		public function Unload():void
		{
			this.cancelLoader();
			this.HideError();
			this.HideLoading();
		}

		protected function onLoadFailed(event:Event):void
		{
			this._Loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoaded);
			this._Loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
			this.Unload();
			this.ShowError();
			if (this._OnLoadAttemptComplete != null)
			{
				this._OnLoadAttemptComplete();
			}
		}

		protected function onLoaded(event:Event):void
		{
			this.HideLoading();
			this._Loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoaded);
			this._Loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
			if (this._OnLoadAttemptComplete != null)
			{
				this._OnLoadAttemptComplete();
			}
		}

		private function cancelLoader():void
		{
			try
			{
				this._Loader.close();
			}
			catch (e:Error)
			{
			}
		}

		protected function ShowError():void
		{
			if (this.ErrorClip_mc == null)
			{
				this.ErrorClip_mc = this.RecreateClipFromClass(this._ErrorClassName, "ErrorClip_mc");
			}
			if (this.ErrorClip_mc != null)
			{
				this.ErrorClip_mc.visible = true;
			}
		}

		protected function ShowLoading():void
		{
			if (this.LoadingClip_mc == null)
			{
				this.LoadingClip_mc = this.RecreateClipFromClass(this._LoadingClassName, "LoadingClip_mc");
			}
			if (this.LoadingClip_mc != null)
			{
				this.LoadingClip_mc.visible = true;
			}
		}

		protected function HideError():void
		{
			if (this.ErrorClip_mc != null)
			{
				this.ErrorClip_mc.visible = false;
			}
		}

		protected function HideLoading():void
		{
			if (this.LoadingClip_mc != null)
			{
				this.LoadingClip_mc.visible = false;
			}
		}

		private function RecreateClipFromClass(className:String, clipName:String = ""):MovieClip
		{
			var clipClass:Class = null;
			var newClip:MovieClip = null;
			if (className != "" && ApplicationDomain.currentDomain.hasDefinition(className))
			{
				clipClass = getDefinitionByName(className) as Class;
				if (clipClass != null)
				{
					newClip = new clipClass();
					if (newClip != null)
					{
						newClip.name = clipName;
						this.AddDisplayObject(newClip);
					}
				}
			}
			return newClip;
		}

		private function onRemoveFromStageEvent(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStageEvent);
			this._Loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoaded);
			this._Loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
			this.Unload();
		}

		protected function AddDisplayObject(displayObject:DisplayObject):void
		{
			var targetForSizing:DisplayObject = undefined;
			var widthRatio:Number = NaN;
			var heightRatio:Number = NaN;
			var scale:Number = NaN;
			var targetMovieClip:MovieClip = null;
			var targetCenter:Point = null;
			var boundCenter:Point = null;
			var centerOffset:Point = null;
			if (displayObject != null)
			{
				this.addChild(displayObject);
				displayObject.alpha = this.ClipAlpha;
				if (this.BoundClip_mc != null)
				{
					targetForSizing = displayObject;
					if (this.ClipSizer.length > 0)
					{
						targetMovieClip = displayObject as MovieClip;
						if (targetMovieClip == null)
						{
							GlobalFunc.TraceWarning("Only movie clips can be resized using a sizer chid. " + displayObject.name + " is not a movie clip.");
						}
						else
						{
							targetForSizing = targetMovieClip.getChildByName(this.ClipSizer) as DisplayObject;
							if (targetForSizing == null)
							{
								GlobalFunc.TraceWarning(displayObject.name + " does not have a sizer child clip with name " + this.ClipSizer + ".");
								targetForSizing = displayObject;
							}
						}
					}
					widthRatio = this.BoundClip_mc.width / targetForSizing.width;
					heightRatio = this.BoundClip_mc.height / targetForSizing.height;
					scale = Math.min(widthRatio, heightRatio);
					displayObject.scaleX = scale;
					displayObject.scaleY = scale;
					if (this.CenterClip)
					{
						targetCenter = GlobalFunc.GetRectangleCenter(targetForSizing.getBounds(this));
						boundCenter = GlobalFunc.GetRectangleCenter(this.BoundClip_mc.getBounds(this));
						centerOffset = boundCenter.subtract(targetCenter);
						displayObject.x = centerOffset.x;
						displayObject.y = centerOffset.y;
					}
					else
					{
						displayObject.x = this.BoundClip_mc.x;
						displayObject.y = this.BoundClip_mc.y;
					}
				}
				else
				{
					displayObject.scaleX = this.ClipScale;
					displayObject.scaleY = this.ClipScale;
					if (this.ClipWidth != 0)
					{
						displayObject.width = this.ClipWidth;
					}
					if (this.ClipHeight != 0)
					{
						displayObject.height = this.ClipHeight;
					}
					if (this.CenterClip)
					{
						displayObject.x -= this.ClipWidth / 2;
						displayObject.y -= this.ClipHeight / 2;
					}
					displayObject.x += this.ClipXOffset;
					displayObject.y += this.ClipYOffset;
				}
			}
		}

		protected function RemoveDisplayObject(displayObject:DisplayObject):void
		{
			if (displayObject != null)
			{
				this.removeChild(displayObject);
				if (displayObject.loaderInfo != null)
				{
					displayObject.loaderInfo.loader.unload();
				}
				displayObject = null;
			}
		}
	}
}
