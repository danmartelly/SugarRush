package {
	public class Inventory {
		public static var weapons:Array = [];
		private static var reds:Number = 0;
		private static var blues:Number = 0;
		private static var whites:Number = 0;

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
		
		public static function addCandy(color:Number):void {
			switch(color) {
				case 0:
					if (reds != 99) {reds += 1;}
					break;
				case 1:
					if (blues != 99) {blues += 1;}
					break;
				case 2:
					if (whites != 99) {whites += 1;}
					break;
				default:
					break;
			}
		}
		
		public static function removeCandy(color:Number):void {
			switch(color) {
				case 0:
					if (reds != 0) {reds -= 1;}
					break;
				case 1:
					if (blues != 0) {blues -= 1;}
					break;
				case 2:
					if (whites != 0) {whites -= 1;}
					break;
				default:
					break;
			}
		}
		
		public static function candyCount(color:Number):Number {
			switch(color) {
				case 0:
					return reds;
				case 1:
					return blues;
				case 2:
					return whites;
				default:
					return 0;
			}
		}
		public static function hasCandy():Boolean {
			if (reds == 0 && blues == 0 && whites == 0){
				return false;
			}
			return true;
		}
	}
}
