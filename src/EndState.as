package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class EndState extends FlxState
	{
		
		override public function create(): void
		{
			
			FlxG.worldBounds.x = 0; 
			FlxG.worldBounds.width = 640;
			var text: FlxText;
			text = new FlxText(40, FlxG.height / 2 - 80, FlxG.width, "Game Over!");
			text.size = 35;
			text.alignment = "left";
			add(text);
			
			text = new FlxText(30, FlxG.height / 2 , FlxG.width, "Your beloved Candyland has been overrun by Vegetables");
			text.size = 20;
			text.alignment = "left";
			add(text);
			
			text = new FlxText(30, FlxG.height / 2 + 80 , FlxG.width, "Press Space to Restart");
			text.size = 20;
			text.alignment = "left";
			add(text);
			
			
		}
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.SPACE) {
				FlxG.switchState(new SplashScreenState());
			}
		}
		
	}
	
}