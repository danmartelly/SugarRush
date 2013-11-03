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
		var logic:BattleLogic = new BattleLogic();
		[Embed(source="../assets/player_front.png")] protected var playerFront:Class;
		override public function create():void{
			FlxG.debug = true;
			FlxG.visualDebug = true;
			FlxG.bgColor = 0xffaaaaaa;
						
			var title:FlxText = new FlxText(50, 50, 100, "Battle state");
			var x:int = FlxG.width /2 + 150;
			var y:int = FlxG.height - 50;
			var attackButton:FlxButton = new FlxButton(x, y, "Attack", attackCallback);
			var switchButton:FlxButton = new FlxButton(x + 85, y, "Switch Weapon", switchCallback);
			var runButton:FlxButton = new FlxButton(x, y + 25, "Run", runCallback);
			var candyButton:FlxButton = new FlxButton(x + 85, y + 25, "Eat Candy", candyCallback);
			
			add(title);
			add(attackButton);
			add(switchButton);
			add(runButton);
			add(candyButton);
			FlxG.mouse.show();
		}
		
		private function attackCallback():void{
			logic.useAttack();
		}
		
		private function switchCallback():void{
//			var inventory:BattleInventoryMenu = new BattleInventoryMenu();
//			var o:FlxBasic = inventory.getFirstAlive();
//			add(o);
//			o.draw();
			var background:FlxSprite = new FlxSprite(220, 140);
			//background.loadGraphic(playerFront);
			//background.width = background.height = 100;
			
			
			background.makeGraphic(100,100,0x000000);
			add(background);
			background.visible = true;
			logic.switchWeapon(new Weapon("n"));
		}
		
		private function runCallback():void{
			logic.useRun();
		}
		
		private function candyCallback():void{
			logic.useCandy();
		}
		
		//enemy HP bar
		//player HP bar
		//menu box
			//consists for four buttons
		//player sprite
		//enemy sprite
	}
}