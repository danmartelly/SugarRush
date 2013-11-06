package
{
	
	public class CraftLogic
	{
		
		private static const probSpecial:Number = .6; // Probability of getting a special when not dealing with same-type candies
		private static const probDoubleSpecial:Number = .1; // Probability of that special being a dual-color special
		
		//private static const maxAttack:int = 5;
		
		private static const adjectives:Array = ['Sweet', 'Hot', 'Sour', 'Bitter', 'Salty', 'Juicy', 'Dreamy', 'Sugary', 'Tasty'];
		private static const candyTypes:Array = ['Candy Cane', 'Jelly Bean', 'Gummy Bear', 'Jawbreaker', 'Cotton Candy', 'Chocolate', 'Licorice', 'Gumdrops', 'Marshmallow'];
		private static const weaponTypes:Array = ['Wand', 'Dagger', 'Gun', 'Sword', 'Nunchucks', 'Ninja Stars', 'Axe', 'Spoon', 'Scythe'];
		
		/*
		 * Takes an array of exactly 3 Candies and returns a Weapon
		 */
		public static function craft(cauldron:Array):Weapon
		{
			var first:int = cauldron[(int)(3 * Math.random())].getColorNumber();
			var second:int = cauldron[(int)(3 * Math.random())].getColorNumber();
			var roll:Number = Math.random();
			
			var buff:int = 0;
			if (first == second)
			{
				if (roll < probDoubleSpecial)
				{
					
				}
				else if (roll < probSpecial)
				{
					buff = first;
				}
			}
			else
			{
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
			}
			var adjective:String = adjectives[(int)(adjectives.length * Math.random())]
			var candyType:String = candyTypes[(int)(candyTypes.length * Math.random())]
			var weaponType:String = weaponTypes[(int)(weaponTypes.length * Math.random())]
			var name:String = adjective + " " + candyType + " " + weaponType;
			var attack:int = .1 / Math.random() + 1;
			var defense:int = .1 / Math.random();
			
			return new Weapon(name, attack, defense, buff);
		}
	}
}
