package
{
	import org.flixel.*;
	
	public class ExplorePlayState extends FlxState
	{	
		// syntax: FlxPoint 
		private const spawnerLocations:Array = [
			[new FlxPoint(0,0)],
			[new FlxPoint(600,400)],
			[new FlxPoint(1100,700)]
		];
		
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:ExplorePlayer;

		public var pause:PauseState;
		public var battle:BattlePlayState;
		
		public var levelX:Number = 1200;
		public var levelY:Number = 800;
		
		private var background:FlxBackdrop ;
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		override public function create(): void
		{
			 
			var background:FlxSprite = new FlxSprite(0, 0, Sources.ExploreBackground);
			add(background);
			
			_spawners = new FlxGroup();
			_enemies = new FlxGroup();
			_player = new ExplorePlayer();
			for each (var e in spawnerLocations) {
				var entry:Array = e as Array;
				//breakdown
				var spawnPoint:FlxPoint = entry[0];
				//make new Spawner
				var spawner:EnemySpawner = new EnemySpawner(spawnPoint.x, spawnPoint.y, _enemies, _player);
				//add to State
				_spawners.add(spawner);
			}
			
			var craftButton:FlxButton = new FlxButton(560-2, 410, "", triggerCraftingState); //-2 for margin
			craftButton.loadGraphic(Sources.buttonCraft);
			craftButton.scrollFactor.x = craftButton.scrollFactor.y = 0;

			var eatButton:FlxButton = new FlxButton(FlxG.width/2-40, 410, "", eatStuff);
			eatButton.loadGraphic(Sources.buttonEat);
			eatButton.scrollFactor.x = eatButton.scrollFactor.y = 0;

			pause = new PauseState();
			
			var pauseInstruction:FlxText = new FlxText(0, FlxG.height - 60, 130, "press P to pause");
			pauseInstruction.setFormat("COOKIES",10);
			pauseInstruction.color = 0x01000000;
			pauseInstruction.scrollFactor.x = pauseInstruction.scrollFactor.y = 0;
			
			
			add(_spawners);
			add(_enemies);
			add(_player);
			add(new ExploreHUD());
			add(craftButton);
			add(eatButton);
			add(pauseInstruction);

			FlxG.camera.setBounds(0, 0, levelX, levelY);

			FlxG.worldBounds = new FlxRect(0, 0, levelX, levelY);
			
			FlxG.camera.follow(_player);
			FlxG.mouse.show();
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
					battle = new BattlePlayState("carrot");
					FlxG.switchState(battle);
				} else if (FlxG.keys.C){ // cheathax
					Inventory.addCandy((int)(3 * Math.random()));
				}
			} else {
				pause.update();
			}
		}
		
		public function triggerBattleState(player:FlxSprite, enemy:ExploreEnemy):void {
			// for now just remove all enemies in a certain radius
			_enemies.remove(enemy);
			//switch to the battle state
			battle = new BattlePlayState(enemy.enemyType);
			FlxG.switchState(battle);
		}
		
		public function triggerCraftingState():void {
			FlxG.switchState(new CraftingPlayState());
		}
		
		public function eatStuff():void{
		}
	}
}