package Shared
{
	public class EnumHelper
	{
		private static var Counter:int = 0;

		public function EnumHelper()
		{
			super();
		}

		public static function GetEnum(enumValue:int = -2147483648):int
		{
			if (enumValue == int.MIN_VALUE)
			{
				enumValue = Counter;
			}
			else
			{
				Counter = enumValue;
			}
			++ Counter;
			return enumValue;
		}
	}
}
