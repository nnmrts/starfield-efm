package FavoritesMenu
{
	public class FavoritesDataItem
	{
		public var sName:String;
		public var uCount:uint;
		public var sAmmoName:String;
		public var uAmmoCount:uint;
		public var iconImage:IconImage;
		public var bIsEquippable:Boolean;
		public var bIsEquipped:Boolean;
		public var bIsPower:Boolean;
		public var aElementalStats:Vector.<ElementalStats>;

		public static function From(data:*):FavoritesDataItem
		{
			var type:FavoritesDataItem = new FavoritesDataItem();
			type.sName = data.sName;
			type.uCount = data.uCount;
			type.sAmmoName = data.sAmmoName;
			type.uAmmoCount = data.uAmmoCount;
			type.iconImage = IconImage.From(data.iconImage);
			type.bIsEquippable = data.bIsEquippable;
			type.bIsEquipped = data.bIsEquipped;
			type.bIsPower = data.bIsPower;
			type.aElementalStats = ElementalStats.FromArray(data.aElementalStats);
			return type;
		}

		public static function FromArray(array:*):Vector.<FavoritesDataItem>
		{
			var vector:Vector.<FavoritesDataItem> = new Vector.<FavoritesDataItem>();
			for each(var element:* in array)
			{
				vector.push(FavoritesDataItem.From(element));
			}
			return vector;
		}

	}
}
