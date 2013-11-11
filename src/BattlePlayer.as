package {
	/**
	 * @author ethanis
	 */
	public class BattlePlayer extends BattleCharacter {
		var data:PlayerData = null;
		
		public function BattlePlayer(playerData:PlayerData):void {
			data = playerData;
			super(playerData.currentHealth, playerData.maxHealth);
		}
		
		override public function getAttackStat():Number {
			return this.attackStat + (data.currentWeapon() != null ? data.currentWeapon().attack : 0);
		}
		
		override public function getDefenseStat():Number {
			return this.defenseStat + (data.currentWeapon() != null ? data.currentWeapon().defense : 0);
		}
		override public function attack(opponent:BattleCharacter): Number {
			var damageAmount:int = super.attack(opponent);
			
			if (data.currentWeapon() && data.currentWeapon().buffs["hit"]) {
				var i = data.currentWeapon().buffs["hit"];
				var b:Buff = Weapon.BUFF_LIST[i];
				opponent.applyBuff(b.tag, i, b.numTurns);
			}
			return damageAmount;
		}
		
		// commit changes made to player data during battle
		public function updatePlayerData():void {
			data.currentHealth = this.currentHealth;
		}
	}
}
