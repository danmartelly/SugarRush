package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class InstructionsState extends FlxState
	{
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		public var background:FlxSprite;
		override public function create(): void
		{
			background = new FlxSprite(0,0);
			background.loadGraphic(Sources.Instructions);
			add(background);
			
			FlxG.worldBounds.x = 0; 
			FlxG.worldBounds.width = 640;
			var text: FlxText;
			
			text = new FlxText(10, 375 , FlxG.width, "press S to start!");
			text.setFormat("COOKIES",20,0x1ffffff);
			text.alignment = "center";
			add(text);
			
			
		}
		override public function update():void
		{
			super.update();
			if (FlxG.keys.justPressed("S")) {
				FlxG.switchState(new ExplorePlayState());
			}
		}
		
	}
	
}