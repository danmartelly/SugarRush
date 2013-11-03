package {
	/**
	 * @author ethanis
	 */
	 
	public class BattleLogic {
		var turn:Number = 0;
		
		public function useRun():void {
			
		}
		
		public function useAttack():void {
			
		}
		
		// couldn't do just switch() because it's a reserved word
		public function useSwitch():void {
			
		}
		
		public function useCandy():void {
			
		}
		
		public function endTurn():void {
			turn = (turn + 1) % 2;
		}
		
		
		// if your turn
		public static const PLAYER_TURN:Number = 1;
		// if enemy's turn
		public static const ENEMY_TURN:Number = 0;
	}	
}
