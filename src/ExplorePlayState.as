package
{
	import org.flixel.*;
	
	public class ExplorePlayState extends FlxState
	{
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:Player;
		
		public function ExplorePlayState()
		{
			_spawners = new FlxGroup();
			_enemies = new FlxGroup();
			_player = new Player();
			var spawner:EnemySpawner = new EnemySpawner(200,200,_enemies,_player);
			_spawners.add(spawner);
			add(_spawners);
			add(_enemies);
			add(_player);
			add(new FlxText(0,0,100,"Explore State"));
		}
	}
}