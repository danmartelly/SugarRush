package
{
	
	public class Helper
	{
		public static function getCandyName(color:int):String
		{
			switch (color)
			{
				case Inventory.COLOR_RED: 
					return 'red';
				case Inventory.COLOR_BLUE: 
					return 'blue';
				case Inventory.COLOR_WHITE: 
					return 'white';
				default:
					return null;
			}
		}
	}
}