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
			[new FlxPoint(700,10)], //1100,10
			[new FlxPoint(10,390)], //10, 700
			[new FlxPoint(700,390)] //1100, 700
		];
		
		private const craftHouseLocation:FlxPoint = new FlxPoint(FlxG.width/2.0, FlxG.height/2.0-60); 
		protected var craftHouse:FlxSprite;
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:ExplorePlayer;
		protected var _chests:ExploreChestManager;
		
		protected var craftInstructions:FlxText;

		public var HUD:ExploreHUD;
		public var pause:PauseState;
		public var battle:BattlePlayState;
				
		public var levelX:Number = 720;//1200;
		public var levelY:Number = 480;//800;
		
		private var background:FlxBackdrop;
		private var backgroundOpacity:FlxSprite;
		
		public static const KILLGOAL:int=20;
		
		Sources.fontCookies;
		

		public function ExplorePlayState(lock:SingletonLock) {
			var background:FlxSprite = new FlxSprite(0, 0, Sources.ExploreBackground);
			add(background);
			
			backgroundOpacity=new FlxSprite(0,0);
			backgroundOpacity.makeGraphic(FlxG.width,FlxG.height,0xff000000);
			backgroundOpacity.alpha=(KILLGOAL-PlayerData.instance.killCount)/KILLGOAL/2;
			backgroundOpacity.scrollFactor.x=backgroundOpacity.scrollFactor.y=0;
			add(backgroundOpacity);
			
			_spawners = new FlxGroup();
			_enemies = new FlxGroup();
			_chests = new ExploreChestManager(_enemies);
			_player = new ExplorePlayer(FlxG.width/2, FlxG.height/2);
			for each (var e in spawnerLocations) {
				var entry:Array = e as Array;
				//breakdown
				var spawnPoint:FlxPoint = entry[0];
				//make new Spawner
				var spawner:EnemySpawner = new EnemySpawner(spawnPoint.x, spawnPoint.y, _enemies, _chests, _player);
				//add to State
				_spawners.add(spawner);
			}
			
			craftHouse = new FlxSprite(craftHouseLocation.x, craftHouseLocation.y, Sources.CraftHouse); 
						
			pause = new PauseState();
			
			var pauseInstruction:FlxText = new FlxText(0, FlxG.height - 60, 130, "press P to pause");
			pauseInstruction.setFormat("COOKIES",10);
			pauseInstruction.color = 0x01000000;
			pauseInstruction.scrollFactor.x = pauseInstruction.scrollFactor.y = 0;
			
			craftInstructions = new FlxText(0,FlxG.height - 100,500, "Press C to enter and craft weapons");
			craftInstructions.setFormat("COOKIES",15);
			craftInstructions.color=0x01000000;
			craftInstructions.scrollFactor.x = craftInstructions.scrollFactor.y = 0;
			
			
			add(craftHouse);
			add(_spawners);
			add(_chests);
			add(_enemies);
			add(_player);
			HUD = new ExploreHUD();
			add(HUD);
			
			add(pauseInstruction);
			add(craftInstructions);
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
		}
		
		override public function destroy():void {
		}
		
		override public function update():void
		{
			if (!pause.showing){

				super.update();
				
				if (PlayerData.instance.currentHealth <= 0){
					FlxG.switchState(new EndState());
				}
				if(PlayerData.instance.killCount>=KILLGOAL){
					FlxG.switchState(new WinState());
				}
				
				backgroundOpacity.alpha=(KILLGOAL-PlayerData.instance.killCount)/KILLGOAL/2;
				
				if (_player.invincibilityTime > 0) {
					_player.invincibilityTime = Math.max(_player.invincibilityTime - FlxG.elapsed, 0);
					_player.flicker(_player.invincibilityTime);
					
					if (_player.invincibilityTime == 0) {
						for (var i:int=0; i<_enemies.length; ++i) {
							var enemy:ExploreEnemy = _enemies.members[i];
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
					FlxG.overlap(_player, _enemies, triggerBattleState);
				}
				
				FlxG.overlap(_player, _chests, triggerCandyChest);
				if (FlxG.overlap(_player, craftHouse)) 
				{
					craftInstructions.visible = true; 
					
					if (FlxG.keys.C)
					{
						triggerCraftingState();
					}
				} 
				else 
				{
					craftInstructions.visible = false;
				}
				
				if (FlxG.keys.P){
					pause = new PauseState;
					pause.showPaused();
					add(pause);
				} else if (FlxG.keys.B){
					battle = new BattlePlayState(new ExploreEnemy(0, 0, BattleEnemy.randomBattleEnemy(1), _chests, _enemies, _player), BattleEnemy.randomBattleEnemy(1));
					FlxG.switchState(battle);
				} else if (FlxG.keys.A){ // cheathax
					Inventory.addCandy((int)(3 * Math.random()));
				}
			} else {
				pause.update();
			}
		}
		
		public function setInvincibility(duration:Number):void {
			_player.invincibilityTime = duration;
		}
		
		public function triggerBattleState(player:FlxSprite, enemy:ExploreEnemy):void {
			
			//switch to the battle state
			battle = new BattlePlayState(enemy, enemy.enemyData);
			pause.showing = true;
			FlxG.play(Sources.battleStart);
			FlxG.fade(0x00000000, 1, startBattle);	

			function startBattle():void {
				FlxG.switchState(battle);
				pause.showing = false;
			}
		}
		
		public function triggerCraftingState():void {
			FlxG.switchState(new CraftingPlayState());
		}
		
		public function triggerCandyChest(player:FlxSprite, chest:ExploreCandyChest):void {
			chest.rewardCandy();
			//_chests.remove(chest);
		}
	}
}

class SingletonLock{}
