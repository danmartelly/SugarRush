package {
	/**
	 * @author ethanis
	 */
	 
	public class BattleLogic {
		var turn:int = 0;
		public var player:BattlePlayer = new BattlePlayer(PlayerData.instance);
		var enemy:BattleEnemy = new BattleEnemy(5, 5);
		var state:BattlePlayState;
		
		public function BattleLogic(state:BattlePlayState){
			this.state = state;
		}
		
		public function useRun():void {
			this.state.endBattleCallback(RAN_AWAY);
		}
		
		public function useAttack():void {
			player.attack(enemy);
			this.state.healthCallback();
			endTurn();
		}
		
		// couldn't name it just switch() because it's a reserved word
		public function switchWeaponIndex(index:int):void {
			player.data.currentWeaponIndex = index;
			var weapon:Weapon = player.data.currentWeapon();
			
			player.removeAllBuffs(); //this is suspect but will work as long as we don't add more weapons
			if (weapon.buffs["equip"]) {
				for (var i in weapon.buffs["equip"]) {
					var b:Buff = Weapon.BUFF_LIST[i];
					player.applyBuff(b.tag, i, b.numTurns);
				}
			}
		}
		
		public function useCandy():void {
			player.heal(5);
			this.state.showHealth();
			this.state.healthCallback();
			endTurn();
		}
		
		private function endTurn():void {
			turn = (turn + 1) % 2;
			
			if (player.isDead) {
				this.state.endBattleCallback(ENEMY_WON);
			}else if (enemy.isDead) {
				this.state.endBattleCallback(PLAYER_WON);
			} else {
				this.state.turnCallback(turn);
			}
			
			if (turn == ENEMY_TURN){
				enemy.attack(player);
				this.state.healthCallback();
				endTurn();
			}
		}
		
		// WALTER, USE THESE
		public function playerHealthPercent():Number {
			return player.getHealthAsPercent();
		}
		
		public function enemyHealthPercent():Number {
			return enemy.getHealthAsPercent();
		}
		
		
		// if your turn
		public static const PLAYER_TURN:int = 0;
		// if enemy's turn
		public static const ENEMY_TURN:int = 1;
		
		// reasons for battle ending
		public static const PLAYER_WON:int = 0;
		public static const ENEMY_WON:int = 1;
		public static const RAN_AWAY:int = 2;
	}	
}
