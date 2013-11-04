package {
	/**
	 * @author ethanis
	 */
	public class BattlePlayer extends BattleCharacter {
		var currentWeapon:Weapon = null;
		
		public function BattlePlayer(currentHealth:Number, maxHealth:Number):void {
			super(currentHealth, maxHealth);
		}
		
		override public function getAttackStat():Number {
			return this.attackStatModifier + (this.currentWeapon != null ? this.currentWeapon.attack : 0);
		}
		
		override public function getDefenseStat():Number {
			return this.defenseStatModifier + (this.currentWeapon != null ? this.currentWeapon.defense : 0);
		}
	}
}
