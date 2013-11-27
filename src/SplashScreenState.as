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
			//initialize/reset all the stats
			Inventory.resetInventory();
			PlayerData.instance.initialize();
			ExplorePlayState.resetInstance();
			
			
			background = new FlxSprite(0,0);
			background.loadGraphic(backgroundImg);
			add(background);
			
			startText = new FlxText(10, (FlxG.height)-45, FlxG.width, "Press ENTER to start!");
			startText.color = 0x01FFFFFF;
			startText.shadow = 0x01000000;
			startText.setFormat("COOKIES",26);
			startText.alignment = "center";
			add(startText);
			
			instrText = new FlxText(10, (FlxG.height)-25, FlxG.width, "press SPACE for instructions");
			instrText.color = 0x01FFFFFF;
			instrText.shadow = 0x01000000;
			instrText.setFormat("COOKIES",18);
			instrText.alignment = "center";
			//add(instrText);
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("S")) {
				FlxG.fade(0x00000000, 1, startGame);
//			} else if (FlxG.keys.SPACE){
//				background.loadGraphic(Sources.Instructions);
//				add(background);
//				startText.text="";
//				remove(instrText);
			} else if (FlxG.keys.ENTER){
				background.loadGraphic(Sources.Instructions2);
				add(background);
				remove(instrText);
				remove(startText);
				//we can make this an image or just fill text. the possibilities are endless
				startText = new FlxText(30, (FlxG.height)-280, FlxG.width-30, 
					"Your beloved candy land is in danger! \n" +
					"Veggies are invading! \n" +
					"Use your candy weapons to defeat them and reclaim your land! \n" +
					" \n \n " +
					"use mouse to select actions & items, \n use arrow keys for movement" +
					"\n \n Press S to play!");
				startText.color = 0x01FFFFFF;
				startText.shadow = 0x01000000;
				startText.setFormat("COOKIES",26);
				startText.alignment="left";
				add(startText);
			}
		}
		
		private function startGame():void {
			FlxG.switchState(ExplorePlayState.instance);
		}
	}
}