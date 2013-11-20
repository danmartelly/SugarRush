package
{
	import org.flixel.FlxBackdrop;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class ExplorePlayState extends FlxState
	{	
		// syntax: FlxPoint 
		private const spawnerLocations:Array = [
			[new FlxPoint(10,10)],
			[new FlxPoint(1150,10)],
			[new FlxPoint(10,700)],
			[new FlxPoint(1150,700)]
		];
		
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:ExplorePlayer;

		public var HUD:ExploreHUD;
		public var pause:PauseState;
		public var battle:BattlePlayState;
		
		public var levelX:Number = 1200;
		public var levelY:Number = 800;
		
		public var invincibilityTime:Number = 0;
		
		private var background:FlxBackdrop ;
		
		Sources.fontCookies;
		
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
			HUD = new ExploreHUD()
			add(HUD);
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
				
				if (PlayerData.instance.currentHealth <= 0){
					FlxG.switchState(new EndState());
				}
				if (invincibilityTime > 0) {
					invincibilityTime = Math.max(invincibilityTime - FlxG.elapsed, 0);
					_player.flicker(invincibilityTime);
					
					if (invincibilityTime == 0) {
						for (var i=0; i<_enemies.length; ++i) {
							var enemy = _enemies.members[i];
							if (FlxG.overlap(_player, enemy, triggerBattleState)) {
								break;
							}
						}
					}
				}
				
				// Check player and enemy collision
				else if (invincibilityTime == 0) {
					/* i haven't looked into the source to see how collision works exactly.
					however, it only seems to trigger on the first frame of a collision,
					rather than on every frame of a collision, so the above FlxG.overlap seems necessary to me. */
					FlxG.collide(_player, _enemies, triggerBattleState);
				}
				
				if (FlxG.keys.P){
					pause = new PauseState;
					pause.showPaused();
					add(pause);
				} else if (FlxG.keys.B){
					battle = new BattlePlayState(EnemyData.randomEnemyData(8));
					FlxG.switchState(battle);
				} else if (FlxG.keys.C){ // cheathax
					Inventory.addCandy((int)(3 * Math.random()));
				}
			} else {
				pause.update();
			}
		}
		
		public function setInvincibility(duration:Number) {
			invincibilityTime = duration;
		}
		
		public function triggerBattleState(player:FlxSprite, enemy:ExploreEnemy):void {
			
			// for now just remove all enemies in a certain radius
			enemy.kill();
			//switch to the battle state
			battle = new BattlePlayState(enemy.enemyData);
			pause.showing = true;
			FlxG.play(Sources.battleStart);
			FlxG.fade(0x00000000, 1, startBattle);	

			function startBattle():void {
				FlxG.switchState(battle);
			}
		}
		
		public function triggerCraftingState():void {
			FlxG.switchState(new CraftingPlayState());
		}
		
		public function eatStuff():void{
		}
	}
}