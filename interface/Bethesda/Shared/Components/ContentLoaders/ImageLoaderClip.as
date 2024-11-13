package Shared.Components.ContentLoaders
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class ImageLoaderClip extends BaseLoaderClip
	{
		private var _ImageInstance:Bitmap = null;

		private var _ImageName:String = "";

		public function ImageLoaderClip()
		{
			super();
		}

		public function get imageInstance():Bitmap
		{
			return this._ImageInstance;
		}

		public function LoadImage(imagePath:String):void
		{
			var imageRequest:URLRequest = null;
			if (this._ImageName != imagePath)
			{
				this.Unload();
				this._ImageName = imagePath;
				imageRequest = new URLRequest("img://" + this._ImageName);
				super.Load(imageRequest);
			}
			else if (_OnLoadAttemptComplete != null)
			{
				_OnLoadAttemptComplete();
			}
		}

		override public function Unload():void
		{
			super.Unload();
			this.destroyImage();
		}

		override protected function onLoadFailed(event:Event):void
		{
			trace("WARNING: ImageLoaderClip:onLoadFailed | " + this._ImageName);
			super.onLoadFailed(event);
		}

		override protected function onLoaded(event:Event):void
		{
			this._ImageInstance = event.target.content;
			if (this._ImageInstance != null)
			{
				this._ImageInstance.name = "ImageInstance";
				this._ImageInstance.smoothing = true;
			}
			AddDisplayObject(this._ImageInstance);
			super.onLoaded(event);
		}

		private function destroyImage():void
		{
			RemoveDisplayObject(this._ImageInstance);
			this._ImageName = "";
		}
	}
}
