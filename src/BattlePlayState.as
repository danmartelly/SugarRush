package
{
	import org.flixel.FlxBackdrop;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	
	public class BattlePlayState extends FlxState
	{		
		private var voidFn:Function = function():void {};
		private var logic:BattleLogic = null;
		
		private var hor:int = FlxG.width /2 + 150;
		private var y:int = FlxG.height ;//- 50;
		private var invenBarHeight:int = FlxG.height * 0.1 + 25; //25 is height of buttons
		
		private var buttonWidth:int = 80;
		private var attackButton:FlxButton = new FlxButton(0+2, 410, "", attackCallback); // +2 for margin
		private var eatButton:FlxButton = new FlxButton(FlxG.width/2-buttonWidth/2, 410, "", candyCallback);
		//private var switchButton:FlxButton = new FlxButton(x + 85, y-invenBarHeight, "Switch Weapon", switchCallback);
		private var runButton:FlxButton = new FlxButton(FlxG.width-buttonWidth-2 , 410, "", runCallback); // -2 for margin
		//private var candyButton:FlxButton = new FlxButton(x + 85, y + 25-invenBarHeight, "Eat Candy", candyCallback);
		
		private var enemyType:String;
		private var maxEnemyLifeBar:FlxSprite = new FlxSprite(50, 50);
		private var enemyLifeBar:FlxSprite = new FlxSprite(50, 50);
		private var enemyName:FlxText = new FlxText(50,25, 150,"Enemy Name");
		private var enemyHealthText:FlxText = new FlxText(50, 50, 100, "Health: ?/?");
		
		private var maxPlayerLifeBar:FlxSprite = new FlxSprite(hor,y - 50-invenBarHeight);
		private var playerLifeBar:FlxSprite = new FlxSprite(hor, y - 50-invenBarHeight);
		private var playerName:FlxText = new FlxText(hor,y-75-invenBarHeight,75,"Kid");
		private var playerHealthText:FlxText = new FlxText(hor, y - 50-invenBarHeight, 100, "Blood Sugar: ?/?");
		
		private var playerSprite:FlxSprite = new FlxSprite(25, FlxG.height-325-invenBarHeight, Sources.battlePlayer);
		private var enemySprite:FlxSprite = new FlxSprite(FlxG.width-300, 0);
		
		// for turn notification
		private var turnText:FlxText = new FlxText(470,320,100,"Player's turn!");
		
		
		private var timer:Number = 1;
		private var timerStart:Boolean = false;		
		
		private var background:FlxBackdrop;
		
		private var buttonGroup:FlxGroup = new FlxGroup();
		
		private var inventoryHUD:FlxGroup = new ExploreHUD();
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		public function BattlePlayState(enemyType:String) {
			this.enemyType = enemyType;
		}
		
		override public function create():void {
			FlxG.debug = true;
			FlxG.bgColor = 0xffaaaaaa;
			logic = new BattleLogic(this, enemyType);
			
			maxEnemyLifeBar.makeGraphic(100,12,0xff00aa00);
			enemyLifeBar.makeGraphic(100,12, 0xff00ff00);
			enemyLifeBar.setOriginToCorner();
						
			maxPlayerLifeBar.makeGraphic(100,12,0xff00aa00);
			playerLifeBar.makeGraphic(100,12, 0xff00ff00);
			playerLifeBar.setOriginToCorner();
			
			enemyName.text = logic.enemy.name;
			enemySprite.loadGraphic(Sources.enemyMap[logic.enemy.name], true, false, 300, 300);
			enemySprite.addAnimation("idle", [0]);
			enemySprite.addAnimation("attacked", [1]);
			
			playerName.setFormat("COOKIES",20);
			enemyName.setFormat("COOKIES",20);
			
			playerName.color = 0x01000000;
			enemyName.color = 0x01000000;
			
			attackButton.loadGraphic(Sources.buttonAttack);
			eatButton.loadGraphic(Sources.buttonEat);
			runButton.loadGraphic(Sources.buttonRun);
			
			turnText.size = 10;
			turnText.color = 0xff000000;
		
			var background:FlxSprite = new FlxSprite(0, 0, Sources.BattleBackground);
			add(background);
			
			add(inventoryHUD);
			
			add(maxEnemyLifeBar);
			add(enemyLifeBar);
			add(playerName);
			add(maxPlayerLifeBar);
			add(playerLifeBar);
			add(enemyName);
			add(attackButton);
			//add(switchButton);
			add(runButton);
			add(eatButton);
			//add(candyButton);
			add(enemySprite);
			add(playerSprite);
			add(playerHealthText);
			add(enemyHealthText);
			FlxG.mouse.show();
			
			buttonGroup.add(attackButton);
			//buttonGroup.add(switchButton);
			buttonGroup.add(runButton);
			//buttonGroup.add(candyButton);
			
			add(turnText);
			
			
			drawHealthBar();
		}
		
		public function runTime():void
		{
			//Reduce Number
			timer -= FlxG.elapsed;
			
			
			
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("B")) {
				var s1:String = "", s2:String = "";
				for (var i:int=0; i<logic.player.buffs.length; ++i) {
					if (i) s1 += ", ";
					s1 += logic.player.buffs[i].name + "(" + logic.player.buffs[i].turns + ")";
				}
				for (i=0; i<logic.enemy.buffs.length; ++i) {
					if (i) s2 += ", ";
					s2 += logic.enemy.buffs[i].name + "(" + logic.enemy.buffs[i].turns + ")";
				}
				trace("player: " + logic.player.currentHealth + "/" + logic.player.maxHealth + " weapon: " + logic.player.data.currentWeapon().name + " buffs: " + s1);
				trace("enemy: " + logic.enemy.currentHealth + "/" + logic.enemy.maxHealth + " buffs: " + s2);

			}
			if (timerStart == true){
				runTime();
			}
			if (timer <= 0){
				timer = 1;
				timerStart = false;
				enemySprite.play("idle");
				playerSprite.loadGraphic(Sources.battlePlayer);
			}
			super.update();
		}
		
		public function showHealth():void{
			add(new FlxText(150, 150, 100, logic.player.currentHealth.toString()));
		}
		
		private function drawHealthBar():void {
			var health:Number = logic.playerHealthPercent();
			playerLifeBar.scale.x = health / 100.0;
			
			var e_health:Number = logic.enemyHealthPercent();
			enemyLifeBar.scale.x = e_health / 100.0;
			
			updateHealthText();
		}
		
		public function attackCallback():void {
			drawHealthBar();
			timerStart = true;
			logic.useAttack();
			playerSprite.loadGraphic(Sources.battlePlayerAttack);
			enemySprite.play("attacked");
		}
		

		public function switchCallback():void{
			add(new BattleInventoryMenu(inventoryCallback));
		}
		
		public function inventoryCallback(index:int):void {
			logic.switchWeaponIndex(index);
		}
		
		public function runCallback():void{
			logic.useRun();
		}
		
		public function candyCallback():void{
			timerStart = true;
			logic.useCandy();
			inventoryHUD.update();
			playerSprite.loadGraphic(Sources.battlePlayerEat);
		}
		
		private function updateHealthText():void {
			playerHealthText.text = "Blood Sugar: "+ logic.player.currentHealth + "/" + logic.player.maxHealth;
			enemyHealthText.text = "Health: "+ logic.enemy.currentHealth + "/" + logic.enemy.maxHealth;
		}
		
		public function healthCallback():void {
			drawHealthBar();
		}
		
		public function turnCallback(turn:int):void {
			switch(turn){
				case BattleLogic.ENEMY_TURN:
					attackButton.active = false;
					//switchButton.active = false;
					runButton.active = false;
					//candyButton.active = false;
					updateEnemyText();
					break;
				case BattleLogic.PLAYER_TURN:
					attackButton.active = true;
					//switchButton.active = true;
					runButton.active = true;
					//candyButton.active = true;
					(new FlxTimer()).start(1,1,updatePlayerText);
					break;
				
			}
			
			this.update();
			
		}
		
		public function updateEnemyText():void {
			turnText.text = "Enemy's turn!";
		}
		
		public function updatePlayerText(timer:FlxTimer):void {
			turnText.text = "Player's turn!";
		}
		
		public function attackLogicCallback():void {
			
		}
		
		public function endBattleCallback(status:int):void {			
			switch(status){
				case BattleLogic.ENEMY_WON:
					
					FlxG.switchState(new EndState());
				
				case BattleLogic.PLAYER_WON:
					var candyColor:int = Math.floor(Math.random()*3);
					//var candyDrop:Candy = new Candy(candyColor);
					Inventory.addCandy(candyColor);
					var earningsText:FlxText=new FlxText(260, 200, 200, "You win!");
					earningsText.color = 0x01000000;
					earningsText.text = "You have earned " + Helper.getCandyName(candyColor) + " candy!";
					add(earningsText);
					add(new FlxButton(260,220,"End battle",endBattle));
					buttonGroup.setAll("active",false);
					break;
				
				case BattleLogic.RAN_AWAY:
					logic.player.currentHealth -= 1;
					logic.player.updatePlayerData();
					
					//FlxG.mouse.hide();
					FlxG.switchState(new ExplorePlayState());
					break;
			}
		}
		
		private function endBattle():void
		{
			this.destroy();
			logic.player.updatePlayerData();
			FlxG.switchState(new ExplorePlayState());
		}
	}
}