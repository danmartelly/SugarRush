package
{
	import flash.utils.setInterval;
	
	import org.flixel.FlxBackdrop;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
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
		
		private var buttonWidth:int = 120;
		private var attackButton:FlxButton = new FlxButton(0+2, 410, "", openAttackTab); // +2 for margin
		private var eatButton:FlxButton = new FlxButton(FlxG.width/2-buttonWidth/2, 410, "EAT", openCandyTab);
		private var runButton:FlxButton = new FlxButton(FlxG.width-buttonWidth-2 , 410, "RUN", runCallback); // -2 for margin
		
		const lifeBarWidth:int = 160;
		const lifeBarHeight:int = 18;
			
		private var enemyData:EnemyData;
		private var maxEnemyLifeBar:FlxSprite = new FlxSprite(50, 50);
		private var enemyLifeBar:FlxSprite = new FlxSprite(50, 50);
		private var enemyName:FlxText = new FlxText(50,25, lifeBarWidth,"Enemy Name");
		private var enemyHealthText:FlxText = new FlxText(50, 52, lifeBarWidth, "Health: ?/?");
		
		private var maxPlayerLifeBar:FlxSprite = new FlxSprite(hor,y - 50 - invenBarHeight);
		private var playerLifeBar:FlxSprite = new FlxSprite(hor, y - 50 - invenBarHeight);
		private var playerName:FlxText = new FlxText(hor,y-75-invenBarHeight,75,"Kid");
		private var playerHealthText:FlxText = new FlxText(hor, y - 48 - invenBarHeight, lifeBarWidth, "Blood Sugar: ?/?");
		
		private var playerSprite:FlxSprite = new FlxSprite(25, FlxG.height-325-invenBarHeight, Sources.battlePlayer);
		private var enemySprite:FlxSprite = new FlxSprite(FlxG.width-300, 0);
		
		private var eatObject:FlxSprite = new FlxSprite(225, 150, Sources.candyRed);
		
		// for turn notification
		private var turnText:FlxText = new FlxText(470,320,100,"Player's turn!");
		
		private var invulnTime:Number = 1.;
		
		private var timer:Number = 1;
		private var timerStart:Boolean = false;		
		
		private var background:FlxBackdrop;
		
		private var buttonGroup:FlxGroup = new FlxGroup();
		
		private var inventoryHUD:ExploreHUD = new ExploreHUD();
		
		//invisible button, lays on top of weapons so it's clicked when any weapon is clicked
		private var attackBtnWeapons:FlxButton = new FlxButton(80,FlxG.height-45, "", attackCallback);
		
		Sources.fontCookies;
		
		public function BattlePlayState(enemyData:EnemyData) {
			this.enemyData = enemyData;
		}
		
		override public function create():void {
			
			FlxG.debug = true;
			FlxG.bgColor = 0xffaaaaaa;
			logic = new BattleLogic(this, enemyData);
			
			var widthOfWeapons:int=Inventory.weaponCount()*50 - 10;
			attackBtnWeapons.makeGraphic(widthOfWeapons,45,0x00ffffff);
			
			maxEnemyLifeBar.makeGraphic(lifeBarWidth,lifeBarHeight,0xff00aa00);
			enemyLifeBar.makeGraphic(lifeBarWidth,lifeBarHeight, healthColor(logic.enemyHealthPercent()));
			enemyLifeBar.setOriginToCorner();
						
			maxPlayerLifeBar.makeGraphic(lifeBarWidth,lifeBarHeight,0xff00aa00);
			playerLifeBar.makeGraphic(lifeBarWidth,lifeBarHeight, healthColor(logic.playerHealthPercent()));
			playerLifeBar.setOriginToCorner();
			
			enemyName.text = logic.enemy.name;
			enemySprite.loadGraphic(Sources.enemyBattleSpriteMap[logic.enemy.name], true, false, 300, 300);
			enemySprite.addAnimation("idle", [0]);
			enemySprite.addAnimation("attacked", [1]);
			
			playerName.setFormat("COOKIES",20,0x01000000);
			enemyName.setFormat("COOKIES",20,0x01000000);
			
			attackButton.loadGraphic(Sources.buttonRed);
			eatButton.loadGraphic(Sources.buttonOrange);
			runButton.loadGraphic(Sources.buttonGreen);
			
			turnText.size = 10;
			turnText.color = 0xff000000;
						
			playerHealthText.setFormat("COOKIES", 14, 0xff000000);
			enemyHealthText.setFormat("COOKIES", 14, 0xff000000);
			
			var attackLabel:FlxText=new FlxText(0,0,buttonWidth,"ATTACK");
			var eatLabel:FlxText=new FlxText(0,0,buttonWidth,"EAT");
			var runLabel:FlxText=new FlxText(0,0,buttonWidth,"RUN -1 HP");
			attackLabel.setFormat("COOKIES", 17, 0xffffffff);
			eatLabel.setFormat("COOKIES", 17, 0xffffffff);
			runLabel.setFormat("COOKIES", 17, 0xffffffff);
			attackLabel.alignment = "center";
			eatLabel.alignment = "center";
			runLabel.alignment = "center";
			attackButton.label=attackLabel;
			eatButton.label=eatLabel;
			runButton.label=runLabel;
			attackButton.labelOffset=new FlxPoint(0,0);
			eatButton.labelOffset=new FlxPoint(0,0);
			runButton.labelOffset=new FlxPoint(0,0);
		
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
			add(runButton);
			add(eatButton);
			add(enemySprite);
			add(playerSprite);
			add(playerHealthText);
			add(enemyHealthText);
			FlxG.mouse.show();
			
			buttonGroup.add(attackButton);
			buttonGroup.add(eatButton);
			buttonGroup.add(runButton);
			
			
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
				trace("player: " + logic.player.currentHealth + "/" + logic.player.maxHealth + " weapon: " + logic.player.data.currentWeapon().displayName + " buffs: " + s1);
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
				remove(eatObject);
			}
			super.update();
		}
		
		public function showHealth():void{
			add(new FlxText(150, 150, 100, logic.player.currentHealth.toString()));
		}
		
		private function healthColor(healthPercent:Number):uint {
			if (healthPercent > 50){
				return 0xff00ff00;
			} else if (healthPercent > 25) {
				return 0xffffff00;
			} else {
				return 0xffff0000;
			}
		}
		
		private function drawHealthBar():void {
			var health:Number = logic.playerHealthPercent();
			
			var playerBarColor:uint = healthColor(health);
			playerLifeBar.scale.x = health / 100.0;
			//playerLifeBar.fill(playerBarColor);
			// change color based on health!
			
			var e_health:Number = logic.enemyHealthPercent();
			
			var enemyBarColor:uint = healthColor(e_health);
			enemyLifeBar.scale.x = e_health / 100.0;
			//enemyLifeBar.fill(enemyBarColor);
						
			updateHealthText();
		}
		
		public function openAttackTab():void {
			inventoryHUD.openAttack();
			inventoryHUD.update(); //makes it so switching weapons is doable
			add(attackBtnWeapons); //add the invisible button that actually does the attack
		}
		
		public function attackCallback():void{
			timerStart = true;
			logic.useAttack();
			playerSprite.loadGraphic(Sources.battlePlayerAttack);
			FlxG.play(Sources.vegetableHurt1);
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
		
		public function openCandyTab():void{
			inventoryHUD.update();
			inventoryHUD.openEat();
			
			remove(attackBtnWeapons); //remove invisible button that calls attackCallback
			
			//right now it's just calling the candy callback
			//eventually candycallback should only be called when an object is selected to eat
			candyCallback();
		}
		
		public function candyCallback():void{
			timerStart = true;
			logic.useCandy();
			inventoryHUD.update(); //updates candy count
			playerSprite.loadGraphic(Sources.battlePlayerEat);
			//eatOject.loadGraphic( whatever the player just chose to eat );
			add(eatObject);
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
					var newExploreState = ExplorePlayState.instance;
					newExploreState.setInvincibility(invulnTime);
					
					FlxG.switchState(newExploreState);
					break;
			}
		}
		
		private function endBattle():void
		{
			this.destroy();
			logic.player.updatePlayerData();
			
			var newExploreState = ExplorePlayState.instance;
			newExploreState.setInvincibility(invulnTime);
			
			FlxG.switchState(newExploreState);
		}
	}
}