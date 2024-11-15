package FavoritesMenu
{
	public class IconImage
	{
		public var sImageName:String;
		public var sDirectory:String;
		public var iFixtureType:int;

		public static function From(data:*):IconImage
		{
			var type:IconImage = new IconImage();
			type.sImageName = data.sImageName;
			type.sDirectory = data.sDirectory;
			type.iFixtureType = data.iFixtureType;
			return type;
		}

	}
}
