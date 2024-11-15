package FavoritesMenu
{
	public class FavoritesData
	{
		public var uStartingSelection:uint;
		public var ItemToBeAssigned:FavoritesDataItem;
		public var aFavoriteItems:Vector.<FavoritesDataItem>;

		public static function From(data:*):FavoritesData
		{
			var type:FavoritesData = new FavoritesData();
			type.uStartingSelection = data.uStartingSelection;
			type.ItemToBeAssigned = FavoritesDataItem.From(data.ItemToBeAssigned);
			type.aFavoriteItems = FavoritesDataItem.FromArray(data.aFavoriteItems);
			return type;
		}

	}
}
