package
{
	import flash.geom.Point;
	import flash.media.Camera;
	
	import org.flixel.FlxBackdrop;
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
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
			[new FlxPoint(10,5)],
			[new FlxPoint(640,5)],
			[new FlxPoint(10,365)],
			[new FlxPoint(640,365)]
		];
		
		private const craftHouseLocation:FlxPoint = new FlxPoint(FlxG.width/2.0, FlxG.height/2.0-60); 
		private var craftButton:FlxSprite; 
		protected var craftHouse:FlxSprite;
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:ExplorePlayer;
		protected var _chests:ExploreChestManager;
		
		protected var _killCount:FlxText;
		//public var _healthLabel:FlxText;
		
		private var portalShouldExplode:Boolean; 
		private var portalsDestroyed:int; 
		private var inGameMessage:FlxText
		private var temporaryInstructions:FlxSprite;
		private const instructionShowTime:Number = 10;
		private var _timer:Number;
		//health bars
		private var invenBarHeight:int = FlxG.height * 0.10 + 25; //25 is height of buttons

		const lifeBarWidth:int = 160;
		const lifeBarHeight:int = 18;
		
		private var playerLifeBarPos:FlxPoint = new FlxPoint(50, FlxG.height-invenBarHeight-350);  
		private var maxPlayerLifeBar:FlxSprite = new FlxSprite(playerLifeBarPos.x, playerLifeBarPos.y);
		private var playerLifeBar:FlxSprite = new FlxSprite(playerLifeBarPos.x, playerLifeBarPos.y);
		private var playerHealthText:FlxText = new FlxText(FlxG.width-160, 410, lifeBarWidth, "Blood Sugar: ?/?");

		public var HUD:ExploreHUD;
		public var pause:PauseState;
		public var battle:BattlePlayState;
				
		public static var levelX:Number = 720;//1200;
		public static var levelY:Number = 480;//800;
		
		private var background:FlxBackdrop;
		private var oldMap:FlxSprite;
		private var oldMapIndex:int=4; //starts at last map out of 5 (4 since index starts at 0)
		private var currentMap:FlxSprite;
		private var clouds:FlxSprite=new FlxSprite(0,0,Sources.mapClouds);
		private var fader:SpriteFader;
		private var cameraPanObject:FlxSprite; 
		private var originalCamera:FlxCamera; 
		
		public static const KILLGOAL:int=3*4; //3 enemies per 4 spawners
		private var portalExplosionDuration:Number = 4.0;
		
		private var difficulty:int = 1;
		private var backgroundColors:Array = [0xff805a3f, 0xffa86d46, 0xffffc662, 0xffffc662];
		
		Sources.fontCookies;
		
		public function ExplorePlayState(lock:SingletonLock) {
			_timer = 0;
//			var background:FlxSprite = new FlxSprite(0, 0, Sources.ExploreBackground);
//			background.loadGraphic(Sources.maps[getCurrentMap()]);
//			add(background);
//			background = new FlxBackdrop(Sources.maps[getCurrentMap()], 0.8, 0.6, true, true);
//			add(background);
			FlxG.mouse.load(Sources.cursor);
			portalShouldExplode = true;
			//map stuff
			currentMap=new FlxSprite(0,0,Sources.maps[getCurrentMap()]);
			oldMap=new FlxSprite(0,0,Sources.maps[getCurrentMap()]);
			fader = new SpriteFader(oldMap, currentMap);
			add(fader);
			//add(currentMap);
			
			_spawners = new FlxGroup();
			_enemies = new FlxGroup();
			inGameMessage = new FlxText(10, FlxG.height/2-50, FlxG.width-10, "test");
			inGameMessage.setFormat("COOKIES",20,0xff000000,"center",0xffffffff);
			inGameMessage.scrollFactor.x=inGameMessage.scrollFactor.y=0;
			inGameMessage.visible = false;
			_chests = new ExploreChestManager(_enemies, inGameMessage);
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
			/*
			_healthLabel = new FlxText(FlxG.width - 90, FlxG.height - 90, 90, "Health: ");
			_healthLabel.scrollFactor.x = _healthLabel.scrollFactor.y = 0;
			_healthLabel.setFormat("COOKIES",15,0xff000000);
			*/
			cameraPanObject = new FlxSprite(0,0); 
			cameraPanObject.makeGraphic(10, 10, 0xffffffff);
			cameraPanObject.visible = false; 
			//very specific code for putting the instruction signboard in the game
			temporaryInstructions = new FlxSprite(FlxG.width/2.0-160,40);
			temporaryInstructions.alpha = 0.5;
			temporaryInstructions.loadGraphic(Sources.InstructionsSmall);
			temporaryInstructions.scrollFactor.x=temporaryInstructions.scrollFactor.y=0;
			
			
			add(craftHouse);
			add(craftButton);
			add(_spawners);
			add(_chests);
			add(_enemies);
			add(_player);
			add(clouds);
			HUD = new ExploreHUD();
			add(inGameMessage);
			add(HUD);
			add(_killCount);
			//add(_healthLabel);
			add(cameraPanObject);
			
			add(pauseInstruction); 
			add(temporaryInstructions);
			
			HUD.eatFunction = function(color:int, healAmount:Number):void {
				PlayerData.instance.heal(healAmount);
			};
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
			//FlxG.visualDebug = true; 
			FlxG.bgColor = 0xff783629;
			
			FlxG.camera.setBounds(0, 0, levelX, levelY);

			FlxG.worldBounds = new FlxRect(0, 0, levelX, levelY);
			
			FlxG.camera.follow(_player);
			//originalCamera = FlxG.camera; 
			FlxG.mouse.show();
			
			maxPlayerLifeBar.makeGraphic(lifeBarWidth, lifeBarHeight, 0xff00aa00);
			playerLifeBar.makeGraphic(lifeBarWidth, lifeBarHeight, healthColor(PlayerData.instance.currentHealth/PlayerData.instance.maxHealth*100.0));
			playerLifeBar.setOriginToCorner()
			maxPlayerLifeBar.x = playerLifeBar.x= FlxG.width-160;
			maxPlayerLifeBar.y = playerLifeBar.y = 410;
			maxPlayerLifeBar.scrollFactor.x = maxPlayerLifeBar.scrollFactor.y = 0;
			playerLifeBar.scrollFactor.x = playerLifeBar.scrollFactor.y = 0;
			playerHealthText.scrollFactor.x = playerHealthText.scrollFactor.y = 0;
			playerHealthText.text = "Blood Sugar: " + PlayerData.instance.currentHealth + "/" + PlayerData.instance.maxHealth;
			playerHealthText.setFormat("COOKIES",14, 0x000000, "center");
			add(maxPlayerLifeBar);
			add(playerLifeBar);
			add(playerHealthText);
			
			drawHealthBar();


		}
		
		private function healthColor(healthPercent:Number):uint
		{
			if (healthPercent > 50)
			{
				return 0xff00ff00;
			}
			else if (healthPercent > 25)
			{
				return 0xffffff00;
			}
			else
			{
				return 0xffff0000;
			}
		}
		private function drawHealthBar():void
		{
			var health:Number = PlayerData.instance.currentHealth/PlayerData.instance.maxHealth*100.0;
			
			playerLifeBar.scale.x = health / 100.0;
			var playerBarColor:uint = healthColor(health);
			playerLifeBar.fill(playerBarColor);
			// change color based on health!
			
			
			
		}
		
		override public function destroy():void {
		}
		
		override public function update():void
		{
			if (!pause.showing){
//				trace("x: " + String(FlxG.mouse.getScreenPosition().x) + // used for finding positions on screen
//					" y: " + String(FlxG.mouse.getScreenPosition().y));
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
				if(PlayerData.instance.killCount % _spawners.members[0].totalEnemies == 0 && PlayerData.instance.killCount != 0 && portalShouldExplode) 
				{
					//portal moving 
					var spawner:EnemySpawner = EnemySpawner(_spawners.getFirstAlive());
					var zoomCam:ZoomCamera = new ZoomCamera(FlxG.width, 0, levelX, levelY);
					FlxG.resetCameras( zoomCam );
					FlxG.camera.follow(spawner);
					zoomCam.targetZoom = 2;
					spawner.play("explode");
					FlxG.bgColor = backgroundColors[portalsDestroyed]; 
					portalsDestroyed++;
					portalShouldExplode = false;
					(new FlxTimer()).start(portalExplosionDuration,1,resetCamera(_player,0, spawner));
				}
				if (PlayerData.instance.killCount % _spawners.members[0].totalEnemies != 0) 
				{
					portalShouldExplode = true;
				}
				_killCount.text = "Kills: " + PlayerData.instance.killCount;
				//_healthLabel.text = "Health: " + PlayerData.instance.currentHealth;
				
				//map changey stuff
				var currentMapIndex:int = getCurrentMap();
				currentMap.loadGraphic(Sources.maps[currentMapIndex]);
				if (currentMapIndex!=oldMapIndex){ //if the map changed
					FlxG.play(Sources.explosion);
					oldMap.loadGraphic(Sources.maps[oldMapIndex]);
					oldMapIndex=currentMapIndex;
					fader.replaceImages(oldMap,currentMap);
					fader.animate(4.0);
					clouds.alpha=currentMapIndex/4;
					difficulty++;
					for (var i:int = 0; i < _enemies.length; i++) {
						var enemyData:BattleEnemy = _enemies.members[i].enemyData;
						_enemies.members[i].enemyData = new BattleEnemy(enemyData.maxHealth, enemyData.name, difficulty);
					}
					for (var i:int = 0; i < _spawners.length; i++) {
						_spawners.members[i].enemyDifficulty = difficulty;
					}
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
				}else if (FlxG.keys.justPressed("K")){ //killcount cheathax
					PlayerData.instance.killCount++;
				}
			} else {
				_player.flicker(0);
				pause.update();
			}
		}
		
		//focuses camera on that object, where width and height are the w and h of the camera
		private function resetCamera(object:FlxSprite, zoom:int, spawner:EnemySpawner):Function
		{
			return function(timer:FlxTimer):void {
				var camera:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
				camera.setBounds(0,0, levelX, levelY); 
				camera.follow(object)
				FlxG.resetCameras(camera);
				spawner.alive = false;
				spawner.visible = false;
			};
			
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
