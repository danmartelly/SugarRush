package {
	/**
	 * @author ethanis
	 */
	public class BattleEnemy extends BattleCharacter {
		public var name:String;
		public var difficulty:Number;
		
		public function BattleEnemy(currentHealth:Number, maxHealth:Number, enemyData:EnemyData):void {
			super(currentHealth, maxHealth);
			this.name = enemyData.name;
			this.difficulty = enemyData.difficulty;
			switch (this.difficulty) {
				case 1 :
					this.attackStat = 0;
				case 2 :
					this.attackStat = 1;
					break;
				case 3 :
					this.attackStat = 2;
					break;
				case 4 :
					this.attackStat = 5/2;
					break;
				default :
					this.attackStat = 0;
					break;
			}
		}
	}
}
