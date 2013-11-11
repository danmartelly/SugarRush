package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class BattlePlayState extends FlxState
	{		
		var voidFn:Function = function():void {};
		var logic:BattleLogic = null;
		
		private var x:int = FlxG.width /2 + 150;
		private var y:int = FlxG.height - 50;
		private var attackButton:FlxButton = new FlxButton(x, y, "Attack", attackCallback);
		private var switchButton:FlxButton = new FlxButton(x + 85, y, "Switch Weapon", switchCallback);
		private var runButton:FlxButton = new FlxButton(x, y + 25, "Run", runCallback);
		private var candyButton:FlxButton = new FlxButton(x + 85, y + 25, "Eat Candy", candyCallback);
		private var enemyName:FlxText = new FlxText(50,35, 100,"Enemy Name");
		
		private var maxEnemyLifeBar:FlxSprite = new FlxSprite(50,50);
		private var enemyLifeBar:FlxSprite = new FlxSprite(50, 50);
		private var playerName:FlxText = new FlxText(x,y-65,100,"Kid");
		private var maxPlayerLifeBar:FlxSprite = new FlxSprite(x,y - 50);
		private var playerLifeBar:FlxSprite = new FlxSprite(x, y - 50);
		private var playerSprite:FlxSprite = new FlxSprite(50, FlxG.height-325, Sources.battlePlayer);
		private var enemySprite:FlxSprite = new FlxSprite(FlxG.width-300, 0);
		private var timer:Number = 1;
		private var timerStart:Boolean = false;
		
		
		
		override public function create():void {
			FlxG.debug = true;
			FlxG.visualDebug = true;
			FlxG.bgColor = 0xffaaaaaa;
			logic = new BattleLogic(this);
			maxEnemyLifeBar.makeGraphic(100,10,0xff00aa00);
			enemyLifeBar.makeGraphic(100,10, 0xff00ff00);
			enemyLifeBar.setOriginToCorner();
			
			var playerName:FlxText = new FlxText(x,y-65,100,"Kid");
			
			maxPlayerLifeBar.makeGraphic(100,10,0xff00aa00);
			playerLifeBar.makeGraphic(100,10, 0xff00ff00);
			playerLifeBar.setOriginToCorner();
			
			enemySprite.loadGraphic(Sources.enemyMap[logic.enemy.name], true, false, 300, 300);
			
			enemySprite.addAnimation("idle", [0]);
			enemySprite.addAnimation("attacked", [1]);
		
			
			add(maxEnemyLifeBar);
			add(enemyLifeBar);
			add(playerName);
			add(maxPlayerLifeBar);
			add(playerLifeBar);
			add(enemyName);
			add(attackButton);
			add(switchButton);
			add(runButton);
			add(candyButton);
			add(enemySprite);
			add(playerSprite);
			FlxG.mouse.show();
			
			drawHealthBar();
		}
		
		public function runTime():void
		{
			//Reduce Number
			timer -= FlxG.elapsed;
			
			
			
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("B")) {
				var s1 = "", s2 = "";
				for (var i=0; i<logic.player.buffs.length; ++i) {
					if (i) s1 += ", ";
					s1 += logic.player.buffs[i].name + "(" + logic.player.buffs[i].turns + ")";
				}
				for (var i=0; i<logic.enemy.buffs.length; ++i) {
					if (i) s2 += ", ";
					s2 += logic.enemy.buffs[i].name + "(" + logic.enemy.buffs[i].turns + ")";
				}
				trace("player: " + logic.player.currentHealth + "/" + logic.player.maxHealth + " weapon: " + logic.player.data.currentWeapon().name + " buffs: " + s1);
				trace("enemy: " + logic.enemy.currentHealth + "/" + logic.enemy.maxHealth + " buffs: " + s2);

			}
			if (timerStart == true){
				runTime();
				enemySprite.play("attacked");
			}
			if (timer <= 0){
				timer = 1;
				timerStart = false;
				enemySprite.play("idle");
			}
			super.update();
		}
		
		public function showHealth():void{
			add(new FlxText(150, 150, 100, logic.player.currentHealth.toString()));
		}
		
		private function drawHealthBar():void {
			var health:Number = logic.playerHealthPercent();
			playerLifeBar.scale.x = health / 100.0;
		}
		
		public function attackCallback():void {
			drawHealthBar();
			timerStart = true;
			logic.useAttack();
			
		}
		
		public function switchCallback():void{
			add(new BattleInventoryMenu());
			//logic.switchWeaponIndex(1);
		}
		
		public function runCallback():void{
			logic.useRun();
		}
		
		public function candyCallback():void{
			logic.useCandy();
		}
		
		public function healthCallback():void {
			add(new FlxText(10,10,100,"in health call back"));
			
			drawHealthBar();
			
			var e_health:Number = logic.enemyHealthPercent();
			enemyLifeBar.scale.x = e_health / 100.0;
		}
		
		public function turnCallback(turn:int):void {
			//add(new FlxText(10,60,100,"in turnCallback"));
			switch(turn){
				case BattleLogic.ENEMY_TURN:
					attackButton.active = false;
					switchButton.active = false;
					runButton.active = false;
					candyButton.active = false;
					break;
				case BattleLogic.PLAYER_TURN:
					attackButton.active = true;
					switchButton.active = true;
					runButton.active = true;
					candyButton.active = true;
					break;
				
			}
			
			this.update();
			
		}
		
		public function attackLogicCallback():void {
			
		}
		
		public function endBattleCallback(status:int):void {			
			switch(status){
				case BattleLogic.ENEMY_WON:
					
					break;
				
				case BattleLogic.PLAYER_WON:
					break;
				
				case BattleLogic.RAN_AWAY:
					logic.player.currentHealth -= 1;
					logic.player.updatePlayerData();
					
					FlxG.mouse.hide();
					FlxG.switchState(new ExplorePlayState());
					break;
			}
		}
	}
}