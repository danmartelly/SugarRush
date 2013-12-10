package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class EndState extends FlxState
	{
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		public var background:FlxSprite;
		override public function create(): void
		{
			FlxG.music.stop();
			FlxG.play(Sources.death, 1.0, true);
			background = new FlxSprite(0,0);
			background.loadGraphic(Sources.LoseBackground);
			add(background);
			
			FlxG.worldBounds.x = 0; 
			FlxG.worldBounds.width = 640;
			var text: FlxText;
			
			text = new FlxText(130, 165 , 300, "Your beloved Candyland has been overrun by Vegetables!");
			text.setFormat("COOKIES",15, 0x1FFCF76,"left");
			add(text);
			
			text = new FlxText(130, 200 , FlxG.width, "Press Space to Restart");
			text.setFormat("COOKIES",20,0x1FFCF76,"left");
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