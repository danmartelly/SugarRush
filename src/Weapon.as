package {
	/**
	 * @author ethanis
	 */
	public class Weapon {
		var attack:Number = 1;
		var defense:Number = 1;
		var name:String = "";
		var special:Number = 0;
		
		public const NO_SPECIAL:Number = 0;
		public const BURN_SPECIAL:Number = 1;
		public const FREEZE_SPECIAL:Number = 2;
		
		public function Weapon(name:String, attack:Number=1, defense:Number=1, special:Number=0){
			this.name = name;
			this.attack = attack;
			this.defense = defense;
			this.special = special;
		}
	}
}
