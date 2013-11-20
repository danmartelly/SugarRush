package {
	/**
	 * @author ethanis
	 */
	public class BattleEnemy extends BattleCharacter {
		public var name:String;
		
		public function BattleEnemy(currentHealth:Number, maxHealth:Number, enemyData:EnemyData):void {
			super(currentHealth, maxHealth);
			this.name = enemyData.name;
		}
	}
}
