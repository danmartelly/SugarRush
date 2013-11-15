package
{
	import org.flixel.*;
	
	public class SplashScreenState extends FlxState
	{
		[Embed(source="../assets/title.png")] protected var backgroundImg:Class;
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		public var background:FlxSprite;
		private var startText:FlxText;
		
		public function SplashScreenState()
		{
			background = new FlxSprite(0,0);
			background.loadGraphic(backgroundImg);
			add(background);
			
			startText = new FlxText((FlxG.width/3)-15, (FlxG.height)-40, FlxG.width, " Press 'S' to start!");
			startText.color = 0x01FFFFFF;
			startText.shadow = 0x01000000;
			startText.setFormat("COOKIES",26);
			add(startText);
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("S")) {
				FlxG.fade(0x00000000, 1, startGame);
			}
		}
		
		private function startGame():void {
			FlxG.switchState(new ExplorePlayState());
		}
	}
}