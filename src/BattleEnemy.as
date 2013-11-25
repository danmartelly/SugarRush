package {
	/**
	 * @author ethanis
	 */
	public class BattleEnemy extends BattleCharacter {
		public var name:String;
		public var difficulty:Number;
		
		public function BattleEnemy(enemyData:EnemyData, generateRandom:Boolean = true):void {
			super(enemyData.currentHealth, enemyData.maxHealth);
			
			if (generateRandom) {
				var stats:Object = generateStats(enemyData.difficulty);
				
				this.currentHealth = this.maxHealth = stats["health"];
				this.attackStat = stats["attack"];
				this.defenseStat = stats["defense"];
			}
			this.name = enemyData.name;
			this.difficulty = enemyData.difficulty;
			/*switch (this.difficulty) {
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
			}*/
		}
		public function generateStats(difficulty:int):Object {
			// generates random stats for an enemy based on difficulty

			var d1:Number = Math.random(), d2:Number = Math.random();
			if (d1 > d2) {
				var temp:Number = d1;
				d1 = d2;
				d2 = temp;
			}
			
			var attackPower:Number = difficulty * d1,
				defensePower:Number = difficulty * (d2 - d1),
				healthPower:Number = difficulty * (1. - d2);
			
			var attackValue:Number = Math.round(sampleFromNormal(attackPower * 0.7, 0.4));
			var defenseValue:Number = Math.round(sampleFromNormal(defensePower * 0.5, 0.4));
			var healthValue:Number = Math.round(sampleFromNormal(3 + 5 * healthPower, 0.33));
			
			if (attackValue < 0) attackValue = 0;
			if (defenseValue < 0) defenseValue = 0;
			if (healthValue < 3) healthValue = 3;
			
			return {"attack": attackValue, "defense": defenseValue, "health": healthValue};
		}
		public function sampleFromNormal(mean:Number, stddev:Number):Number {
			// samples from a normal distribution (hopefully?)
			// this is in order to perturb enemy values a tiny little bit
			
			var theta:Number = 2 * Math.PI * Math.random();
			var rho:Number = Math.sqrt(-2 * Math.log(1 - Math.random()));
			return mean + stddev * rho * Math.cos(theta);
		}
	}
}
