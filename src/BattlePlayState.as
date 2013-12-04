package
{
	import org.flixel.FlxBackdrop;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	
	// need to figure out what's up with timing. Currently not transitioning properly to enemy turn and
	// not properly entering idle state...
	
	public class BattlePlayState extends FlxState
	{
		private var voidFn:Function = function():void
		{
		};
		private var logic:BattleLogic = null;
		
		private var hor:int = FlxG.width - 180;
		private var y:int = FlxG.height; //- 50;
		private var invenBarHeight:int = FlxG.height * 0.10 + 25; //25 is height of buttons
		
		private var buttonWidth:int = 120;
		private var attackButton:FlxButton = new FlxButton(0+2, 410, "", openAttackTab); // +2 for margin
		private var runButton:FlxButton = new FlxButton(FlxG.width-buttonWidth-2 , 410, "RUN", runCallback); // -2 for margin
	
		const lifeBarWidth:int = 160;
		const lifeBarHeight:int = 18;
		
		private var dmgFlickerTime:Number = 1.0;
		private var enemy:ExploreEnemy;
		private var enemyData:BattleEnemy;
		private var maxEnemyLifeBarPos:FlxPoint = new FlxPoint(hor-30, FlxG.height-invenBarHeight-350);
		private var maxEnemyLifeBar:FlxSprite = new FlxSprite(maxEnemyLifeBarPos.x, maxEnemyLifeBarPos.y);
		private var enemyLifeBar:FlxSprite = new FlxSprite(maxEnemyLifeBarPos.x, maxEnemyLifeBarPos.y);
		
		private var enemyName:FlxText = new FlxText(maxEnemyLifeBarPos.x, maxEnemyLifeBarPos.y-20, lifeBarWidth,"Enemy Name");
		private var enemyHealthText:FlxText = new FlxText(maxEnemyLifeBarPos.x, maxEnemyLifeBarPos.y, lifeBarWidth, "Health: ?/?");
		private var buffText:FlxText = new FlxText(maxEnemyLifeBarPos.x, maxEnemyLifeBarPos.y-70, lifeBarWidth, "");
		
		private var playerLifeBarPos:FlxPoint = new FlxPoint(50, FlxG.height-invenBarHeight-350);  
		private var maxPlayerLifeBar:FlxSprite = new FlxSprite(playerLifeBarPos.x, playerLifeBarPos.y);
		private var playerLifeBar:FlxSprite = new FlxSprite(playerLifeBarPos.x, playerLifeBarPos.y);
		private var playerName:FlxText = new FlxText(playerLifeBarPos.x, playerLifeBarPos.y-20,75, "Kid");
		private var playerHealthText:FlxText = new FlxText(playerLifeBarPos.x, playerLifeBarPos.y, lifeBarWidth, "Blood Sugar: ?/?");
		
		private var playerSpritePos:FlxPoint = new FlxPoint(10, FlxG.height - 325 - invenBarHeight); 
		private var playerSprite:FlxSprite = new FlxSprite(playerSpritePos.x, playerSpritePos.y, Sources.battlePlayer);
		private var enemySpritePos:FlxSprite = new FlxSprite(350, FlxG.height - 300 - invenBarHeight);
		private var enemySprite:FlxSprite = new FlxSprite(enemySpritePos.x, enemySpritePos.y);
		
		private var eatObject:FlxSprite = new FlxSprite(225, 150, Sources.candyRed);
		
		// for turn notification
		private var turnText:FlxText = new FlxText(250,30,200,"Player's turn!");	
		private var dmgInfo:FlxText = new FlxText(120, FlxG.height - 400, 400, "");
		
		private var invulnTime:Number = 2.0;
		private var background:FlxBackdrop;
		private var buttonGroup:FlxGroup = new FlxGroup();
		private var inventoryHUD:ExploreHUD = new ExploreHUD();
		private var isEndBattle:Boolean = false;
		
		//invisible button, lies on top of weapons so it's clicked when any weapon is clicked
		private var attackBtnWeapons : FlxButton = new FlxButton(80, FlxG.height - 45, "", attackCallback);
		private var eatBtnCandy:FlxButton = new FlxButton(80,FlxG.height-45,"");
		
		Sources.fontCookies;
		
		public function BattlePlayState(enemy:ExploreEnemy, enemyData:BattleEnemy)
		{
			this.enemy = enemy;
			this.enemyData = enemyData;
		}
		
		override public function create():void {
			FlxG.debug = true;
			FlxG.bgColor = 0xffaaaaaa;
			logic = new BattleLogic(this, enemyData);
			
			var widthOfWeapons:int=Inventory.weaponCount()*50 - 10;
			attackBtnWeapons.makeGraphic(widthOfWeapons,45,0x00ffffff);
			eatBtnCandy.makeGraphic(widthOfWeapons,45,0x00ffffff);
			
			maxEnemyLifeBar.makeGraphic(lifeBarWidth, lifeBarHeight, 0xff00aa00);
			enemyLifeBar.makeGraphic(lifeBarWidth, lifeBarHeight, healthColor(logic.enemyHealthPercent()));
			enemyLifeBar.setOriginToCorner();
			
			maxPlayerLifeBar.makeGraphic(lifeBarWidth, lifeBarHeight, 0xff00aa00);
			playerLifeBar.makeGraphic(lifeBarWidth, lifeBarHeight, healthColor(logic.playerHealthPercent()));
			playerLifeBar.setOriginToCorner();
			
			enemyName.text = logic.enemy.name;
			enemySprite.loadGraphic(Sources.enemyBattleSpriteMap[logic.enemy.name], true, false, 300, 300);
			
			enemySprite.addAnimation("idle", [0]);
			enemySprite.addAnimation("attacked", [1]);
			enemySprite.addAnimation("attack", [2]);
			enemySprite.addAnimation("freeze", [3]);
			enemySprite.addAnimation("burn", [4]);
			
			playerName.setFormat("COOKIES", 20, 0x01000000);
			enemyName.setFormat("COOKIES", 20, 0x01000000);
			
			attackButton.loadGraphic(Sources.buttonRed);
			runButton.loadGraphic(Sources.buttonGreen);
			
			turnText.setFormat("COOKIES",20,0xff000000);
			dmgInfo.setFormat("COOKIES", 20, 0xff000000, "center");
			buffText.setFormat("COOKIES", 15, 0xffaa00aa);
			
			playerHealthText.setFormat("COOKIES", 14, 0xff000000);
			enemyHealthText.setFormat("COOKIES", 14, 0xff000000);
			
			var attackLabel:FlxText=new FlxText(0,0,buttonWidth,"ATTACK");
			var runLabel:FlxText=new FlxText(0,0,buttonWidth,"RUN -1 HP");
			attackLabel.setFormat("COOKIES", 17, 0xffffffff);
			runLabel.setFormat("COOKIES", 17, 0xffffffff);
			attackLabel.alignment = "center";
			runLabel.alignment = "center";
			attackButton.label=attackLabel;
			runButton.label=runLabel;
			attackButton.labelOffset=new FlxPoint(0,0);
			runButton.labelOffset=new FlxPoint(0,0);
			
			var background:FlxSprite = new FlxSprite(0, 0, Sources.BattleBackground);
			add(background);
						
			add(inventoryHUD);
			
	
			add(enemyName);
			add(attackButton);
			add(runButton);
			add(enemySprite);
			add(playerSprite);
			add(maxEnemyLifeBar);
			add(enemyLifeBar);
			add(playerName);
			add(maxPlayerLifeBar);
			add(playerLifeBar);
			add(playerHealthText);
			add(enemyHealthText);
			add(dmgInfo);
			FlxG.mouse.show();
			
			buttonGroup.add(attackButton);
			buttonGroup.add(runButton);
			buttonGroup.add(attackBtnWeapons);
			
			add(turnText);
			add(buffText);
			
			drawHealthBar();
			inventoryHUD.eatFunction = useCandyFn(this);
		}
		
		// handle key presses (cheats/debugging)
		override public function update():void {
			if (FlxG.keys.justPressed("B")) {
				var s1:String = "", s2:String = "";
				for (var i:int = 0; i < logic.player.buffs.length; ++i)
				{
					if (i)
						s1 += ", ";
					s1 += logic.player.buffs[i].name + "(" + logic.player.buffs[i].turns + ")";
				}
				for (i = 0; i < logic.enemy.buffs.length; ++i)
				{
					if (i)
						s2 += ", ";
					s2 += logic.enemy.buffs[i].name + "(" + logic.enemy.buffs[i].turns + ")";
				}
				trace("player: " + logic.player.currentHealth + "/" + logic.player.maxHealth + " weapon: " + Inventory.weapons[logic.player.data.currentWeaponIndex] + " buffs: " + s1);
				trace("enemy: " + logic.enemy.currentHealth + "/" + logic.enemy.maxHealth + " buffs: " + s2);
			}
			
			if (FlxG.keys.SPACE)
			{
				if (isEndBattle)
				{
					//same as the button press
					endBattle();
				}
			}
			
			super.update();
		}
		
		public function useCandyFn(self:BattlePlayState):Function {
			return function(candy:int, healAmount:Number):void {
				self.playerSprite.loadGraphic(Sources.battlePlayerEat);
				self.eatObject.loadGraphic(Sources.candies[candy]);
				add(eatObject);	
				self.logic.useCandy(healAmount);
			};
		}
		
		// return enemy and player sprites to idle state
		public function returnToIdle():void {
			enemySprite.play("idle");
			dmgInfo.text = "";
			playerSprite.loadGraphic(Sources.battlePlayer);
			if (eatObject.visible)
			{
				remove(eatObject);
			}
		}
		
		public function showHealth():void
		{
			//add(new FlxText(150, 150, 100, logic.player.currentHealth.toString()));
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
			var health:Number = logic.playerHealthPercent();
			
			playerLifeBar.scale.x = health / 100.0;
			var playerBarColor:uint = healthColor(health);
			playerLifeBar.fill(playerBarColor);
			// change color based on health!
			
			var e_health:Number = logic.enemyHealthPercent();
			enemyLifeBar.scale.x = e_health / 100.0;
			//var enemyBarColor:uint = healthColor(e_health);
			//enemyLifeBar.fill(enemyBarColor);
			
			updateHealthText();
		}
		
		public function openAttackTab():void
		{
			inventoryHUD.openAttack();
			inventoryHUD.update(); //makes it so switching weapons is doable
			add(attackBtnWeapons); //add the invisible button that actually does the attack
			remove(eatBtnCandy);
		}
		
		public function attackCallback():void{
			var dmg:Number=logic.useAttack();
			var playerFlags:Array = logic.getPlayerFlags();
			playerSprite.loadGraphic(Sources.battlePlayerAttack);
			FlxG.play(Sources.vegetableHurt1);
			enemySprite.play("attacked");
			
			if (playerFlags && playerFlags[0] == 'crit') {
				dmgInfo.text = "CRITICAL HIT for " + dmg + " damage!";
			}
			else {
				dmgInfo.text="You did " + dmg + " damage!";
			}
			(new FlxTimer()).start(1,1,updateBuff(this));
		}
		
		public function switchCallback():void
		{
			add(new BattleInventoryMenu(inventoryCallback));
		}
		
		public function inventoryCallback(index:int):void
		{
			logic.switchWeaponIndex(index);
		}
		
		public function runCallback():void
		{
			logic.useRun();
		}
		
		public function openCandyTab():void{
			add(eatBtnCandy);
			remove(attackBtnWeapons); //remove invisible button that calls attackCallback
			inventoryHUD.openEat();
			inventoryHUD.update();
		}
				
		private function updateHealthText():void {
			playerHealthText.text = "Blood Sugar: "+ logic.player.currentHealth + "/" + logic.player.maxHealth;
			enemyHealthText.text = "Health: "+ logic.enemy.currentHealth + "/" + logic.enemy.maxHealth;
		}
		
		public function healthCallback():void {
			// synchronize player health...
			PlayerData.instance.currentHealth = logic.player.currentHealth;
			this.drawHealthBar();
		}
		
		public function updateBuff(that:BattlePlayState):Function {
			return function(timer:FlxTimer):void {
				var buffText:String = that.updateBuffText();
				that.enemySprite.play(buffText);
			};
		}	
		
		public function enemyAttackCallback(damage:Number):void {
			switch(logic.enemy.name){
				case "broccoli":
					dmgInfo.text = "The broccoli used arm thrust! \n You took " + damage + " damage!";
					break;
				case "tomato":
					dmgInfo.text = "The tomato pukes in your face! \n You took " + damage + " damage!";
					break;
				case "carrot":
					dmgInfo.text = "The carrot tried to stab you! \n You took " + damage + " damage!";
					break;
				case "eggplant":
					dmgInfo.text = "The eggplant used booty bump! \n You took " + damage + " damage!";
					break;
				case "lettuce":
					dmgInfo.text = "The lettuce used razor leaf! \n You took " + damage + " damage!";
					break;
				case "onion":
					dmgInfo.text = "The onion made a sad puppy face!  \n You took " + damage + " damage!";
					break;
			}
			
			var enemyFlags = logic.getEnemyFlags();
			if (enemyFlags[0] && enemyFlags[0] == 'frozen') {
				dmgInfo.text = "The " + logic.enemy.name + " is frozen!";
			}
			else {
				enemySprite.play("attack");
				playerLifeBar.flicker(dmgFlickerTime);
			}
		}
		
		public function turnCallback(turn:int):void {
			var self:BattlePlayState = this;
			
			switch(turn){
				case BattleLogic.ENEMY_TURN:
					attackButton.active = false;
					runButton.active = false;
					attackBtnWeapons.active = false;
					updateEnemyText();
					break;
				case BattleLogic.PLAYER_TURN: 
					attackButton.active = true;
					runButton.active = true;
					attackBtnWeapons.active = true;
					(new FlxTimer()).start(2,1,updatePlayerText(self));
					break;
				default:
					break;
			}
			
			//updateBuffText();
			this.update();
		}
		
		public function updateEnemyText():void
		{
			turnText.text = "Enemy's turn!";
		}
		
		public function updatePlayerText(self:BattlePlayState):Function {
			return function(): void {
				self.turnText.text = "Player's turn!";
				self.returnToIdle();
			};
		}
		
		public function updateBuffText():String
		{
			switch(enemyData.getBuffText()) {
				case "Burn":
					buffText.text = "Burnt! 1 damage";
					return "burn";
				case "Ignite":
					buffText.text = "Burnt! 2 damage";
					return "burn";
				case "Freeze":
				case "Deep Freeze":
					buffText.text = "Frozen!";
					return "freeze";
				default:
					return "idle";
			}
		}

		public function endBattleCallback(status:int):void {			
			switch(status){
				case BattleLogic.ENEMY_WON:
					
					FlxG.switchState(new EndState());
				
				case BattleLogic.PLAYER_WON: 
					isEndBattle = true;
					var back:FlxSprite = new FlxSprite(0, 0);
					back.makeGraphic(FlxG.width, FlxG.height, 0x77000000);
					add(back);
					
					var candyColor:int = Math.floor(Math.random() * 3);
					//var candyDrop:Candy = new Candy(candyColor);
					Inventory.addCandy(candyColor);
					var earningsText:FlxText = new FlxText(0, 180, FlxG.width, "You win!\n" + "You have earned " + Helper.getCandyName(candyColor) + " candy!");
					earningsText.setFormat("COOKIES", 20, 0xffffffff, "center");
					add(earningsText);
					
					//i just want a picture :<
					var candyPic:FlxSprite = new FlxSprite(FlxG.width / 2 - 15, 230);
					if (Helper.getCandyName(candyColor) == "red")
					{
						candyPic.loadGraphic(Sources.candyRed);
					}
					else if (Helper.getCandyName(candyColor) == "blue")
					{
						candyPic.loadGraphic(Sources.candyBlue);
					}
					else
					{
						candyPic.loadGraphic(Sources.candyWhite);
					}
					add(candyPic);
					
					var instructions:FlxText=new FlxText(0,270, FlxG.width, "press SPACE to end battle");
					instructions.setFormat("COOKIES",15,0xffffffff,"center");
					add(instructions);
					
					//add(new FlxButton(260,220,"End battle",endBattle));
					
					buttonGroup.setAll("active", false);
					break;
				
				case BattleLogic.RAN_AWAY: 
					logic.player.currentHealth -= 1;
					logic.player.updatePlayerData();
					switchToExplore();
					break;
			}
		}
		
		private function switchToExplore():void {
			var newExploreState:ExplorePlayState = ExplorePlayState.instance;
			newExploreState.setInvincibility(invulnTime);
			FlxG.switchState(newExploreState);
		}
		
		private function endBattle():void
		{
			//this.destroy();
			enemy.kill();
			logic.player.updatePlayerData();
			switchToExplore();
		}
	}
}