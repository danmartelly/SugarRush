package {
	/**
	 * @author ethanis
	 */
	public class BattleEnemy extends BattleCharacter {
		public var name:String;
		public var difficulty:Number;
		
		public function BattleEnemy(enemyData:EnemyData):void {
			super(enemyData.currentHealth, enemyData.maxHealth);
			this.name = enemyData.name;
			this.difficulty = enemyData.difficulty;
		}
	}
}
