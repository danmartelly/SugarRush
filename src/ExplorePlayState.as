package
{
	import flash.geom.Point;
	
	import org.flixel.FlxBackdrop;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	
	public class ExplorePlayState extends FlxState
	{	
		public static var _instance:ExplorePlayState;
		
		// syntax: FlxPoint 
		private const spawnerLocations:Array = [
			[new FlxPoint(10,10)],
			[new FlxPoint(620,10)], //1100,10
			[new FlxPoint(10,360)], //10, 700
			[new FlxPoint(620,360)] //1100, 700
		];
		
		private const craftHouseLocation:FlxPoint = new FlxPoint(FlxG.width/2.0, FlxG.height/2.0-60); 
		private var craftButton:FlxSprite; 
		protected var craftHouse:FlxSprite;
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var portal:FlxSprite;
		protected var _player:ExplorePlayer;
		protected var _chests:ExploreChestManager;
		
		protected var _killCount:FlxText;
		public var _healthLabel:FlxText;
		
		private var inGameMessage:FlxText
		private var temporaryInstructions:FlxSprite;
		private const instructionShowTime:Number = 10;
		private var _timer:Number;

		public var HUD:ExploreHUD;
		public var pause:PauseState;
		public var battle:BattlePlayState;
				
		public static var levelX:Number = 720;//1200;
		public static var levelY:Number = 480;//800;
		
		private var background:FlxBackdrop;
		private var oldMap:FlxSprite;
		private var oldMapIndex:int=4; //starts at last map out of 5 (4 since index starts at 0)
		private var currentMap:FlxSprite;
		private var fader:SpriteFader;
		
		public static const KILLGOAL:int=3*4; //3 enemies per 4 spawners
		
		Sources.fontCookies;
		
		public function ExplorePlayState(lock:SingletonLock) {
			_timer = 0;
			var background:FlxSprite = new FlxSprite(0, 0, Sources.ExploreBackground);
			background.loadGraphic(Sources.maps[getCurrentMap()]);
			add(background);
			
			FlxG.mouse.load(Sources.cursor);
			
			//map stuff
			currentMap=new FlxSprite(0,0,Sources.maps[getCurrentMap()]);
			oldMap=new FlxSprite(0,0,Sources.maps[getCurrentMap()]);
			fader = new SpriteFader(oldMap, currentMap);
			add(fader);
			//add(currentMap);
			
			_spawners = new FlxGroup();
			_enemies = new FlxGroup();
			inGameMessage = new FlxText(FlxG.width/2.0, 0, 300, "test");
			inGameMessage.setFormat("COOKIES",20);
			inGameMessage.color = 0xff000000;
			inGameMessage.visible = false;
			_chests = new ExploreChestManager(_enemies, inGameMessage);
			_player = new ExplorePlayer(FlxG.width/2, FlxG.height/2);
			for each (var e in spawnerLocations) {
				var entry:Array = e as Array;
				//breakdown
				var spawnPoint:FlxPoint = entry[0];
				//make new Spawner
				var spawner:EnemySpawner = new EnemySpawner(spawnPoint.x, spawnPoint.y, _enemies, _chests, _player);
				portal = new FlxSprite(spawnPoint.x, spawnPoint.y, Sources.Portal);
				//add to State
				_spawners.add(spawner);
				add(portal);
			}
			
			craftHouse = new FlxSprite(craftHouseLocation.x, craftHouseLocation.y, Sources.CraftHouse); 
			craftHouse.height -= 20; 
			craftHouse.width -= 20;
			craftButton = new FlxSprite(craftHouseLocation.x + 15, craftHouseLocation.y - 40, Sources.CraftButton);
			craftButton.visible = false;
			
			pause = new PauseState();
			
			var pauseInstruction:FlxText = new FlxText(0, FlxG.height - 60, 130, "press P to pause");
			pauseInstruction.setFormat("COOKIES",10);
			pauseInstruction.color = 0x01000000;
			pauseInstruction.scrollFactor.x = pauseInstruction.scrollFactor.y = 0;
			
			_killCount = new FlxText(FlxG.width - 90, 10, 90, "Kills: ");
			_killCount.scrollFactor.x = _killCount.scrollFactor.y = 0;
			_killCount.setFormat("COOKIES", 15, 0xff000000);
			
			_healthLabel = new FlxText(FlxG.width - 90, FlxG.height - 90, 90, "Health: ");
			_healthLabel.scrollFactor.x = _healthLabel.scrollFactor.y = 0;
			_healthLabel.setFormat("COOKIES",15,0xff000000);
			
			
			//very specific code for putting the instruction signboard in the game
			temporaryInstructions = new FlxSprite(FlxG.width/2.0-100,40);
			temporaryInstructions.alpha = 0.5;
			temporaryInstructions.loadGraphic(Sources.InstructionsSmall);
			
			add(temporaryInstructions);
			add(_killCount);
			add(_healthLabel);
			add(craftHouse);
			add(craftButton);
			add(_spawners);
			add(_chests);
			add(_enemies);
			add(_player);
			HUD = new ExploreHUD();
			add(inGameMessage);
			add(HUD);
			
			add(pauseInstruction); 
			
			HUD.eatFunction = function(color:int, healAmount:Number):void{};
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
				
				_timer += FlxG.elapsed;
				if (_timer > instructionShowTime) {
					remove(temporaryInstructions)
				}
				
				if (PlayerData.instance.currentHealth <= 0){
					FlxG.switchState(new EndState());
				}
				if(PlayerData.instance.killCount>=KILLGOAL){
					FlxG.switchState(new WinState());
				}
				
				_killCount.text = "Kills: " + PlayerData.instance.killCount;
				_healthLabel.text = "Health: " + PlayerData.instance.currentHealth;
				
				//map changey stuff
				var currentMapIndex:int = getCurrentMap();
				currentMap.loadGraphic(Sources.maps[currentMapIndex]);
				if (currentMapIndex!=oldMapIndex){ //if the map changed
					oldMap.loadGraphic(Sources.maps[oldMapIndex]);
					oldMapIndex=currentMapIndex;
					fader.replaceImages(oldMap,currentMap);
					fader.animate(4.0);
				}
				
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
					craftButton.visible = true; 
					if (FlxG.keys.E) 
					{
						triggerCraftingState();
					}
				} 
				else 
				{
					craftButton.visible = false;
				}
				FlxG.overlap(_enemies, _chests);
				
				if (FlxG.keys.P){
					pause = new PauseState;
					pause.showPaused();
					add(pause);
				} else if (FlxG.keys.B){ // for debugging help
					battle = new BattlePlayState(new ExploreEnemy(0, 0, BattleEnemy.randomBattleEnemy(1), _chests, _enemies, _player), BattleEnemy.randomBattleEnemy(1));
					FlxG.switchState(battle);
				} else if (FlxG.keys.V){ // cheathax
					Inventory.addCandy((int)(3 * Math.random()));
				}else if (FlxG.keys.K){ //killcount cheathax
					PlayerData.instance.killCount++;
				}
			} else {
				_player.flicker(0);
				pause.update();
			}
		}
		
		public function setInvincibility(duration:Number):void {
			_player.invincibilityTime = duration;
		}
		
		//returns the current map
		private function getCurrentMap():int{
			var currentMap:int=4;
			var kills:int = PlayerData.instance.killCount;
			var killRatio:Number = kills/KILLGOAL;
			if (killRatio >= .8){
				currentMap=0;
			}else if (killRatio >= .6){
				currentMap=1;
			}else if (killRatio >= .4){
				currentMap=2;
			}else if (killRatio >= .2){
				currentMap=3;
			}
			return currentMap;
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
			chest.rewardTreasure();
		}
	}
}

class SingletonLock{}
