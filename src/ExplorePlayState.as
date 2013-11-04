package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	public class ExplorePlayState extends FlxState
	{
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:Player;
		
		public var pause:PauseState
		
		override public function create(): void
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
			
			pause = new PauseState();
		}
		
		override public function update():void
		{
			if (!pause.showing){
				super.update();
				if (FlxG.keys.P){
					pause = new PauseState;
					pause.showPaused();
					add(pause);
				}
				//rest of updates
				
			} else {
				pause.update();
			}
		}
	}
}