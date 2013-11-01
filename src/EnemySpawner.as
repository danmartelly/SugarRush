package
{
	import org.flixel.*;
	
	public class EnemySpawner extends FlxSprite
	{
		private var _timer:Number;
		private var _enemies:FlxGroup;
		private var _player:Player;
		public var spawnRate:Number = 3;
		
		public function EnemySpawner(X:Number, Y:Number, enemyGroup:FlxGroup, player:Player)
		{
			_enemies = enemyGroup;
			_timer = 0;
			super(X, Y);
			makeGraphic(10,12,0xffaa1111);
		}
		
		override public function update():void {
			_timer += FlxG.elapsed;
			if (_timer > spawnRate) {
				_timer = 0;
				spawnEnemy();
			}
		}
		
		private function spawnEnemy():void {
			_enemies.add(new Enemy(this.x, this.y, _player));
		}
	}
}