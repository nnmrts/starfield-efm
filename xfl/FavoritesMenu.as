package
{
	import System.Diagnostics.*;
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
			addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
			addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
			addEventListener(FavoritesEntry.CLICK, this.SelectItem);
			addEventListener(FavoritesEntry.MOUSE_OVER, this.onFavEntryMouseover);
			addEventListener(FavoritesEntry.MOUSE_LEAVE, this.onFavEntryMouseleave);
			BSUIDataManager.Subscribe("FavoritesData", this.onDataUpdate);
			this.AssignedItemIcon_mc.mouseEnabled = false;
			this.AssignedItemIcon_mc.mouseChildren = false;

			// Utility.TraceObject(FavoritesInfoA);
		}

		override public function onAddedToStage():void
		{
			super.onAddedToStage();
			stage.focus = this;
		}

		private function onDataUpdate(clientDataEvent:FromClientDataEvent):void
		{
			// trace("BIG TRACE ---------");
			// trace(getTimer());
			// try
			// {
			// Utility.TraceObject(clientDataEvent);
			// Utility.TraceObject(clientDataEvent.toString());
			// Utility.TraceObject(clientDataEvent.data);
			// Utility.TraceObject(clientDataEvent.data.aFavoriteItems);
			// }
			// catch (e:Error)
			// {
			// trace(e.getStackTrace());
			// }

			trace("FavoritesMenu.onDataUpdate TRACE ---------");

			try
			{
				var favEntryData:Object = null;
				var favEntry:FavoritesEntry = null;
				this.FavoritesInfoA = clientDataEvent.data.aFavoriteItems;
				if (!this.IsDataInitialized)
				{
					this.assignedItem = clientDataEvent.data.ItemToBeAssigned;
					this.selectedIndex = clientDataEvent.data.uStartingSelection;
					this.CenterClip_mc.gotoAndStop(this.isAssigningItem() ? "Inventory" : "Quick");
				}
				this.SelectQuickslot_mc.visible = this.isAssigningItem() && !this.HasAssignedSlotOnce;
				this.SelectQuickslot_mc.gotoAndPlay(this.SelectQuickslot_mc.visible ? "Open" : "Close");
				this.AssignedItemIcon_mc.visible = this.isAssigningItem() && !this.HasAssignedSlotOnce;
				this.AssignedItemIcon_mc.gotoAndPlay(this.AssignedItemIcon_mc.visible ? "Open" : "Close");
				var index:uint = 0;
			}
			catch (e:Error)
			{
				trace(e.getStackTrace());
			}

			trace("WHILE TRACE ---------");
			while (this.FavoritesInfoA != null && index < this.FavoritesInfoA.length)
			{
				trace("REACHED 1");
				favEntryData = this.FavoritesInfoA[index];
				trace("REACHED 2");
				favEntry = this.GetEntryClip(index);
				trace("REACHED 3");
				if (favEntry != null)
				{
					trace("REACHED 4");
					favEntry.LoadIcon(favEntryData);
				}
				trace("REACHED 5");
				index++;
			}
			this.IsDataInitialized = true;
		}

		public function isAssigningItem():Boolean
		{
			return this.AssignedItem != null && this.AssignedItem.sName.length != 0;
		}

		public function get assignedItem():Object
		{
			return this.AssignedItem;
		}

		public function set assignedItem(item:Object):void
		{
			this.AssignedItem = item;
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

		public function get selectedIndex():uint
		{
			return this._SelectedIndex;
		}

		public function set selectedIndex(value:uint):void
		{
			if (value != this._SelectedIndex)
			{
				if (this._SelectedIndex != FS_NONE)
				{
					this.GetEntryClip(this._SelectedIndex).selected = false;
				}
				this._SelectedIndex = value;
				if (this._SelectedIndex != FS_NONE)
				{
					this.GetEntryClip(this._SelectedIndex).selected = true;
				}
				this.onSelectionChange();
				GlobalFunc.PlayMenuSound(this.selectionSound);
			}
		}

		public function get selectedEntry():Object
		{
			return this.FavoritesInfoA != null && this._SelectedIndex >= 0 && this._SelectedIndex < this.FavoritesInfoA.length ? this.FavoritesInfoA[this._SelectedIndex] : null;
		}

		public function get selectionSound():String
		{
			var value:String = "";
			switch (this.selectedIndex)
			{
				case FS_UP_1:
				case FS_DOWN_1:
				case FS_LEFT_1:
				case FS_RIGHT_1:
					value = "UIMenuQuickUseFocusDpadA";
					break;
				case FS_UP_2:
				case FS_DOWN_2:
				case FS_LEFT_2:
				case FS_RIGHT_2:
					value = "UIMenuQuickUseFocusDpadB";
					break;
				case FS_UP_3:
				case FS_DOWN_3:
				case FS_LEFT_3:
				case FS_RIGHT_3:
					value = "UIMenuQuickUseFocusDpadC";
			}
			return value;
		}

		public function GetEntryClip(entryID:uint):FavoritesEntry
		{
			var favEntry:FavoritesEntry = getChildByName("Entry_" + entryID) as FavoritesEntry;
			if (favEntry == null)
			{
				GlobalFunc.TraceWarning("Could not find the entry 'Entry_" + entryID + "'!");
			}
			return favEntry;
		}

		public function ProcessUserEvent(controlName:String, isHandled:Boolean):Boolean
		{
			var favEntryID:Number = NaN;
			var handled:Boolean = false;
			if (!isHandled)
			{
				handled = true;
				switch (controlName)
				{
					case "Cancel":
					case "Quickkeys":
					case "YButton":
						this.StartClosingMenu();
						handled = true;
						break;
					default:
						favEntryID = Number(controlName.substr(8));
						if (favEntryID >= 1 && favEntryID <= FS_NONE)
						{
							this.selectedIndex = favEntryID - 1;
							this.SelectItem();
						}
						else
						{
							handled = false;
						}
				}
			}
			return handled;
		}

		private function StartClosingMenu():void
		{
			gotoAndPlay("Close");
			addEventListener(this.TIMELINE_EVENT_CLOSE_ANIM_DONE, this.onCloseAnimFinished);
		}

		private function onCloseAnimFinished():void
		{
			removeEventListener(this.TIMELINE_EVENT_CLOSE_ANIM_DONE, this.onCloseAnimFinished);
			GlobalFunc.CloseMenu("FavoritesMenu");
		}

		private function onSelectionChange():void
		{
			this.ItemInfo_mc.UpdateDisplay(this.selectedEntry);
			this.ItemInfo_mc.visible = true;
		}

		public function onKeyDownHandler(event:KeyboardEvent):*
		{
			switch (event.keyCode)
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

		public function onKeyUpHandler(event:KeyboardEvent):*
		{
			switch (event.keyCode)
			{
				case Keyboard.ENTER:
					if (this.selectedIndex != FS_NONE)
					{
						this.SelectItem();
						event.stopPropagation();
					}
			}
		}

		private function SelectItem():void
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

		private function onFavEntryMouseover(event:Event):void
		{
			try
			{
				this.selectedIndex = event.target.entryIndex;
				this.OverEntry = true;
			}
			catch (e:Error)
			{
				// trace("Error: " + e.message);
				trace(e);
				trace(e.message);
				trace(e.getStackTrace());
			}

			// this.FavoritesInfoA = Array(12)
			// .map(function()
			// {
			// return {
			// sName: "MockItem1",
			// iconImage: {
			// iFixtureType: ImageFixture.FT_SYMBOL,
			// sImageName: "Meds",
			// sDirectory: "Symbols"
			// },
			// bIsPower: false,
			// bIsEquippable: true,
			// bIsEquipped: false,
			// uCount: 1,
			// sAmmoName: "",
			// uAmmoCount: 0,
			// aElementalStats: {
			// 0: {
			// iElementalType: 0,
			// fValue: 16
			// }
			// }
			// };
			// });
		}

		private function onFavEntryMouseleave(event:Event):void
		{
			this.OverEntry = false;
		}
	}
}
