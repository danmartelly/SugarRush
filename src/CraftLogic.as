package
{
	
	public class CraftLogic
	{
		
		private static const probSpecial:Number = .6; // Probability of getting a special when not dealing with same-type candies
		private static const probDoubleSpecial:Number = .1; // Probability of that special being a dual-color special
		
		//private static const maxAttack:int = 5;
		
		private static const adjectives:Array = ['Sweet', 'Hot', 'Sour', 'Bitter', 'Salty', 'Juicy', 'Dreamy', 'Sugary', 'Tasty'];
		public static const weaponTypes:Array = ["Axe", "Scythe", "Star", "Sword"];
		public static const weaponMods:Array = ["Cane", "Chocolate", "Cotton", "Gumdrop", "Marsh"];
		
		/*
		 * Takes an array of exactly 3 ints corresponding to candy numbers and returns a Weapon
		 */
		public static function craft(cauldron:Array):Weapon
		{
			var first:int = cauldron[(int)(3 * Math.random())] + 1;
			var second:int = cauldron[(int)(3 * Math.random())] + 1;
			var roll:Number = Math.random();
			
			var buff:int = 0;
			if (roll < probDoubleSpecial)
			{
				if (first == second)
				{
					buff = first + 3; // corresponds to the specials of double of a certain color
				}
				else
				{
					buff = first + second + 4; // corresponds to the specials of mixed colors
				}
			}
			else if (roll < probSpecial)
			{
				buff = first;
			}
			var adjective:String = adjectives[(int)(adjectives.length * Math.random())];
			var weaponType:String = weaponTypes[(int)(weaponTypes.length * Math.random())];
			var weaponMod:String = weaponMods[(int)(weaponMods.length * Math.random())];
			var attack:int = .1 / Math.random() + 1;
			var defense:int = .1 / Math.random();
			return new Weapon(weaponType, weaponMod, attack, defense, buff);
		}
	}
}
