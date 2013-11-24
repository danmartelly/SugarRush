package
{
	import mx.core.FlexSprite;
	import org.flixel.*;
	
	public class CraftingPlayState extends FlxState
	{
		private var cauldron:Array = [-1,-1,-1];
		private var banner:FlxText = new FlxText(0, 380, 500, "");
		
		var candies:Array = new Array(); // contains the FlxButtons in the cauldron
		
		override public function create():void
		{
			banner.setFormat();
			
			var background:FlxSprite = new FlxSprite(0, 0, Sources.BattleBackground);
			add(background);
			
			add(new ExploreHUD());
			
			var cauldronWidth:int = 400;
			var cauldronImage:FlxSprite = new FlxSprite(FlxG.width / 2 - cauldronWidth / 2, -50, Sources.Cauldron);
			cauldronImage.scale = new FlxPoint(0.8,0.8);
			add(cauldronImage);
			
			var candyOffset:int = 50;
			var candyWidth:int = 75;
			var candyX:int = (FlxG.width - candyWidth) / 2;
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
			
			var combineButton:FlxButton = new FlxButton(FlxG.width/2 - 40, 410, "", combineCandy); // same location as attack button on battle screen
			combineButton.loadGraphic(Sources.buttonCraft);
			var combineLabel:FlxText=new FlxText(0,0,80,"COMBINE");
			combineLabel.setFormat("COOKIES", 16, 0xffffffff);
			combineLabel.alignment = "center";
			combineButton.label=combineLabel;
			combineButton.labelOffset=new FlxPoint(0,0);
			add(combineButton);
			
			var doneButton:FlxButton = new FlxButton(560 - 2, 410, "", done); // should be in same location as craft button on explore screen
			doneButton.loadGraphic(Sources.buttonRun);
			var doneLabel:FlxText=new FlxText(0,0,80,"DONE");
			doneLabel.setFormat("COOKIES", 16, 0xffffffff);
			doneLabel.alignment = "center";
			doneButton.label=doneLabel;
			doneButton.labelOffset=new FlxPoint(0,0);
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
			
			banner.color = 0x1199ff
			add(this.banner);
			
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
				cauldron[emptySlot] = color;
				FlxButton(candies[emptySlot]).loadGraphic(image);
				banner.text = "";
			}
		}
		
		private function combineCandy():void {
			if (cauldron.indexOf(-1) > -1) {
				banner.text = "You have to put 3 candies in the cauldron first!";
			}
			else {
				var weapon:Weapon = CraftLogic.craft(cauldron);
				banner.text = "You got a " + weapon.getDisplayName() + "!\nAttack: " + weapon.attack + " Defense: " + weapon.defense;
				Inventory.addWeapon(weapon);
				cauldron = [ -1, -1, -1];
				for (var i:int = 0; i < 3; i++) {
					FlxButton(candies[i]).loadGraphic(Sources.candyDisabledBig);
				}
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