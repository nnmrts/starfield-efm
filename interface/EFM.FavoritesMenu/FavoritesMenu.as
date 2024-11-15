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
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;

	public class FavoritesMenu extends IMenu
	{

		// Stage
		//---------------------------------------------

		public const TIMELINE_EVENT_CLOSE_ANIM_DONE:String = "onFinishedClosingAnim";

		public var CenterClip_mc:MovieClip;
		public var ItemInfo_mc:FavoriteAssigningInfoDisplay;
		public var AssignedItemIcon_mc:ImageFixture;
		public var SelectQuickslot_mc:MovieClip;
		public var Vignette_mc:MovieClip;

		public var ExitButton_mc:MovieClip;
		public var DebugButton_mc:MovieClip;

		public var DebugPanel_mc:DebugPanel;

		// Data
		//---------------------------------------------

		private var IsDataInitialized:Boolean = false;
		private var HasAssignedSlotOnce:Boolean = false;
		private var OverEntry:Boolean = false;

		private var FavoritesInfoA:Array;


		// Slots
		//---------------------------------------------

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
		public var Entry_14:FavoritesEntry;
		public var Entry_15:FavoritesEntry;
		public var Entry_16:FavoritesEntry;
		public var Entry_17:FavoritesEntry;
		public var Entry_18:FavoritesEntry;
		public var Entry_19:FavoritesEntry;

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
		public static const FS_TOP_RIGHT_3:uint = 12;
		public static const FS_TOP_RIGHT_2:uint = 13;
		public static const FS_BOTTOM_RIGHT_3:uint = 14;
		public static const FS_BOTTOM_RIGHT_2:uint = 15;
		public static const FS_BOTTOM_LEFT_3:uint = 16;
		public static const FS_BOTTOM_LEFT_2:uint = 17;
		public static const FS_TOP_LEFT_3:uint = 18;
		public static const FS_TOP_LEFT_2:uint = 19;
		public static const FS_NONE:uint = 20;

		private const _UpDirectory:Array = [
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_3,
			FS_UP_3,
			FS_UP_2,
			FS_UP_1,
			FS_DOWN_1,
			FS_DOWN_2,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1,
			FS_UP_1
		];

		private const _DownDirectory:Array = [
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_UP_2,
			FS_UP_1,
			FS_DOWN_1,
			FS_DOWN_2,
			FS_DOWN_3,
			FS_DOWN_3,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
			FS_DOWN_1,
		];

		private const _LeftDirectory:Array = [
			FS_LEFT_3,
			FS_LEFT_3,
			FS_LEFT_2,
			FS_LEFT_1,
			FS_RIGHT_1,
			FS_RIGHT_2,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1,
			FS_LEFT_1
		];

		private const _RightDirectory:Array = [
			FS_LEFT_2,
			FS_LEFT_1,
			FS_RIGHT_1,
			FS_RIGHT_2,
			FS_RIGHT_3,
			FS_RIGHT_3,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1,
			FS_RIGHT_1
		];


		// FavoritesMenu
		//---------------------------------------------

		public function FavoritesMenu()
		{
			trace("FavoritesMenu::constructor");
			super();
			try
			{
				// Input Events
				addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
				addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
				addEventListener(FavoritesEntry.CLICK, this.SelectItem);
				addEventListener(FavoritesEntry.MOUSE_OVER, this.onFavEntryMouseover);
				addEventListener(FavoritesEntry.MOUSE_LEAVE, this.onFavEntryMouseleave);

				// Navigation Buttons
				ExitButton_mc.addEventListener(MouseEvent.CLICK, onExitMouseClick);
				DebugButton_mc.addEventListener(MouseEvent.CLICK, onDebugMouseClick);
				DebugButton_mc.visible = false;

				// Data Events
				BSUIDataManager.Subscribe("FavoritesData", this.onDataUpdate);

				// Assignment Mode
				this.AssignedItemIcon_mc.mouseEnabled = false;
				this.AssignedItemIcon_mc.mouseChildren = false;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::constructor TRACE ---------");
				trace(e.toString());
			}
		}

		override public function onAddedToStage():void
		{
			trace("FavoritesMenu::onAddedToStage");
			super.onAddedToStage();
			try
			{
				stage.focus = this;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::onAddedToStage TRACE ---------");
				trace(e.toString());
			}
		}


		// Shutdown
		//---------------------------------------------

		private function StartClosingMenu():void
		{
			trace("FavoritesMenu::StartClosingMenu");
			// TODO: This is temporarily disabled for debug purposes!
			try
			{
				// gotoAndPlay("Close");
				// addEventListener(this.TIMELINE_EVENT_CLOSE_ANIM_DONE, this.onCloseAnimFinished);
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::StartClosingMenu TRACE ---------");
				trace(e.toString());
			}
		}

		private function onCloseAnimFinished():void
		{
			trace("FavoritesMenu::onCloseAnimFinished");
			try
			{
				removeEventListener(this.TIMELINE_EVENT_CLOSE_ANIM_DONE, this.onCloseAnimFinished);
				GlobalFunc.CloseMenu("FavoritesMenu");
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::onCloseAnimFinished TRACE ---------");
				trace(e.toString());
			}
		}


		// Navigation
		//---------------------------------------------

		private function onExitMouseClick(event:Event)
		{
			trace("FavoritesMenu::onExitMouseClick(): " + event);
			GlobalFunc.CloseMenu("FavoritesMenu");
		}

		private function onDebugMouseClick(event:Event)
		{
			trace("FavoritesMenu::onDebugMouseClick(): " + event);
			DebugPanel_mc.Toggle();
		}


		// Data
		//---------------------------------------------

		private function onDataUpdate(clientDataEvent:FromClientDataEvent):void
		{
			trace("FavoritesMenu::onDataUpdate");
			try
			{
				var index:uint = 0;
				var favEntryData:Object = null;
				var favEntry:FavoritesEntry = null;

				this.FavoritesInfoA = clientDataEvent.data.aFavoriteItems;
				if (!this.IsDataInitialized)
				{
					this.assignedItem = clientDataEvent.data.ItemToBeAssigned;
					this.selectedIndex = FS_NONE;
					this.CenterClip_mc.gotoAndStop(this.isAssigningItem() ? "Inventory" : "Quick");
				}

				this.SelectQuickslot_mc.visible = this.isAssigningItem() && !this.HasAssignedSlotOnce;
				this.SelectQuickslot_mc.gotoAndPlay(this.SelectQuickslot_mc.visible ? "Open" : "Close");

				this.AssignedItemIcon_mc.visible = this.isAssigningItem() && !this.HasAssignedSlotOnce;
				this.AssignedItemIcon_mc.gotoAndPlay(this.AssignedItemIcon_mc.visible ? "Open" : "Close");

				while (this.FavoritesInfoA != null && index < this.FavoritesInfoA.length)
				{
					favEntryData = this.FavoritesInfoA[index];
					favEntry = this.GetEntryClip(index);
					if (favEntry != null)
					{
						favEntry.LoadIcon(favEntryData);
					}
					index++;
				}
				this.IsDataInitialized = true;
			}
			catch (e:Error)
			{
				// trace("FavoritesMenu::onDataUpdate TRACE ---------");
				// trace(e.toString());
				// GlobalFunc.InspectObject(clientDataEvent, true, true);
			}
		}


		// Input
		//---------------------------------------------

		public function ProcessUserEvent(controlName:String, isHandled:Boolean):Boolean
		{
			// trace("FavoritesMenu::ProcessUserEvent(controlName="+controlName+", isHandled="+isHandled+")");
			var favEntryID:Number = NaN;
			var handled:Boolean = false;
			try
			{
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
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::ProcessUserEvent TRACE ---------");
				trace(e.toString());
			}
			return handled;
		}


		public function onKeyDownHandler(event:KeyboardEvent):*
		{
			trace("FavoritesMenu::onKeyDownHandler: " + event);
			try
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
						break;
					default:
						this.selectedIndex = 0;
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::onKeyDownHandler TRACE ---------");
				trace(e.toString());
			}
		}

		public function onKeyUpHandler(event:KeyboardEvent):*
		{
			trace("FavoritesMenu::onKeyUpHandler: " + event);
			try
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
			catch (e:Error)
			{
				trace("FavoritesMenu::onKeyUpHandler TRACE ---------");
				trace(e.toString());
			}
		}


		private function SelectItem():void
		{
			trace("FavoritesMenu::SelectItem");
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
				trace("FavoritesMenu::SelectItem TRACE ---------");
				trace(e.toString());
			}
		}


		private function onSelectionChange():void
		{
			trace("FavoritesMenu::onSelectionChange");
			try
			{
				this.ItemInfo_mc.UpdateDisplay(this.selectedEntry);
				this.ItemInfo_mc.visible = true;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu.onSelectionChange TRACE ---------");
				trace(e.toString());
				GlobalFunc.InspectObject(this.selectedEntry, true, true);
			}
		}


		private function onFavEntryMouseover(event:Event):void
		{
			trace("FavoritesMenu::onFavEntryMouseover: " + event);
			try
			{
				this.selectedIndex = event.target.entryIndex;
				this.OverEntry = true;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::onFavEntryMouseover TRACE ---------");
				trace(e.toString());
			}
		}

		private function onFavEntryMouseleave(event:Event):void
		{
			trace("FavoritesMenu::onFavEntryMouseleave: " + event);
			try
			{
				this.OverEntry = false;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::onFavEntryMouseleave TRACE ---------");
				trace(e.toString());
			}
		}


		// Uncategorized
		//---------------------------------------------

		public function isAssigningItem():Boolean
		{
			trace("FavoritesMenu::isAssigningItem()");
			try
			{
				return this.AssignedItem != null && this.AssignedItem.sName.length != 0;
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::isAssigningItem TRACE ---------");
				trace(e.toString());
				return false;
			}

			return false;
		}


		public function GetEntryClip(entryID:uint):FavoritesEntry
		{
			trace("FavoritesMenu::GetEntryClip(): " + entryID);
			var favEntry:FavoritesEntry = null;
			try
			{
				favEntry = getChildByName("Entry_" + entryID) as FavoritesEntry;
				if (favEntry == null)
				{
					GlobalFunc.TraceWarning("Could not find the entry 'Entry_" + entryID + "'!");
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::GetEntryClip TRACE ---------");
				trace(e.toString());
			}
			return favEntry;
		}


		// Properties
		//---------------------------------------------

		private var AssignedItem:Object = null;
		public function get assignedItem():Object { return this.AssignedItem; }
		public function set assignedItem(item:Object):void
		{
			trace("FavoritesMenu::assignedItem.set(): " + item.toString());
			try
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
			catch (e:Error)
			{
				trace("FavoritesMenu::assignedItem.set() TRACE ---------");
				trace(e.toString());
				GlobalFunc.InspectObject(item, true, true);
			}
		}


		private var _SelectedIndex:uint = FS_NONE;
		public function get selectedIndex():uint { return this._SelectedIndex; }
		public function set selectedIndex(value:uint):void
		{
			trace("FavoritesMenu::selectedIndex.set(): " + value);
			try
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
			catch (e:Error)
			{
				trace("FavoritesMenu::selectedIndex.set()  TRACE ---------");
				trace(e.toString());
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
				trace("FavoritesMenu::selectedEntry.get() TRACE ---------");
				trace(e.toString());
				return null;
			}
			return null;
		}


		public function get selectionSound():String
		{
			var value:String = "";
			try
			{
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
						break;
					default:
						value = "UIMenuQuickUseFocusDpadC";
				}
			}
			catch (e:Error)
			{
				trace("FavoritesMenu::selectionSound.get() TRACE ---------");
				trace(e.toString());
			}
			return value;
		}


	}
}
