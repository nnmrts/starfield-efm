package
{
	import Components.ImageFixture;
	import Shared.AS3.Data.BSUIDataManager;
	import Shared.AS3.Data.FromClientDataEvent;
	import Shared.AS3.Events.CustomEvent;
	import Shared.AS3.IMenu;
	import Shared.GlobalFunc;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;

	public class FavoritesMenu extends IMenu
	{
		public static const FS_LEFT_3:uint = 0;

		public static const FS_LEFT_2:uint = 1;

		public static const FS_LEFT_1:uint = 2;

		public static const FS_RIGHT_1:uint = 3;

		public static const FS_RIGHT_2:uint = 4;

		public static const FS_RIGHT_3:uint = 5;

		public static const FS_UP_3:uint = 6;

		public static const FS_UP_2:uint = 7;

		public static const FS_UP_1:uint = 8;

		public static const FS_DOWN_1:uint = 9;

		public static const FS_DOWN_2:uint = 10;

		public static const FS_DOWN_3:uint = 11;

		// public static const FS_TOP_RIGHT_1:uint = 12;

		// public static const FS_TOP_RIGHT_2:uint = 13;

		public static const FS_TOP_RIGHT_3:uint = 12;

		public static const FS_NONE:uint = 13;

		public var CenterClip_mc:MovieClip;

		public var ItemInfo_mc:FavoriteAssigningInfoDisplay;

		public var AssignedItemIcon_mc:ImageFixture;

		public var Vignette_mc:MovieClip;

		public var SelectQuickslot_mc:MovieClip;

		public var Entry_0:FavoritesEntry;

		public var Entry_1:FavoritesEntry;

		public var Entry_2:FavoritesEntry;

		public var Entry_3:FavoritesEntry;

		public var Entry_4:FavoritesEntry;

		public var Entry_5:FavoritesEntry;

		public var Entry_6:FavoritesEntry;

		public var Entry_7:FavoritesEntry;

		public var Entry_8:FavoritesEntry;

		public var Entry_9:FavoritesEntry;

		public var Entry_10:FavoritesEntry;

		public var Entry_11:FavoritesEntry;

		public var Entry_12:FavoritesEntry;

		public var Entry_13:FavoritesEntry;

		// public var Entry_14:FavoritesEntry;

		private var FavoritesInfoA:Array;

		private var AssignedItem:Object = null;

		private var HasAssignedSlotOnce:Boolean = false;

		private var IsDataInitialized:Boolean = false;

		private var _SelectedIndex:uint = 13;

		public const TIMELINE_EVENT_CLOSE_ANIM_DONE:String = "onFinishedClosingAnim";

		private var OverEntry:Boolean = false;

		private const _UpDirectory:Array = [FS_UP_1, FS_UP_1, FS_UP_1, FS_UP_1, FS_UP_1, FS_UP_1, FS_UP_3, FS_UP_3, FS_UP_2, FS_UP_1, FS_DOWN_1, FS_DOWN_2, FS_UP_1];

		private const _DownDirectory:Array = [FS_DOWN_1, FS_DOWN_1, FS_DOWN_1, FS_DOWN_1, FS_DOWN_1, FS_DOWN_1, FS_UP_2, FS_UP_1, FS_DOWN_1, FS_DOWN_2, FS_DOWN_3, FS_DOWN_3, FS_DOWN_1];

		private const _LeftDirectory:Array = [FS_LEFT_3, FS_LEFT_3, FS_LEFT_2, FS_LEFT_1, FS_RIGHT_1, FS_RIGHT_2, FS_LEFT_1, FS_LEFT_1, FS_LEFT_1, FS_LEFT_1, FS_LEFT_1, FS_LEFT_1, FS_LEFT_1];

		private const _RightDirectory:Array = [FS_LEFT_2, FS_LEFT_1, FS_RIGHT_1, FS_RIGHT_2, FS_RIGHT_3, FS_RIGHT_3, FS_RIGHT_1, FS_RIGHT_1, FS_RIGHT_1, FS_RIGHT_1, FS_RIGHT_1, FS_RIGHT_1, FS_RIGHT_1];

		public function FavoritesMenu()
		{
			super();
			try
			{
				addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
				addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
				addEventListener(FavoritesEntry.CLICK, this.SelectItem);
				addEventListener(FavoritesEntry.MOUSE_OVER, this.onFavEntryMouseover);
				addEventListener(FavoritesEntry.MOUSE_LEAVE, this.onFavEntryMouseleave);
				BSUIDataManager.Subscribe("FavoritesData", this.onDataUpdate);
				this.AssignedItemIcon_mc.mouseEnabled = false;
				this.AssignedItemIcon_mc.mouseChildren = false;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu constructor TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		override public function onAddedToStage():void
		{
			super.onAddedToStage();
			try
			{
				stage.focus = this;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onAddedToStage TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		private function onDataUpdate(param1:FromClientDataEvent):void
		{
			try
			{
				var index:uint = 0;
				var _loc3_:Object = null;
				var _loc4_:FavoritesEntry = null;

				this.FavoritesInfoA = param1.data.aFavoriteItems;
				if (!this.IsDataInitialized)
				{
					this.assignedItem = param1.data.ItemToBeAssigned;
					this.selectedIndex = FS_NONE;
					this.CenterClip_mc.gotoAndStop(this.isAssigningItem() ? "Inventory" : "Quick");
				}
				this.SelectQuickslot_mc.visible = this.isAssigningItem() && !this.HasAssignedSlotOnce;
				this.SelectQuickslot_mc.gotoAndPlay(this.SelectQuickslot_mc.visible ? "Open" : "Close");
				this.AssignedItemIcon_mc.visible = this.isAssigningItem() && !this.HasAssignedSlotOnce;
				this.AssignedItemIcon_mc.gotoAndPlay(this.AssignedItemIcon_mc.visible ? "Open" : "Close");

				while (this.FavoritesInfoA != null && index < this.FavoritesInfoA.length)
				{
					_loc3_ = this.FavoritesInfoA[index];
					_loc4_ = this.GetEntryClip(index);
					if (_loc4_ != null)
					{
						_loc4_.LoadIcon(_loc3_);
					}
					index++;
				}
				this.IsDataInitialized = true;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onDataUpdate TRACE ---------");
				trace(e.getStackTrace());
				GlobalFunc.InspectObject(param1, true, true);
			}
		}

		public function isAssigningItem():Boolean
		{
			try
			{
				return this.AssignedItem != null && this.AssignedItem.sName.length != 0;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.isAssigningItem TRACE ---------");
				trace(e.getStackTrace());
				return false;
			}

			return false;
		}

		public function get assignedItem():Object
		{
			try
			{
				return this.AssignedItem;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.get assignedItem TRACE ---------");
				trace(e.getStackTrace());
				return null;
			}
			return null;
		}

		public function set assignedItem(param1:Object):void
		{
			try
			{
				this.AssignedItem = param1;
				if (this.isAssigningItem())
				{
					this.ItemInfo_mc.UpdateDisplay(this.AssignedItem);
					if (this.AssignedItem.iconImage.iFixtureType == ImageFixture.FT_SYMBOL)
					{
						if (this.AssignedItem.bIsPower)
						{
							this.AssignedItemIcon_mc.clipSizer = "Sizer_mc";
						}
						this.AssignedItemIcon_mc.centerClip = true;
					}
					else
					{
						this.AssignedItemIcon_mc.clipSizer = "";
						this.AssignedItemIcon_mc.centerClip = false;
					}
					this.AssignedItemIcon_mc.LoadImageFixtureFromUIData(this.AssignedItem.iconImage, "FavoritesIconBuffer");
					this.ItemInfo_mc.visible = true;
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.set assignedItem TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		public function get selectedIndex():uint
		{
			try
			{
				return this._SelectedIndex;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.get selectedIndex TRACE ---------");
				trace(e.getStackTrace());
				return FS_NONE;
			}
			return FS_NONE;
		}

		public function set selectedIndex(param1:uint):void
		{
			try
			{
				if (param1 != this._SelectedIndex)
				{
					if (this._SelectedIndex != FS_NONE)
					{
						this.GetEntryClip(this._SelectedIndex).selected = false;
					}
					this._SelectedIndex = param1;
					if (this._SelectedIndex != FS_NONE)
					{
						this.GetEntryClip(this._SelectedIndex).selected = true;
					}
					this.onSelectionChange();
					GlobalFunc.PlayMenuSound(this.selectionSound);
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.set selectedIndex TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		public function get selectedEntry():Object
		{
			try
			{
				return this.FavoritesInfoA != null && this._SelectedIndex >= 0 && this._SelectedIndex < this.FavoritesInfoA.length ? this.FavoritesInfoA[this._SelectedIndex] : null;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.get selectedEntry TRACE ---------");
				trace(e.getStackTrace());
				return null;
			}
			return null;
		}

		public function get selectionSound():String
		{
			var _loc1_:String = "";
			try
			{
				switch (this.selectedIndex)
				{
					case FS_UP_1:
					case FS_DOWN_1:
					case FS_LEFT_1:
					case FS_RIGHT_1:
						_loc1_ = "UIMenuQuickUseFocusDpadA";
						break;
					case FS_UP_2:
					case FS_DOWN_2:
					case FS_LEFT_2:
					case FS_RIGHT_2:
						_loc1_ = "UIMenuQuickUseFocusDpadB";
						break;
					case FS_UP_3:
					case FS_DOWN_3:
					case FS_LEFT_3:
					case FS_RIGHT_3:
						_loc1_ = "UIMenuQuickUseFocusDpadC";
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.get selectionSound TRACE ---------");
				trace(e.getStackTrace());
			}
			return _loc1_;
		}

		public function GetEntryClip(param1:uint):FavoritesEntry
		{
			var _loc2_:FavoritesEntry = null;
			try
			{
				_loc2_ = getChildByName("Entry_" + param1) as FavoritesEntry;
				if (_loc2_ == null)
				{
					GlobalFunc.TraceWarning("Could not find the entry 'Entry_" + param1 + "'!");
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.GetEntryClip TRACE ---------");
				trace(e.getStackTrace());
			}
			return _loc2_;
		}

		public function ProcessUserEvent(param1:String, param2:Boolean):Boolean
		{
			var _loc4_:Number = NaN;
			var _loc3_:Boolean = false;
			try
			{
				if (!param2)
				{
					_loc3_ = true;
					switch (param1)
					{
						case "Cancel":
						case "Quickkeys":
						case "YButton":
							this.StartClosingMenu();
							_loc3_ = true;
							break;
						default:
							_loc4_ = Number(param1.substr(8));
							if (_loc4_ >= 1 && _loc4_ <= FS_NONE)
							{
								this.selectedIndex = _loc4_ - 1;
								this.SelectItem();
							}
							else
							{
								_loc3_ = false;
							}
					}
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.ProcessUserEvent TRACE ---------");
				trace(e.getStackTrace());
			}
			return _loc3_;
		}

		private function StartClosingMenu():void
		{
			try
			{
				gotoAndPlay("Close");
				addEventListener(this.TIMELINE_EVENT_CLOSE_ANIM_DONE, this.onCloseAnimFinished);
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.StartClosingMenu TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		private function onCloseAnimFinished():void
		{
			try
			{
				removeEventListener(this.TIMELINE_EVENT_CLOSE_ANIM_DONE, this.onCloseAnimFinished);
				GlobalFunc.CloseMenu("FavoritesMenu");
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onCloseAnimFinished TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		private function onSelectionChange():void
		{
			try
			{
				this.ItemInfo_mc.UpdateDisplay(this.selectedEntry);
				this.ItemInfo_mc.visible = true;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onSelectionChange TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		public function onKeyDownHandler(param1:KeyboardEvent):*
		{
			try
			{
				switch (param1.keyCode)
				{
					case Keyboard.UP:
						this.selectedIndex = this._UpDirectory[this.selectedIndex];
						break;
					case Keyboard.DOWN:
						this.selectedIndex = this._DownDirectory[this.selectedIndex];
						break;
					case Keyboard.LEFT:
						this.selectedIndex = this._LeftDirectory[this.selectedIndex];
						break;
					case Keyboard.RIGHT:
						this.selectedIndex = this._RightDirectory[this.selectedIndex];
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onKeyDownHandler TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		public function onKeyUpHandler(param1:KeyboardEvent):*
		{
			try
			{
				switch (param1.keyCode)
				{
					case Keyboard.ENTER:
						if (this.selectedIndex != FS_NONE)
						{
							this.SelectItem();
							param1.stopPropagation();
						}
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onKeyUpHandler TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		private function SelectItem():void
		{
			try
			{
				if (this.isAssigningItem())
				{
					BSUIDataManager.dispatchEvent(new CustomEvent("FavoritesMenu_AssignQuickkey", {"uQuickkeyIndex": this.selectedIndex}));
				}
				else
				{
					BSUIDataManager.dispatchEvent(new CustomEvent("FavoritesMenu_UseQuickkey", {"uQuickkeyIndex": this.selectedIndex}));
				}
				this.StartClosingMenu();
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.SelectItem TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		private function onFavEntryMouseover(param1:Event):void
		{
			try
			{
				this.selectedIndex = param1.target.entryIndex;
				this.OverEntry = true;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onFavEntryMouseover TRACE ---------");
				trace(e.getStackTrace());
			}
		}

		private function onFavEntryMouseleave(param1:Event):void
		{
			try
			{
				this.OverEntry = false;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onFavEntryMouseleave TRACE ---------");
				trace(e.getStackTrace());
			}
		}
	}
}
