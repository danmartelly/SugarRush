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
			
			add(maxEnemyLifeBar);
			add(enemyLifeBar);
			enemyLifeBar.makeGraphic(100,10,0xff00ff00);
			
			var playerName:FlxText = new FlxText(x,y-65,100,"Kid");
			add(playerName);
			
			var maxPlayerLifeBar:FlxSprite = new FlxSprite(x,y - 50);
			maxPlayerLifeBar.makeGraphic(100,10,0xff00aa00);
			
			var playerLifeBar:FlxSprite = new FlxSprite(x, y - 50);
			playerLifeBar.makeGraphic(100,10, 0xff00ff00);
			
			add(maxPlayerLifeBar);
			add(playerLifeBar);
			playerLifeBar.makeGraphic(100,10,0xff00ff00);
			
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
			var health:Number = logic.playerHealthPercent();
			playerLifeBar.makeGraphic(health, 10, 0xff00ff00);
			health = logic.enemyHealthPercent();
			enemyLifeBar.makeGraphic(health, 10, 0xff00ff00);
		}
		
		public function turnCallback():void {
			
		}
		
		public function attackLogicCallback():void {
			
		}
		
		public function endBattleCallback():void {
			
		}
	}
}