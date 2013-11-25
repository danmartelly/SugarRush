package
{
	public class EnemyData
	{	
		public var currentHealth:int;
		public var maxHealth:int;
		public var name:String;
		public var difficulty:Number;
		
		public function EnemyData(maxHealth:int, name:String, difficulty:Number = 1) {
			this.maxHealth = maxHealth;
			this.currentHealth = this.maxHealth;
			this.name = name;
			this.difficulty = difficulty;
		}
		
		public static function randomEnemyData(maxHealth:int):EnemyData {
			var enemyCount:int = Sources.enemyNames.length;
			var enemyIndex:int = Math.floor(Math.random()*enemyCount);
			var enemyType:String = Sources.enemyNames[enemyIndex];
			return new EnemyData(maxHealth, enemyType, enemyIndex);
		}
		
		public function hasDied():Boolean {
			return currentHealth <= 0;
		}
		
		public function exploreAsset():Class {
			return Sources.enemyExploreSpriteMap[this.name];
		}
		
		public function battleAsset():Class {
			return Sources.enemyBattleSpriteMap[this.name];
		}
	}
}