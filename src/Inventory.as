package {
	public class Inventory {
		public static var weapons:Array = [];
		private static var reds:Number = 0;
		private static var blues:Number = 0;
		private static var whites:Number = 0;
		
		public static const COLOR_RED:int = 0;
		public static const COLOR_BLUE:int = 1;
		public static const COLOR_WHITE:int = 2;

		public static function resetInventory():void {
			weapons = new Array();
			reds = 0;
			blues = 0;
			whites = 0;
		}
		
		public static function addWeapon(weapon:Weapon):void {
			if (weapons.length == 5) {
				weapons.shift();
			}
			
			weapons.push(weapon);
		}
		
		public static function removeWeaponAt(index:int):void {
			weapons.splice(index, 1);
		}
		
		public static function getWeapons():Array {
			return weapons;
		}
		
		public static function weaponCount():Number {
			return weapons.length;
		}
		
		public static function addCandy(color:int):void {
			switch(color) {
				case COLOR_RED:
					if (reds != 99) {reds += 1;}
					break;
				case COLOR_BLUE:
					if (blues != 99) {blues += 1;}
					break;
				case COLOR_WHITE:
					if (whites != 99) {whites += 1;}
					break;
				default:
					break;
			}
		}
		
		public static function removeCandy(color:int):Boolean {
			switch(color) {
				case COLOR_RED:
					if (reds != 0) {
						reds -= 1;
						return true
					} else {
						return false;
					}
					break;
				case COLOR_BLUE:
					if (blues != 0) {
						blues -= 1;
						return true
					} else {
						return false;
					}
					break;
				case COLOR_WHITE:
					if (whites != 0) {
						whites -= 1;
						return true
					} else {
						return false;
					}
					break;
				default:
					return false;
			}
		}
		
		public static function candyCount(color:int):Number {
			switch(color) {
				case COLOR_RED:
					return reds;
				case COLOR_BLUE:
					return blues;
				case COLOR_WHITE:
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
