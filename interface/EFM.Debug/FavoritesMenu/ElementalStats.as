package FavoritesMenu
{
	public class ElementalStats
	{
		public var iElementalType:int;
		public var fValue:Number;

		public static function From(data:*):ElementalStats
		{
			var type:ElementalStats = new ElementalStats();
			type.iElementalType = data.iElementalType;
			type.fValue = data.fValue;
			return type;
		}

		public static function FromArray(array:*):Vector.<ElementalStats>
		{
			var vector:Vector.<ElementalStats> = new Vector.<ElementalStats>();
			for each(var element:* in array)
			{
				vector.push(ElementalStats.From(element));
			}
			return vector;
		}

	}
}
