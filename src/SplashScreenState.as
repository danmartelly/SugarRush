package
{
	import org.flixel.*;
	
	public class SplashScreenState extends FlxState
	{
		[Embed(source="../assets/title.png")] protected var backgroundImg:Class;
		
		public var background:FlxSprite;
		private var startText:FlxText;
		
		public function SplashScreenState()
		{
			background = new FlxSprite(0,0);
			background.loadGraphic(backgroundImg);
			add(background);
			
			startText = new FlxText(2*(FlxG.width/3) - 5, (FlxG.height/2) + 10, FlxG.width, "Press 'S' to start!");
			startText.size = 18;
			startText.color = 0x01FFFFFF;
			startText.shadow = 0x01000000;
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