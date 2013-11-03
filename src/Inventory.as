package {
	/**
	 * @author ethanis
	 */
	public class Inventory {
		var weapons:Array = [];
		var candies:Array = [];
		
		public function addWeapon(weapon:Weapon): void {
			weapons.push(weapon);
		}
		
		public function addCandy(candy:Candy): void {
			candies.push(candy);
		}
		
		public function candyCount(): Number {
			return candies.length;
		}
	}
}
