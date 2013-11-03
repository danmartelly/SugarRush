package
{
	import org.flixel.*;
	
	public class BattlePlayState extends FlxState
	{
		override public function create():void{
			FlxG.bgColor = 0xffaaaaaa;
			
			var title:FlxText = new FlxText(50, 50, 100, "Battle state");
			var attackButton:FlxButton = new FlxButton(0, 0, "Attack", attackCallback);
			attackButton.width = 50;
			var switchButton:FlxButton = new FlxButton(FlxG.width /2, FlxG.height + 25, "Switch Weapon", switchCallback);
			var runButton:FlxButton = new FlxButton(FlxG.width / 2 + 10, FlxG.height, "Run", runCallback);
			var candyButton:FlxButton = new FlxButton(FlxG.width / 2 + 10, FlxG.height + 25, "Eat Candy", candyCallback);
			
			add(title);
			add(attackButton);
			add(switchButton);
			add(runButton);
			add(candyButton);
			FlxG.mouse.show();
		}
		
		private function attackCallback():void{
			
		}
		
		private function switchCallback():void{
			
		}
		
		private function runCallback():void{
			
		}
		
		private function candyCallback():void{
			
		}
		
		//enemy HP bar
		//player HP bar
		//menu box
			//consists for four buttons
		//player sprite
		//enemy sprite
	}
}