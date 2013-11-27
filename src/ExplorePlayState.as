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
		public static var _instance:ExplorePlayState;
		
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
		protected var _chests:ExploreChestManager;

		public var HUD:ExploreHUD;
		public var pause:PauseState;
		public var battle:BattlePlayState;
		
		public var buttonArray:Array;
		
		public var levelX:Number = 1200;
		public var levelY:Number = 800;
		
		private var background:FlxBackdrop ;
		
		Sources.fontCookies;
		
		public function ExplorePlayState(lock:SingletonLock) {
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
			
			_chests = new ExploreChestManager();
			
			var craftButton:FlxButton = new FlxButton(560-2, 410, "", triggerCraftingState); //-2 for margin
			craftButton.loadGraphic(Sources.buttonCraft);
			var craftLabel:FlxText=new FlxText(0,0,80,"CRAFT");
			craftLabel.setFormat("COOKIES", 16, 0xffffffff);
			craftLabel.alignment = "center";
			craftButton.label=craftLabel;
			craftButton.labelOffset=new FlxPoint(0,0);
			craftButton.scrollFactor.x = craftButton.scrollFactor.y = 0;

			var eatButton:FlxButton = new FlxButton(FlxG.width/2-40, 410, "EAT", eatStuff);

			eatButton.loadGraphic(Sources.buttonEat);
			var eatLabel:FlxText=new FlxText(0,0,80,"EAT");
			eatLabel.setFormat("COOKIES", 16, 0xffffffff);
			eatLabel.alignment = "center";
			eatButton.label=eatLabel;
			eatButton.labelOffset=new FlxPoint(0,0);
			eatButton.scrollFactor.x = eatButton.scrollFactor.y = 0;
			eatButton.onDown = eatCallback;
			
			buttonArray = new Array();
			buttonArray.push(craftButton);
			buttonArray.push(eatButton);
			
			pause = new PauseState();
			
			var pauseInstruction:FlxText = new FlxText(0, FlxG.height - 60, 130, "press P to pause");
			pauseInstruction.setFormat("COOKIES",10);
			pauseInstruction.color = 0x01000000;
			pauseInstruction.scrollFactor.x = pauseInstruction.scrollFactor.y = 0;
			
			
			add(_spawners);
			add(_enemies);
			add(_chests);
			add(_player);
			HUD = new ExploreHUD();
			add(HUD);
			add(craftButton);
			add(eatButton);
			add(pauseInstruction);
		}
		
		public static function get instance():ExplorePlayState {
			if (_instance == null) {
				_instance = new ExplorePlayState(new SingletonLock());
			}
			return _instance;
		}
		
		public static function resetInstance():void {
			_instance = new ExplorePlayState(new SingletonLock());
		}
		
		override public function create(): void
		{ 
			FlxG.camera.setBounds(0, 0, levelX, levelY);

			FlxG.worldBounds = new FlxRect(0, 0, levelX, levelY);
			
			FlxG.camera.follow(_player);
			FlxG.mouse.show();
			
			//enable all buttons
			for(var i=0 ; i < buttonArray.length ; i++) {
				var button:FlxButton = buttonArray[i];
				button.active = true;
			}
		}
		
		override public function destroy():void {
			//disable all buttons
			for(var i=0 ; i < buttonArray.length ; i++) {
				var button:FlxButton = buttonArray[i];
				button.active = false;
			}
		}
		
		override public function update():void
		{
			if (!pause.showing){

				super.update();
				
				if (PlayerData.instance.currentHealth <= 0){
					FlxG.switchState(new EndState());
				}
				if (_player.invincibilityTime > 0) {
					_player.invincibilityTime = Math.max(_player.invincibilityTime - FlxG.elapsed, 0);
					_player.flicker(_player.invincibilityTime);
					
					if (_player.invincibilityTime == 0) {
						for (var i=0; i<_enemies.length; ++i) {
							var enemy = _enemies.members[i];
							if (FlxG.overlap(_player, enemy, triggerBattleState)) {
								break;
							}
						}
					}
				}
				
				// Check player and enemy collision
				else if (_player.invincibilityTime == 0) {
					/* i haven't looked into the source to see how collision works exactly.
					however, it only seems to trigger on the first frame of a collision,
					rather than on every frame of a collision, so the above FlxG.overlap seems necessary to me. */
					FlxG.collide(_player, _enemies, triggerBattleState);
				}
				
				FlxG.collide(_player, _chests, triggerCandyChest);
				
				if (FlxG.keys.P){
					pause = new PauseState;
					pause.showPaused();
					add(pause);
				} else if (FlxG.keys.B){
					battle = new BattlePlayState(EnemyData.randomEnemyData(1));
					FlxG.switchState(battle);
				} else if (FlxG.keys.C){ // cheathax
					Inventory.addCandy((int)(3 * Math.random()));
				}
			} else {
				pause.update();
			}
		}
		
		public function eatCallback():void {
			HUD.openEat();
			var player:PlayerData = PlayerData.instance; 
			if (Inventory.hasCandy() && player.currentHealth !== player.maxHealth) {
				Inventory.removeCandy(Inventory.randomCandy());
				player.currentHealth = Math.min((player.currentHealth + 5), player.maxHealth);
			}
		}
		
		public function setInvincibility(duration:Number) {
			_player.invincibilityTime = duration;
		}
		
		public function triggerBattleState(player:FlxSprite, enemy:ExploreEnemy):void {
			
			// for now just remove all enemies in a certain radius
			enemy.kill();
			//switch to the battle state
			battle = new BattlePlayState(enemy.enemyData);
//			pause.showing = true;
			FlxG.play(Sources.battleStart);
			FlxG.fade(0x00000000, 1, startBattle);	

			function startBattle():void {
				FlxG.switchState(battle);
			}
		}
		
		public function triggerCraftingState():void {
			FlxG.switchState(new CraftingPlayState());
		}
		
		public function triggerCandyChest(player:FlxSprite, chest:ExploreCandyChest):void {
			chest.rewardCandy();
			_chests.remove(chest);
		}
		
		public function eatStuff():void{
		}
	}
}

class SingletonLock{}