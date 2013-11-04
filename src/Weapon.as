package {
	/**
	 * @author ethanis
	 */
	public class Weapon {
		var attack:Number = 1;
		var defense:Number = 1;
		var name:String = "";
		var special:Array = [];
		
		public const NO_SPECIAL:Number = 0;
		public const BURN_SPECIAL:Number = 1;
		public const FREEZE_SPECIAL:Number = 2;
		
		public function Weapon(name:String, attack:Number=1, defense:Number=1, special:Array = null){
			this.name = name;
			this.attack = attack;
			this.defense = defense;
			if (special)
				this.special = special;
		}
	}
}