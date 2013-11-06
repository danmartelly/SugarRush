package {
	 
	public class CraftLogic {
		
		/*
		 * Takes an array of exactly 3 Candies and returns a Weapon
		 */
		public static function craft(cauldron:Array): Weapon {
			var first:Candy = cauldron[3*(int)(Math.random())];
			var second:Candy = cauldron[3 * (int)(Math.random())];
			
			if (first.getColor == second.getColor) {
				// double
			} else {
				
			}
			return new Weapon("test", 1, 0, null);
		}
	}
}
