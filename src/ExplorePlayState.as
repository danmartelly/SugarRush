package
{
	import org.flixel.*
	
	public class ExplorePlayState extends FlxState
	{		
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:ExplorePlayer;

		
		public var pause:PauseState;
		public var battle:BattlePlayState;
		
		public var levelX:Number = 1200;
		public var levelY:Number = 800;
		
		private var background:FlxBackdrop ;
		
		override public function create(): void
		{
			 
			var background:FlxSprite = new FlxSprite(0, 0, Sources.ExploreBackground);
			add(background);
			_spawners = new FlxGroup();
			_enemies = new FlxGroup();
			_player = new ExplorePlayer();
			var spawner:EnemySpawner = new EnemySpawner(200, 200, _enemies, _player);
			var craftButton:FlxButton = new FlxButton(350, 410, "CRAFT", triggerCraftingState);
			_spawners.add(spawner);
			add(_spawners);
			add(_enemies);
			add(_player);
			add(craftButton);
			
			
			
			add(new FlxText(0,0,100,"Explore State"));
			add(new ExploreHUD());
			
			pause = new PauseState();
			

			FlxG.camera.setBounds(0, 0, levelX, levelY);

			FlxG.worldBounds = new FlxRect(0, 0, levelX, levelY);
			
			FlxG.camera.follow(_player);
		}
		
		override public function update():void
		{
			if (!pause.showing){

				super.update();
				
				// Check player and enemy collision
				FlxG.collide(_player, _enemies, triggerBattleState);
				
				if (FlxG.keys.P){
					pause = new PauseState;
					pause.showPaused();
					add(pause);
				} else if (FlxG.keys.B){
					battle = new BattlePlayState();
					FlxG.switchState(battle);
				} else if (FlxG.keys.C){ // cheathax
					Inventory.addCandy((int)(3 * Math.random()));
				}
			} else {
				pause.update();
			}
		}
		
		public function triggerBattleState(player:FlxSprite, enemy:Enemy):void {
			// for now just remove all enemies in a certain radius
			_enemies.remove(enemy);
			//switch to the battle state
			battle = new BattlePlayState();
			FlxG.switchState(battle);
		}
		
		public function triggerCraftingState():void {
			FlxG.switchState(new CraftingPlayState());
		}
	}
}