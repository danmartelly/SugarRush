package
{
	import org.flixel.*;
	
	public class SplashScreenState extends FlxState
	{
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		public var background:FlxSprite;
		private var startText:FlxText;
		private var instrText:FlxText;
		private var creditText:FlxText;
		private var narrText:FlxText;
		
		private var currentScreen:Number=0;
		
		public function SplashScreenState()
		{
			FlxG.mouse.hide(); 
			//initialize/reset all the stats
			Inventory.resetInventory();
			PlayerData.instance.initialize();
			ExplorePlayState.resetInstance();
			
			
			background = new FlxSprite(0,0);
			background.loadGraphic(Sources.SplashScreenBackground);
			add(background);
			
			startText = new FlxText(10, (FlxG.height)-55, FlxG.width-10, "Press ENTER to start!");
			startText.color = 0x01FFFFFF;
			startText.shadow = 0x01000000;
			startText.setFormat("COOKIES",26);
			startText.alignment = "center";
			add(startText);
			
			creditText = new FlxText(10, (FlxG.height)-25, FlxG.width-10, "Press C for credits");
			creditText.color = 0x01FFFFFF;
			creditText.shadow = 0x01000000;
			creditText.setFormat("COOKIES",16);
			creditText.alignment = "center";
			add(creditText);
			
			instrText = new FlxText(10, (FlxG.height)-25, FlxG.width-10, "");
			instrText.color = 0x01FFFFFF;
			instrText.shadow = 0x01000000;
			instrText.setFormat("COOKIES",18);
			instrText.alignment = "center";
			add(instrText);
			
			narrText = new FlxText(30, 50, 400, "");
			narrText.setFormat("COOKIES",20,0x01ffffff,"left",0xffa86d46);
			add(narrText);
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("S")) { //this is for the developers playing the game that want to avoid intro screens
				FlxG.fade(0x00000000, 1, startGame);
			} else if (FlxG.keys.ENTER && currentScreen==4){
				FlxG.fade(0x00000000, 1, startGame);
			} else if (FlxG.keys.C) {
				creditsScreen();
			}else if ((FlxG.keys.ENTER && currentScreen==0)|| (FlxG.mouse.justReleased() && currentScreen!=0)){
				background.loadGraphic(Sources.intros[currentScreen]);
				remove(creditText);
				instrText.text="click to continue";
				instrText.color=0xff000000;
				remove(startText);
				if (currentScreen==0){
					narrText.text="Candyland was a peaceful land\nof joy and sugary goodness,\nand all was well.";
				}else if (currentScreen==1){
					narrText.text="Then one day, strange portals spawned and evil monsters appeared.";
				}else if (currentScreen==2){
					narrText.text="Only one small boy with a propeller hat had the strength to continue and reclaim Candyland.";
				}else if (currentScreen==3){
					//this is instructions
					remove(narrText);
					instrText.color=0xffffffff;
					instrText.size=36;
					instrText.y=155;
					instrText.text="press ENTER to play!";
				}
				currentScreen ++;
			}
			
			/*
			Candyland was a peaceful land of joy and sugary goodness. People of Candyland plucked gumdrops and peppermint patties from treetops and used them to nourish their bodies, to keep their blood sugar level happily high. Children suckled on lollipops, birds drank from honey fountains. All was well. 
			-click to continue - 
			Then one day, strange portals spawned in the four corners of Candyland. Out of these portals came strange leafy beasts. They plundered the villages of Candyland, force feeding small children leafy greens and stealing the candy that had nourished the people of Candyland for so long. 
			-click to continue- 
			Without their candy, the people of Candyland slowly lost their strength. Only one small boy with a propeller hat, who had gorged on candy the night before the attacks, had enough strength to continue. This boy would now embark on the treacherous journey to eliminate the vegetable monsters and restore peace to Candyland once again…
			-click s to start-
			*/
		}
		
		private function startGame():void {
			trace("hi");
			FlxG.switchState(ExplorePlayState.instance);
		}
		
		private function creditsScreen():void {
			var credits:CreditsState = new CreditsState();
			FlxG.switchState(credits);
		}
	}
}