package {
	/**
	 * @author ethanis
	 */
	 
	public class BattleLogic {
		var turn:int = 0;
		var player:BattlePlayer = new BattlePlayer(10, 10);
		var enemy:BattleEnemy = new BattleEnemy(5, 5);
		
		var healthCallback:Function; // tell the battle ui when player/enemy health changes
		var turnCallback:Function; // tell the battle ui when the turn changes
		var attackCallback:Function; // tell the battle ui when the player or oppontent attacked
		var endBattleCallback:Function; // tell the battle ui when the battle ends
		
		public function BattleLogic(healthCallback:Function, turnCallback:Function, attackCallback:Function, endBattleCallback:Function){
			this.healthCallback = healthCallback;
			this.turnCallback = turnCallback;
			this.attackCallback = attackCallback;
			this.endBattleCallback = endBattleCallback;
		}
		
		public function useRun():void {
			endBattleCallback(RAN_AWAY);
		}
		
		private function triggerHealthCallback():void {
			healthCallback(player.getHealthAsPercent(), enemy.getHealthAsPercent());
		}
		
		public function useAttack():void {
			player.attack(enemy);
			triggerHealthCallback();
			endTurn();
		}
		
		// couldn't name it just switch() because it's a reserved word
		public function switchWeapon(weapon:Weapon):void {
			player.currentWeapon = weapon;
		}
		
		public function useCandy():void {
			player.heal(5);
			triggerHealthCallback();
			endTurn();
		}
		
		public function endTurn():void {
			turn = (turn + 1) % 2;
			
			if (player.isDead) {
				endBattleCallback(ENEMY_WON);
			}else if (enemy.isDead) {
				endBattleCallback(PLAYER_WON);
			} else {
				turnCallback(turn);
			}
			
			if (turn == ENEMY_TURN){
				enemy.attack(player);
				triggerHealthCallback();
				endTurn();
			}
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
