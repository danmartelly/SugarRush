package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class EnemySpawner extends FlxSprite
	{
		private var _timer:Number;
		private var _enemies:FlxGroup;
		private var _player:ExplorePlayer;
		public var spawnRate:Number = 3;
		public var maxEnemy:Number = 30;
		public var enemyCount:Number = 1;
		
		public function EnemySpawner(X:Number, Y:Number, enemyGroup:FlxGroup, player:ExplorePlayer)
		{
			_enemies = enemyGroup;
			_timer = 0;
			_player = player;
			super(X, Y);
			makeGraphic(10,12,0xffaa1111);
		}
		
		override public function update():void {
			_timer += FlxG.elapsed;
			if (_timer > spawnRate && enemyCount <= maxEnemy) {
				_timer = 0;
				enemyCount++;
				spawnEnemy();
			}
		}
		
		private function spawnEnemy():void {
			var enemyCount:int = Sources.enemyNames.length;
			var enemyIndex:int = Math.floor(Math.random()*enemyCount);
			var enemyType:String = Sources.enemyNames[enemyIndex]
			_enemies.add(new ExploreEnemy(this.x, this.y, enemyType, _enemies, _player));
		}
	}
}