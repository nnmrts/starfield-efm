package
{
	import Components.ImageFixture;
	import Shared.AS3.BSDisplayObject;
	import Shared.GlobalFunc;
	import Shared.PlatformUtils;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import scaleform.gfx.Extensions;
	import scaleform.gfx.TextFieldEx;
	import System.Diagnostics.*;
	import flash.utils.getTimer;

	public class FavoritesEntry extends BSDisplayObject
	{
		public static const MOUSE_OVER:String = "FavoritesEntry::mouse_over";

		public static const MOUSE_LEAVE:String = "FavoritesEntry::mouse_leave";

		public static const CLICK:String = "FavoritesEntry::mouse_click";

		public var Icon_mc:ImageFixture;

		public var Quickkey_tf:TextField;

		public var SlotInfoSpacer_mc:MovieClip;

		public var Catcher_mc:MovieClip;

		private var _EntryIndex:uint;

		private var OrigTextColor:uint;

		public function FavoritesEntry()
		{
			try
			{
				super();
				addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, this.onMouseLeave);
				addEventListener(MouseEvent.CLICK, this.onMousePress);
				this._EntryIndex = uint(this.name.substr(this.name.lastIndexOf("_") + 1));
				this.OrigTextColor = this.Quickkey_tf.textColor;
				Extensions.enabled = true;
				TextFieldEx.setTextAutoSize(this.Quickkey_tf, TextFieldEx.TEXTAUTOSZ_SHRINK);
				if (this.Catcher_mc)
				{
					this.hitArea = this.Catcher_mc;
					this.Catcher_mc.mouseEnabled = false;
				}
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.constructor TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		override protected function OnControlMapChanged(param1:Object):void
		{
			try
			{
				var _loc3_:Object = null;
				super.OnControlMapChanged(param1);
				this.Quickkey_tf.visible = this.uiController == PlatformUtils.PLATFORM_PC_KB_MOUSE;
				var _loc2_:String = "Quickkey" + (this._EntryIndex + 1);
				for each (_loc3_ in param1.vMappedEvents)
				{
					if (_loc3_.strUserEventName == _loc2_)
					{
						GlobalFunc.SetText(this.Quickkey_tf, _loc3_.strButtonName, false);
						break;
					}
				}
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.OnControlMapChanged TRACE ---------");
				trace(e.getStackTrace());
				GlobalFunc.InspectObject(param1, true, true);
			}
		}

		public function get entryIndex():uint
		{
			try
			{
				return this._EntryIndex;
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.get entryIndex TRACE ---------");
				trace(e.getStackTrace());
				return 0;
			}
			return 0;
		}

		public function set selected(param1:Boolean):void
		{
			try
			{
				gotoAndStop(param1 ? "Selected" : "Unselected");
				this.Quickkey_tf.textColor = param1 ? 0 : this.OrigTextColor;
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.set selected TRACE ---------");
				trace(e.getStackTrace());
				GlobalFunc.InspectObject(param1, true, true);
			}
		}

		public function LoadIcon(param1:Object):void
		{
			try
			{
				this.Icon_mc.Unload();
				if (param1 == null || param1.iconImage.iFixtureType == ImageFixture.FT_INVALID)
				{
					this.Icon_mc.visible = false;
				}
				else
				{
					if (param1.iconImage.iFixtureType == ImageFixture.FT_SYMBOL)
					{
						if (param1.bIsPower)
						{
							this.Icon_mc.clipSizer = "Sizer_mc";
						}
						this.Icon_mc.centerClip = true;
					}
					else
					{
						this.Icon_mc.clipSizer = "";
						this.Icon_mc.centerClip = false;
					}
					this.Icon_mc.onLoadAttemptComplete = this.onIconLoadAttemptComplete;
					this.Icon_mc.LoadImageFixtureFromUIData(param1.iconImage, "FavoritesIconBuffer");
					this.Icon_mc.visible = true;
				}
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.LoadIcon TRACE ---------");
				trace(e.getStackTrace());
				GlobalFunc.InspectObject(param1, true, true);
			}
		}

		public function onIconLoadAttemptComplete():void
		{
			try
			{
				this.Icon_mc.mouseEnabled = false;
				this.Icon_mc.mouseChildren = false;
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.onIconLoadAttemptComplete TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		public function onMousePress(param1:MouseEvent):void
		{
			try
			{
				dispatchEvent(new Event(CLICK, true, true));
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.onMousePress TRACE ---------");
				trace(e.getStackTrace());
				GlobalFunc.InspectObject(param1, true, true);
			}
		}

		public function onMouseOver(param1:MouseEvent):void
		{
			try
			{
				dispatchEvent(new Event(MOUSE_OVER, true, true));
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.onMouseOver TRACE ---------");
				trace(e.getStackTrace());
				GlobalFunc.InspectObject(param1, true, true);
			}
		}

		public function onMouseLeave(param1:MouseEvent):void
		{
			try
			{
				dispatchEvent(new Event(MOUSE_LEAVE, true, true));
			}
			catch (e:Error)
			{
				trace("FavoritesEntry.onMouseLeave TRACE ---------");
				trace(e.getStackTrace());
				GlobalFunc.InspectObject(param1, true, true);
			}
		}
	}
}
