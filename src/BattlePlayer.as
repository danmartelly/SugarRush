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
			return this.attackStat + (this.currentWeapon != null ? this.currentWeapon.attack : 0);
		}
		
		override public function getDefenseStat():Number {
			return this.defenseStat + (this.currentWeapon != null ? this.currentWeapon.defense : 0);
		}
		override public function attack(opponent:BattleCharacter): Number {
			var damageAmount = super.attack(opponent);
			
			if (currentWeapon) {
				//opponent.applyBuff(currentWeapon);
			}
			return damageAmount;
		}
	}
}
