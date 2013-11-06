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
		var logic:BattleLogic = new BattleLogic(this);
		[Embed(source="../assets/player_front.png")] protected var playerFront:Class;
		
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
		
		override public function create():void {
			FlxG.debug = true;
			FlxG.visualDebug = true;
			FlxG.bgColor = 0xffaaaaaa;
						

			maxEnemyLifeBar.makeGraphic(100,10,0xff00aa00);
			enemyLifeBar.makeGraphic(100,10, 0xff00ff00);
			enemyLifeBar.setOriginToCorner();
			
			var playerName:FlxText = new FlxText(x,y-65,100,"Kid");
			
			maxPlayerLifeBar.makeGraphic(100,10,0xff00aa00);
			playerLifeBar.makeGraphic(100,10, 0xff00ff00);
			playerLifeBar.setOriginToCorner();
			
			
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
			FlxG.mouse.show();
		}
		
		public function attackCallback():void {
			logic.useAttack();
		}
		
		public function switchCallback():void{
			add(new BattleInventoryMenu());
			logic.switchWeapon(new Weapon("Candy Cane"));
		}
		
		public function runCallback():void{
			logic.useRun();
		}
		
		public function candyCallback():void{
			logic.useCandy();
		}
		
		public function healthCallback():void {
			add(new FlxText(10,10,100,"in health call back"));
			
			var health:Number = logic.playerHealthPercent();
			add(new FlxText(10,20,100, "health = " + health));
			
			playerLifeBar.scale.x = health / 100.0;
			
			var e_health:Number = logic.enemyHealthPercent();
			enemyLifeBar.scale.x = e_health / 100.0;
			
			
		}
		
		public function turnCallback(turn:int):void {
			add(new FlxText(10,60,100,"in turnCallback"));
			
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
					PlayerData.instance.health -= 1;
					FlxG.switchState(ExplorePlayState);
					break;
			}
		}
	}
}