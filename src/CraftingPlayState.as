package
{
	import org.flixel.*;
	
	public class CraftingPlayState extends FlxState
	{
		private var cauldron:Array = new Array();
		private var cauldronText:FlxText = new FlxText(100, 100, 500, "Cauldron:");
		private var banner:FlxText = new FlxText(100, 300, 500, "");
		
		Sources.fontCookies;
		
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0, Sources.BattleBackground);
			add(background);
			
			add(new ExploreHUD());
			
			var combineButton:FlxButton = new FlxButton(FlxG.width/2 - 40, 410, "COMBINE", combineCandy); // same location as attack button on battle screen
			combineButton.loadGraphic(Sources.buttonCraft);
			add(combineButton);
			
			var doneButton:FlxButton = new FlxButton(560 - 2, 410, "DONE", done); // should be in same location as craft button on explore screen
			doneButton.loadGraphic(Sources.buttonRun);
			add(doneButton);
			
			var redButton:FlxButton = new FlxButton(FlxG.width * 0.65, FlxG.height * 0.94, "", redCandy);
			var blueButton:FlxButton = new FlxButton(FlxG.width * 0.75, FlxG.height * 0.94, "", blueCandy);
			var whiteButton:FlxButton = new FlxButton(FlxG.width * 0.85, FlxG.height * 0.94, "", whiteCandy);
			redButton.loadGraphic(Sources.candyRed);
			blueButton.loadGraphic(Sources.candyBlue);
			whiteButton.loadGraphic(Sources.candyWhite);
			add(redButton);
			add(blueButton);
			add(whiteButton);
			
			cauldronText.color = 0xff0077;
			banner.color = 0x1199ff
			add(this.cauldronText);
			add(this.banner);
			
			FlxG.mouse.show();
		}
		
		private function updateCauldron():void {
			
		}
		
		private function redCandy():void {
			selectCandy(Inventory.COLOR_RED);
		}
		
		private function blueCandy():void {
			selectCandy(Inventory.COLOR_BLUE);
		}
		
		private function whiteCandy():void {
			selectCandy(Inventory.COLOR_WHITE);
		}
		
		private function selectCandy(color:int):void
		{
			if (Inventory.removeCandy(color) && cauldron.length < 3) {
				cauldron.push(color);
				
				var display:Array = new Array();
				for (var i:int = 0; i < cauldron.length; i++)
				{
					var color:int = cauldron[i];
					display.push(Helper.getCandyName(color));
				}
				cauldronText.text = "Cauldron:\n| " + display.join(" | ") + " |";
				banner.text = "";
			}
		}
		
		private function combineCandy():void {
			if (cauldron.length < 3) {
				banner.text = "You have to put 3 candies in the cauldron first!";
			}
			else {
				var weapon:Weapon = CraftLogic.craft(cauldron);
				banner.text = "You got a " + weapon.getDisplayName() + "!\nAttack: " + weapon.attack + " Defense: " + weapon.defense;
				Inventory.addWeapon(weapon);
				cauldron = new Array();
				cauldronText.text = "Cauldron:";
			}
		}
		
		private function done():void {
			for (var i:int = 0; i < cauldron.length; i++)
				{
					var color:int = cauldron[i];
					Inventory.addCandy(color);
				}
			FlxG.switchState(new ExplorePlayState());
		}
	}
}