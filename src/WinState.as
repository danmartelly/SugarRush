package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class WinState extends FlxState
	{
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		public var background:FlxSprite;
		override public function create(): void
		{
			background = new FlxSprite(0,0);
			background.loadGraphic(Sources.WinBackground);
			add(background);
			
			FlxG.worldBounds.x = 0; 
			FlxG.worldBounds.width = 640;
			var text: FlxText;
			
			text = new FlxText(0, 440 , FlxG.width, "Press SPACE to play again!");
			text.setFormat("COOKIES",20,0x1FFCF76,"center");
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