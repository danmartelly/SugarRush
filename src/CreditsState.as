package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class CreditsState extends FlxState
	{
		public var background:FlxSprite;	
		private var creditText:FlxText;
		private var returnSplashText:FlxText;
		public static var instance:FlxState;
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		
		override public function create(): void
		{
			background = new FlxSprite(0,0);
			background.loadGraphic(Sources.Instructions2);
			add(background);
			
			creditText = new FlxText(10, (FlxG.height)/2.0, FlxG.width, "created by Stephanie Gu, Lili Sun, Daniel Martelly, Ethan Sherbondy, " +
				"Nathan Pinsker, Tyler Laprade, Walter Menendez, Tristan Daniels, Jack Li, Tom Roberts");
			creditText.color = 0x01FFFFFF;
			creditText.shadow = 0x01000000;
			creditText.setFormat("COOKIES", 26);
			creditText.alignment = "center";
			add(creditText);
			
			returnSplashText = new FlxText(10, (FlxG.height)-100, FlxG.width, "press ENTER to return");
			returnSplashText.color = 0x01FFFFFF;
			returnSplashText.shadow = 0x01000000;
			returnSplashText.setFormat("COOKIES", 20);
			returnSplashText.alignment = "center";
			add(returnSplashText);
		}
		
		override public function update():void {
			if (FlxG.keys.ENTER) 
			{
				FlxG.switchState(new SplashScreenState());
			}
		}
	}
}