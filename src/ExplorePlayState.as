package
{
	import org.flixel.FlxBackdrop;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class ExplorePlayState extends FlxState
	{		
		protected var _enemies:FlxGroup;
		protected var _spawners:FlxGroup;
		protected var _player:ExplorePlayer;
		protected var _inventoryBox:FlxSprite;
		protected var _inventoryDividerH:FlxSprite;
		protected var _inventoryDividerV:FlxSprite;
		protected var _weaponsText:FlxSprite;
		protected var _candiesText:FlxSprite;
		protected var _redSprite:FlxSprite;
		protected var _blueSprite:FlxSprite;
		protected var _whiteSprite:FlxSprite;
		protected var _redCount:FlxText;
		protected var _blueCount:FlxText;
		protected var _whiteCount:FlxText;
		
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
			var spawner:EnemySpawner = new EnemySpawner(200,200,_enemies,_player);
			_spawners.add(spawner);
			add(_spawners);
			add(_enemies);
			add(_player);
			
			_inventoryBox = new FlxSprite(0, FlxG.height * 0.90).makeGraphic(FlxG.width, FlxG.height * 0.10, 0xFF000000);
			_inventoryBox.scrollFactor.x = _inventoryBox.scrollFactor.y = 0;
			_inventoryDividerH = new FlxSprite(0, FlxG.height * 0.90).makeGraphic(FlxG.width, 1);
			_inventoryDividerH.scrollFactor.x = _inventoryDividerH.scrollFactor.y = 0;
			_inventoryDividerV = new FlxSprite(FlxG.width * 0.60, FlxG.height * 0.90).makeGraphic(1, FlxG.height * 0.10);
			_inventoryDividerV.scrollFactor.x = _inventoryDividerV.scrollFactor.y = 0;
			add(_inventoryBox);
			add(_inventoryDividerH);
			add(_inventoryDividerV);
			
			_weaponsText = new FlxText(0, FlxG.height * 0.90, FlxG.width, "Weapons:");
			_candiesText = new FlxText(FlxG.width * 0.60, FlxG.height * 0.90, FlxG.width, "Candies:");
			_weaponsText.scrollFactor.x = _weaponsText.scrollFactor.y = 0;
			_candiesText.scrollFactor.x = _candiesText.scrollFactor.y = 0;
			add(_weaponsText);
			add(_candiesText);
			
			_redSprite = new FlxSprite(FlxG.width * 0.65, FlxG.height * 0.95).makeGraphic(15, 15, 0xFFFF0000);
			_blueSprite = new FlxSprite(FlxG.width * 0.75, FlxG.height * 0.95).makeGraphic(15, 15, 0xFF0000FF);
			_whiteSprite = new FlxSprite(FlxG.width * 0.85, FlxG.height * 0.95).makeGraphic(15, 15, 0xFFFFFFFF);
			_redSprite.scrollFactor.x = _redSprite.scrollFactor.y = 0;
			_blueSprite.scrollFactor.x = _blueSprite.scrollFactor.y = 0;
			_whiteSprite.scrollFactor.x = _whiteSprite.scrollFactor.y = 0;
			add(_redSprite);
			add(_blueSprite);
			add(_whiteSprite);
			
			_redCount = new FlxText(FlxG.width * 0.68, FlxG.height * 0.95, FlxG.width, "x" + Inventory.candyCount(0));
			_blueCount = new FlxText(FlxG.width * 0.78, FlxG.height * 0.95, FlxG.width, "x" + Inventory.candyCount(1));
			_whiteCount = new FlxText(FlxG.width * 0.88, FlxG.height * 0.95, FlxG.width, "x" + Inventory.candyCount(2));
			_redCount.scrollFactor.x = _redCount.scrollFactor.y = 0;
			_blueCount.scrollFactor.x = _blueCount.scrollFactor.y = 0;
			_whiteCount.scrollFactor.x = _whiteCount.scrollFactor.y = 0;
			add(_redCount);
			add(_blueCount);
			add(_whiteCount);
			
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
				_redCount.text = "x" + Inventory.candyCount(0);
				_blueCount.text = "x" + Inventory.candyCount(1);
				_whiteCount.text = "x" + Inventory.candyCount(2);
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
	}
}