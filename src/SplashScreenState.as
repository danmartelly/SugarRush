package
{
	import org.flixel.*;
	
	public class SplashScreenState extends FlxState
	{
		[Embed(source="../assets/backdrops/title.png")] protected var backgroundImg:Class;
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		public var background:FlxSprite;
		private var startText:FlxText;
		private var instrText:FlxText;
		
		public function SplashScreenState()
		{
			background = new FlxSprite(0,0);
			background.loadGraphic(backgroundImg);
			add(background);
			
			startText = new FlxText(10, (FlxG.height)-55, FlxG.width, " Press S to start!");
			startText.color = 0x01FFFFFF;
			startText.shadow = 0x01000000;
			startText.setFormat("COOKIES",26);
			startText.alignment = "center";
			add(startText);
			
			instrText = new FlxText(10, (FlxG.height)-25, FlxG.width, " press I for instructions");
			instrText.color = 0x01FFFFFF;
			instrText.shadow = 0x01000000;
			instrText.setFormat("COOKIES",18);
			instrText.alignment = "center";
			add(instrText);
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("S")) {
				FlxG.fade(0x00000000, 1, startGame);
			} else if (FlxG.keys.justPressed("I")){
				FlxG.switchState(new InstructionsState());
			}
		}
		
		private function startGame():void {
			trace("hi");
			FlxG.switchState(ExplorePlayState.instance);
		}
	}
}