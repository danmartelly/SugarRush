package {
	public class Inventory {
		private static var weapons:Array = [];
		private static var candies:Array = [];

		public static function addWeapon(weapon:Weapon):void {
			weapons.push(weapon);
		}
		
		public static function removeWeaponAt(index:Number):void {
			weapons.splice(index, 1);
		}
		
		public static function getWeapons():Array {
			return weapons;
		}
		
		public static function weaponCount():Number {
			return weapons.length;
		}
		
		public static function addCandy(candy:Candy):void {
			candies.push(candy);
		}
		
		public static function removeCandyAt(index:Number):void {
			candies.splice(index, 1);
		}
		
		public static function getCandies():Array {
			return candies;
		}
		
		public static function candyCount():Number {
			return candies.length;
		}
	}
}
