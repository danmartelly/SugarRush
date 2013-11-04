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
		var logic:BattleLogic = new BattleLogic(voidFn,voidFn, voidFn, voidFn);
		[Embed(source="../assets/player_front.png")] protected var playerFront:Class;
		
		override public function create():void {
			FlxG.debug = true;
			FlxG.visualDebug = true;
			FlxG.bgColor = 0xffaaaaaa;
						
			var x:int = FlxG.width /2 + 150;
			var y:int = FlxG.height - 50;
			var attackButton:FlxButton = new FlxButton(x, y, "Attack", attackCallback);
			var switchButton:FlxButton = new FlxButton(x + 85, y, "Switch Weapon", switchCallback);
			var runButton:FlxButton = new FlxButton(x, y + 25, "Run", runCallback);
			var candyButton:FlxButton = new FlxButton(x + 85, y + 25, "Eat Candy", candyCallback);
			
			var enemyName:FlxText = new FlxText(50,35, 100,"Enemy Name");

			var maxEnemyLifeBar:FlxSprite = new FlxSprite(50,50);
			maxEnemyLifeBar.makeGraphic(100,10,0xff00aa00);
			
			var enemyLifeBar:FlxSprite = new FlxSprite(50, 50);
			enemyLifeBar.makeGraphic(100,10, 0xff00ff00);
			
			add(maxEnemyLifeBar);
			add(enemyLifeBar);
			enemyLifeBar.makeGraphic(50,10,0xff00ff00);
			
			var playerName:FlxText = new FlxText(x,y-65,100,"Kid");
			add(playerName);
			
			var maxPlayerLifeBar:FlxSprite = new FlxSprite(x,y - 50);
			maxPlayerLifeBar.makeGraphic(100,10,0xff00aa00);
			
			var playerLifeBar:FlxSprite = new FlxSprite(x, y - 50);
			playerLifeBar.makeGraphic(100,10, 0xff00ff00);
			
			add(maxPlayerLifeBar);
			add(playerLifeBar);
			playerLifeBar.makeGraphic(50,10,0xff00ff00);
			
			add(enemyName);
			add(attackButton);
			add(switchButton);
			add(runButton);
			add(candyButton);
			FlxG.mouse.show();
		}
		
		private function attackCallback():void {
			logic.useAttack();
		}
		
		private function switchCallback():void{
			add(new BattleInventoryMenu());
			logic.switchWeapon(new Weapon("Candy Cane"));
		}
		
		private function runCallback():void{
			logic.useRun();
		}
		
		private function candyCallback():void{
			logic.useCandy();
		}
	}
}