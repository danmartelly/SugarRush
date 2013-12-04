package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class EnemySpawner extends FlxSprite
	{
		private var _timer:Number;
		private var _enemies:FlxGroup;
		private var _chests:FlxGroup;
		private var _player:ExplorePlayer;
		private var _enemiesFromThisSpawner:Array;
		public var spawnRate:Number = 3;
		public var totalEnemies:Number = 3;
		
		private const enemyDifficulty:int = 1;
		
		public function EnemySpawner(X:Number, Y:Number, enemyGroup:FlxGroup, chests:FlxGroup, player:ExplorePlayer)
		{
			_enemies = enemyGroup;
			_chests = chests;
			_enemiesFromThisSpawner = new Array();
			_timer = Math.random()*spawnRate;
			_player = player;
			super(X, Y);
			loadGraphic(Sources.Portal, false, false, this.x, this.y);
		}
		
		override public function update():void {
			_timer += FlxG.elapsed;
			if (_timer > spawnRate) {
				// clean up the _enemiesFromThisSpawner array
//				for(var i=0 ; i < _enemiesFromThisSpawner.length ; i++) {
//					var enemy:ExploreEnemy = _enemiesFromThisSpawner[i];
//					if (enemy == null || enemy.enemyData.currentHealth <= 0) {
//						// get rid of the reference by putting enemy at the end of array in its place and then popping
//						_enemiesFromThisSpawner[i] = _enemiesFromThisSpawner[_enemiesFromThisSpawner.length-1];
//						_enemiesFromThisSpawner.pop();
//					}
//				}
				
				if (_enemiesFromThisSpawner.length < totalEnemies) {
					_timer = 0;
					spawnEnemy();	
				}
			}
		}
		
		private function spawnEnemy():void {
			var enemy:ExploreEnemy = new ExploreEnemy(this.x, this.y, 
				BattleEnemy.randomBattleEnemy(enemyDifficulty), _enemies, _chests, _player);
			_enemiesFromThisSpawner.push(enemy);
			_enemies.add(enemy);
		}
	}
}