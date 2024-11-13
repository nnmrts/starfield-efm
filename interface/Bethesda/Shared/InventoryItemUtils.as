package Shared
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class InventoryItemUtils
	{
		public static const IIT_WEAPON:int = EnumHelper.GetEnum(0);

		public static const IIT_ARMOR:int = EnumHelper.GetEnum();

		public static const IIT_CONSUMABLE:int = EnumHelper.GetEnum();

		public static const IIT_SPELL:int = EnumHelper.GetEnum();

		public static const IIT_MISC:int = EnumHelper.GetEnum();

		public static const IIT_COUNT:int = EnumHelper.GetEnum();

		public static const ET_PHYSICAL:int = EnumHelper.GetEnum(0);

		public static const ET_ELECTRIC:int = EnumHelper.GetEnum();

		public static const ET_ELECTROMAGNETIC:int = EnumHelper.GetEnum();

		public static const ET_ENERGY:int = EnumHelper.GetEnum();

		public static const ET_COUNT:int = EnumHelper.GetEnum();

		public static const ET_ITEM_CARD_COUNT:int = ET_COUNT - 1;

		public static const ICF_NONE:int = 0;

		public static const ICF_NEW_ITEMS:int = 1 << EnumHelper.GetEnum(0);

		public static const ICF_WEAPONS:int = 1 << EnumHelper.GetEnum();

		public static const ICF_AMMO:int = 1 << EnumHelper.GetEnum();

		public static const ICF_SPACESUITS:int = 1 << EnumHelper.GetEnum();

		public static const ICF_BACKPACKS:int = 1 << EnumHelper.GetEnum();

		public static const ICF_HELMETS:int = 1 << EnumHelper.GetEnum();

		public static const ICF_APPAREL:int = 1 << EnumHelper.GetEnum();

		public static const ICF_THROWABLES:int = 1 << EnumHelper.GetEnum();

		public static const ICF_AID:int = 1 << EnumHelper.GetEnum();

		public static const ICF_NOTES:int = 1 << EnumHelper.GetEnum();

		public static const ICF_RESOURCES:int = 1 << EnumHelper.GetEnum();

		public static const ICF_SPELLS:int = 1 << EnumHelper.GetEnum();

		public static const ICF_MISC:int = 1 << EnumHelper.GetEnum();

		public static const ICF_FAVORITES:int = 1 << EnumHelper.GetEnum();

		public static const ICF_BUY_BACK:int = 1 << EnumHelper.GetEnum();

		public static const ICF_COUNT:int = EnumHelper.GetEnum();

		public static const ICF_ALL:int = 4294967295;

		public static const ICF_ALL_BUT_SPELLS:* = ICF_ALL ^ ICF_SPELLS;

		public static const CM_NONE:* = 0;

		public static const CM_GIVE_ITEMS:* = 1 << 0;

		public static const CM_TAKE_ITEMS:* = 1 << 1;

		public static const CM_BOTH:* = CM_GIVE_ITEMS | CM_TAKE_ITEMS;

		public static const RARITY_STANDARD:int = EnumHelper.GetEnum(0);

		public static const RARITY_RARE:int = EnumHelper.GetEnum();

		public static const RARITY_EPIC:int = EnumHelper.GetEnum();

		public static const RARITY_LEGENDARY:int = EnumHelper.GetEnum();

		public static const TYPE_NAME_WEAPON:String = "weapon";

		public static const TYPE_NAME_ARMOR:String = "armor";

		public static const TYPE_NAME_CONSUMABLE:String = "consumable";

		public static const TYPE_NAME_MISC:String = "misc";

		public static const SORT_NONE:int = EnumHelper.GetEnum(0);

		public static const SORT_NAME:int = EnumHelper.GetEnum();

		public static const SORT_KEY_STAT:int = EnumHelper.GetEnum();

		public static const SORT_VALUE:int = EnumHelper.GetEnum();

		public static const SORT_WEIGHT:int = EnumHelper.GetEnum();

		public static const SORT_TYPE:int = EnumHelper.GetEnum();

		public static const SORT_AMMO:int = EnumHelper.GetEnum();

		public static const SELECTED_TAB:String = "#EDEDED";

		public static const INVENTORY_TITLE_BUTTON_SPACING:Number = 8;

		public function InventoryItemUtils()
		{
			super();
		}

		public static function GetTypeName(itemType:int):String
		{
			switch (itemType)
			{
				case IIT_WEAPON:
					return TYPE_NAME_WEAPON;
				case IIT_ARMOR:
					return TYPE_NAME_ARMOR;
				case IIT_CONSUMABLE:
					return TYPE_NAME_CONSUMABLE;
				case IIT_MISC:
				default:
					return TYPE_NAME_MISC;
			}
		}

		public static function GetElementalLocString(elementType:int):String
		{
			switch (elementType)
			{
				case ET_PHYSICAL:
					return "$ABBREVIATED_PHYSICAL";
				case ET_ELECTRIC:
					return "$ABBREVIATED_ELECTRIC";
				case ET_ELECTROMAGNETIC:
					return "$ABBREVIATED_ELECTROMAGNETIC";
				case ET_ENERGY:
					return "$ABBREVIATED_ENERGY";
				default:
					return "[invalid]";
			}
		}

		public static function GetElementalLabel(elementType:int):String
		{
			switch (elementType)
			{
				case ET_PHYSICAL:
					return "physical";
				case ET_ELECTROMAGNETIC:
					return "em";
				case ET_ENERGY:
					return "energy";
				default:
					return "[invalid]";
			}
		}

		public static function GetElementByItemCardSortOrder(sortOrder:int):int
		{
			switch (sortOrder)
			{
				case 0:
					return ET_PHYSICAL;
				case 1:
					return ET_ENERGY;
				case 2:
					return ET_ELECTROMAGNETIC;
				default:
					return ET_ELECTRIC;
			}
		}

		public static function GetElementItemCardSortOrder(elementType:int):int
		{
			switch (elementType)
			{
				case ET_PHYSICAL:
					return 0;
				case ET_ENERGY:
					return 1;
				case ET_ELECTROMAGNETIC:
					return 2;
				default:
					return 3;
			}
		}

		public static function GetFrameLabelFromRarity(rarity:int):String
		{
			var frameLabel:String = "";
			switch (rarity)
			{
				case InventoryItemUtils.RARITY_RARE:
					frameLabel = "Rare";
					break;
				case InventoryItemUtils.RARITY_EPIC:
					frameLabel = "Epic";
					break;
				case InventoryItemUtils.RARITY_LEGENDARY:
					frameLabel = "Legendary";
					break;
				default:
					frameLabel = "Normal";
			}
			return frameLabel;
		}

		public static function CreateCompareArrayForElemStats(currentStats:Object, comparisonStats:Object):Array
		{
			var currentStat:* = undefined;
			var comparisonStat:* = undefined;
			var resultArray:Array = new Array();
			var elementIndex:uint = 0;
			while (elementIndex < InventoryItemUtils.ET_COUNT)
			{
				resultArray[elementIndex] = 0;
				elementIndex++;
			}
			for each (currentStat in currentStats.aElementalStats)
			{
				resultArray[GetElementItemCardSortOrder(currentStat.iElementalType)] = currentStat.fValue;
			}
			if (comparisonStats != null)
			{
				for each (comparisonStat in comparisonStats.aElementalStats)
				{
					resultArray[GetElementItemCardSortOrder(comparisonStat.iElementalType)] = resultArray[GetElementItemCardSortOrder(comparisonStat.iElementalType)] - comparisonStat.fValue;
				}
			}
			return resultArray;
		}

		public static function RetrieveModsToDisplay(mods:Array):Array
		{
			var mod:* = undefined;
			var displayMods:Array = new Array();
			if (mods != null)
			{
				for each (mod in mods)
				{
					displayMods.push(mod);
				}
			}
			return displayMods;
		}

		public static function GetNonLegendaryModCount(mods:Array):uint
		{
			var mod:* = undefined;
			var count:uint = 0;
			if (mods != null)
			{
				for each (mod in mods)
				{
					if (!mod.bLegendary)
					{
						count++;
					}
				}
			}
			return count;
		}

		public static function BuildModDescriptionString(mods:Array, textField:TextField = null):String
		{
			var mod:* = undefined;
			var modIndex:int = 0;
			var additionalText:String = null;
			var lineMetrics:* = undefined;
			var lineHeight:Number = NaN;
			var maxVisibleLines:int = 0;
			var remainingMods:int = 0;
			var legendaryDesc:String = "";
			var standardMods:Array = new Array();
			if (mods != null)
			{
				for each (mod in mods)
				{
					if (mod.bLegendary)
					{
						if (legendaryDesc.length > 0)
						{
							legendaryDesc += "\n\n";
						}
						legendaryDesc += mod.sName;
						legendaryDesc += ": " + mod.sDescription;
					}
					else
					{
						standardMods.push("• " + mod.sName);
					}
				}
			}
			var fullDescription:String = legendaryDesc;
			if (standardMods.length > 0)
			{
				if (legendaryDesc.length > 0)
				{
					fullDescription += "\n\n";
				}
				modIndex = 0;
				if (textField)
				{
					GlobalFunc.SetText(textField, "$Additional");
					additionalText = textField.text;
					GlobalFunc.SetText(textField, fullDescription);
					lineMetrics = textField.getLineMetrics(0);
					lineHeight = (textField.height - textField.textHeight) / lineMetrics.height;
					maxVisibleLines = (textField.height - textField.textHeight) / lineMetrics.height;
					if (maxVisibleLines < standardMods.length)
					{
						maxVisibleLines--;
					}
					modIndex = 0;
					while (modIndex < standardMods.length && modIndex < maxVisibleLines)
					{
						if (modIndex > 0)
						{
							fullDescription += "\n";
						}
						fullDescription += standardMods[modIndex];
						modIndex++;
					}
					remainingMods = standardMods.length - modIndex;
					if (remainingMods == 1)
					{
						fullDescription += "\n- 1 " + additionalText + " $$Mod";
					}
					else if (remainingMods > 0)
					{
						fullDescription += "\n- " + String(remainingMods) + " " + additionalText + " $$Mods";
					}
				}
				else
				{
					modIndex = 0;
					while (modIndex < standardMods.length)
					{
						if (modIndex > 0)
						{
							fullDescription += "\n";
						}
						fullDescription += standardMods[modIndex];
						modIndex++;
					}
				}
			}
			return fullDescription;
		}

		public static function ArrangeContainerTitleText(titleText:TextField, buttonClip:MovieClip, textLabels:Array, selectedIndex:uint):*
		{
			var i:uint = 0;
			if (titleText.parent != buttonClip.parent)
			{
				GlobalFunc.TraceWarning("ArrangeContainerTitleText: aText and aButton do not have the same parent and may not align correctly");
			}
			var displayLabels:Array = new Array();
			var selectedPosition:uint = uint.MAX_VALUE;
			i = 0;
			while (i < textLabels.length)
			{
				if (textLabels[i] != "")
				{
					GlobalFunc.SetText(titleText, textLabels[i]);
					if (selectedIndex == i)
					{
						selectedPosition = displayLabels.length;
					}
					displayLabels.push(titleText.text);
				}
				i++;
			}
			var finalText:String = "";
			i = 0;
			while (i < displayLabels.length)
			{
				if (i == selectedPosition)
				{
					finalText += "<font color=\"" + SELECTED_TAB + "\">";
				}
				finalText += displayLabels[i].toUpperCase();
				if (i == selectedPosition)
				{
					finalText += "</font>";
				}
				if (i < displayLabels.length - 1)
				{
					finalText += " | ";
				}
				i++;
			}
			GlobalFunc.SetText(titleText, finalText, true);
			buttonClip.visible = displayLabels.length > 1;
			buttonClip.x = titleText.x + titleText.textWidth + INVENTORY_TITLE_BUTTON_SPACING;
		}
	}
}
