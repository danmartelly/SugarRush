package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxRect;
	
	public class ExplorePlayState extends FlxState
	{
		private static var _instance:ExplorePlayState;
		
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:ExplorePlayer;
		
		public var pause:PauseState;
		public var battle:BattlePlayState;
		
		public var levelX:Number = 1200;
		public var levelY:Number = 800;
		
				// Follows the Singleton design pattern
		public function ExplorePlayState(lock:SingletonLock)
		{
		}
		
		public static function get instance():ExplorePlayState {
			if (_instance == null) {
				_instance = new ExplorePlayState(new SingletonLock());
			}
			return _instance;
		}
			
		
		override public function create(): void
		{
			_spawners = new FlxGroup();
			_enemies = new FlxGroup();
			_player = new ExplorePlayer();
			var spawner:EnemySpawner = new EnemySpawner(200,200,_enemies,_player);
			_spawners.add(spawner);
			add(_spawners);
			add(_enemies);
			add(_player);
			add(new FlxText(0,0,100,"Explore State"));
			
			pause = new PauseState();
			

			FlxG.camera.setBounds(0, 0, levelX, levelY);

			FlxG.worldBounds = new FlxRect(0, 0, levelX, levelY);
			
			FlxG.camera.follow(_player);
		}
		
		override public function update():void
		{
			if (!pause.showing){
				super.update();
				
				if (FlxG.keys.P){
					pause = new PauseState;
					pause.showPaused();
					add(pause);
				} else if (FlxG.keys.B){
					battle = new BattlePlayState();
					FlxG.switchState(battle);
				}
			} else {
				pause.update();
			}
		}
	}
}

class SingletonLock{}