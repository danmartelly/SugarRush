package {
	/**
	 * @author ethanis
	 */
	public class Weapon {
		var attack:int = 1;
		var defense:int = 0;
		var name:String = "";

		var special:Number = 0;
		
		public const NO_SPECIAL:int = 0;
		public const BURN_SPECIAL:int = 1;
		public const FREEZE_SPECIAL:int = 2;
		

		public function Weapon(name:String, attack:int=1, defense:int=0, special:Number = 0){
			this.name = name;
			this.attack = attack;
			this.defense = defense;
			this.special = special;
		}
	}
}