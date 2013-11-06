package {
	/**
	 * @author ethanis
	 */
	 
	public class BattleLogic {
		var turn:int = 0;
		var player:BattlePlayer = new BattlePlayer(10, 10);
		var enemy:BattleEnemy = new BattleEnemy(5, 5);
		var state:BattlePlayState;
//		var healthCallback:Function; // tell the battle ui when player/enemy health changes
//		var turnCallback:Function; // tell the battle ui when the turn changes
//		var attackCallback:Function; // tell the battle ui when the player or oppontent attacked
//		var endBattleCallback:Function; // tell the battle ui when the battle ends
		
		public function BattleLogic(state){
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
		public function switchWeapon(weapon:Weapon):void {
			player.currentWeapon = weapon;
		}
		
		public function useCandy():void {
			player.heal(5);
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
