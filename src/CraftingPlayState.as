package
{
	import mx.core.FlexSprite;
	
	import org.flixel.*;
	
	public class CraftingPlayState extends FlxState
	{
		private var cauldron:Array = [-1,-1,-1];
		private var craftTitle:FlxText = new FlxText(10, 20, FlxG.width-10, "Weapon Crafting");
		private var craftInstructions:FlxText = new FlxText(10, 70, FlxG.width-10, "pick 3 candies from your inventory\n\nclick candies in the cauldron to remove");
		private var bannerLabel:FlxText = new FlxText(10, 150, 240, "You got a");
		private var banner:FlxText = new FlxText(10, 165, 240, "");
		private var craftedWeapon:FlxSprite = new FlxSprite(110,230,Sources.AxeGumdrop);
		
		private var candies:Array = new Array(); // contains the FlxButtons in the cauldron
		
		override public function create():void
		{			
			var background:FlxSprite = new FlxSprite(0, 0, Sources.BattleBackground);
			add(background);
			
			add(new ExploreHUD(false));
			
			craftTitle.setFormat("COOKIES",26,0xFF7b421c,"left");
			craftInstructions.setFormat("COOKIES",15,0xFF7b421c,"left");
			add(this.craftTitle);
			add(this.craftInstructions);
			
			var cauldronWidth:int = 400;
			var cauldronImage:FlxSprite = new FlxSprite(FlxG.width - cauldronWidth, -50, Sources.Cauldron);
			cauldronImage.scale = new FlxPoint(0.8,0.8);
			add(cauldronImage);
			
			var candyOffset:int = 50;
			var candyWidth:int = 75;
			var candyX:int = FlxG.width - cauldronWidth + (cauldronWidth/2) - candyWidth/2;
			var candyY:int = 270;
			
			var candy1:FlxButton = new FlxButton(candyX - candyOffset, candyY, "", removeCandy1);
			var candy2:FlxButton = new FlxButton(candyX + candyOffset, candyY, "", removeCandy2);
			var candy3:FlxButton = new FlxButton(candyX + 5, candyY - 90, "", removeCandy3);
			candies = [candy1, candy2, candy3];
			for (var i:int = 0; i < 3; i++) {
				var candyButton:FlxButton = candies[i];
				candyButton.loadGraphic(Sources.candyDisabledBig);
				//candyButton.scale = new FlxPoint(5, 5);
				add(candyButton);
			}
			
			var combineButton:FlxButton = new FlxButton(FlxG.width/2-60, 410, "", combineCandy); // same location as attack button on battle screen
			combineButton.loadGraphic(Sources.buttonBlue);
			var combineLabel:FlxText=new FlxText(0,0,120,"COMBINE");
			combineLabel.setFormat("COOKIES", 17, 0xffffffff);
			combineLabel.alignment = "center";
			combineButton.label=combineLabel;
			combineButton.labelOffset=new FlxPoint(0,0);
			add(combineButton);
			
			var doneButton:FlxButton = new FlxButton(FlxG.width-120-2, 410, "", done); // should be in same location as craft button on explore screen
			doneButton.loadGraphic(Sources.buttonGreen);
			var doneLabel:FlxText=new FlxText(0,0,120,"DONE");
			doneLabel.setFormat("COOKIES", 17, 0xffffffff);
			doneLabel.alignment = "center";
			doneButton.label=doneLabel;
			doneButton.labelOffset=new FlxPoint(0,0);
			add(doneButton);
			
			var redButton:FlxButton = new FlxButton(FlxG.width * 0.63, FlxG.height * 0.92, "", redCandy);
			var blueButton:FlxButton = new FlxButton(FlxG.width * 0.73, FlxG.height * 0.92, "", blueCandy);
			var whiteButton:FlxButton = new FlxButton(FlxG.width * 0.83, FlxG.height * 0.92, "", whiteCandy);
			redButton.loadGraphic(Sources.candyRed);
			blueButton.loadGraphic(Sources.candyBlue);
			whiteButton.loadGraphic(Sources.candyWhite);
			add(redButton);
			add(blueButton);
			add(whiteButton);

			bannerLabel.setFormat("COOKIES",15,0xff7b421c);
			bannerLabel.visible=false;
			add(bannerLabel);
			banner.setFormat("COOKIES",20,0xFF7b421c);
			add(this.banner);
			craftedWeapon.visible=false;
			add(craftedWeapon);
			
			FlxG.mouse.load(Sources.cursor);
			FlxG.mouse.show();
		}
		
		private function updateCauldron():void {
			
		}
		
		private function redCandy():void {
			selectCandy(Inventory.COLOR_RED, Sources.candyRedBig);
		}
		
		private function blueCandy():void {
			selectCandy(Inventory.COLOR_BLUE, Sources.candyBlueBig);
		}
		
		private function whiteCandy():void {
			selectCandy(Inventory.COLOR_WHITE, Sources.candyWhiteBig);
		}
		
		private function selectCandy(color:int, image:Class):void
		{
			var emptySlot:int = cauldron.indexOf(-1);
			if (emptySlot > -1 && Inventory.removeCandy(color)) {
				FlxG.play(Sources.select);
				cauldron[emptySlot] = color;
				FlxButton(candies[emptySlot]).loadGraphic(image);
				banner.text = "";
				craftedWeapon.visible=false;
				bannerLabel.visible=false;
			}
		}
		
		private function combineCandy():void {
			craftedWeapon.visible=false;
			bannerLabel.visible=false;
			if (cauldron.indexOf(-1) > -1) {
				FlxG.play(Sources.error);
				banner.text = "You have to put 3 candies in the cauldron first!";
			}
			else if (Inventory.weaponCount() < Inventory.MAX_WEAPONS) {
				// stuff related to keeping track of candy combination -> weapon mappings is in Craftlogic.as
				FlxG.play(Sources.craftWeapon);
				var weapon:Weapon = CraftLogic.craft(cauldron);
				bannerLabel.visible=true;
				banner.text = weapon.displayName;// + "!\nAttack: " + weapon.attack + " Defense: " + weapon.defense;
				craftedWeapon.loadGraphic(weapon.image);
				craftedWeapon.visible=true;
				Inventory.addWeapon(weapon);
				cauldron = [ -1, -1, -1];
				for (var i:int = 0; i < 3; i++) {
					FlxButton(candies[i]).loadGraphic(Sources.candyDisabledBig);
				}
			} else {
				FlxG.play(Sources.error);
				banner.text = "Your inventory is full. Eat a weapon to make room for more!";
			}
		}
		
		private function removeCandy1():void {
			removeCandy(0); // to index at 0
		}
		
		private function removeCandy2():void {
			removeCandy(1);
		}
		
		private function removeCandy3():void {
			removeCandy(2);
		}
		
		private function removeCandy(position:int):void {
			var currentCandy:int = cauldron[position];
			if (currentCandy > -1) {
				FlxG.play(Sources.deselect);
				Inventory.addCandy(currentCandy);
				cauldron[position] = -1;
				FlxButton(candies[position]).loadGraphic(Sources.candyDisabledBig);
			}
		}
		
		private function done():void {
			for (var i:int = 0; i < cauldron.length; i++)
				{
					var color:int = cauldron[i];
					Inventory.addCandy(color);
				}
			FlxG.switchState(ExplorePlayState.instance);
		}
	}
}