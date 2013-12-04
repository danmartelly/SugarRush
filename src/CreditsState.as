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
		private var creditTitle:FlxText;
		private var returnSplashText:FlxText;
		public static var instance:FlxState;
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		
		override public function create(): void
		{
			background = new FlxSprite(0,0);
			background.loadGraphic(Sources.Instructions2);
			add(background);
			
			creditTitle = new FlxText(50,250, FlxG.width-50, "created by:");
			creditTitle.setFormat("COOKIES",15,0xffffffff,"left");
			add(creditTitle);
			
			creditText = new FlxText(70, 270, FlxG.width-70, "Stephanie Gu, Lili Sun, Daniel Martelly, Ethan Sherbondy, " +
				"Nathan Pinsker, Tyler Laprade, Walter Menendez, Tristan Daniels, Jack Li, Tom Roberts");
			creditText.setFormat("COOKIES", 20,0xffffffff,"left");
			add(creditText);
			
			returnSplashText = new FlxText(10, (FlxG.height)-40, FlxG.width-10, "press ENTER to return");
			returnSplashText.setFormat("COOKIES", 20,0xffffffff,"center");
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