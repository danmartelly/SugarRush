package
{
	import org.flixel.*;
	
	public class ExplorePlayState extends FlxState
	{
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		
		public function ExplorePlayState()
		{
			_spawners = new FlxGroup();
			_enemies = new FlxGroup();
			var spawner:EnemySpawner = new EnemySpawner(0,0,_enemies);
			_spawners.add(spawner);
			add(_spawners);
			add(_enemies);
			add(new FlxText(0,0,100,"Explore State"));
		}
	}
}