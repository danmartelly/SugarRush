package
{
	import org.flixel.*;
	
	public class CraftingPlayState extends FlxState
	{
		private var logic:CraftLogic = new CraftLogic();
		private var candies:Array;
		private var cauldronIndices:Array = new Array();
		private var buttonHeight:int;
		private var cauldronText:FlxText = new FlxText(100, 100, 500, "");
		private var banner:FlxText = new FlxText(100, 300, 500, "");
		
		override public function create():void
		{
			FlxG.bgColor = 0xaaffaacc;
			
			this.candies = new Array();
			
			for (var color:int = 0; color < 3; color++) {
				for (var i:int = 0; i < Inventory.candyCount(color); i++) {
					this.candies.push(new Candy(color));
				}
			}
			
			var title:FlxText = new FlxText(0, 0, 100, "Crafting state");
			var craftButton:FlxButton = new FlxButton(100, 200, "COMBINE", combineCandy);
			var doneButton:FlxButton = new FlxButton(200, 200, "DONE", done);
			add(title);
			add(craftButton);
			add(doneButton);
			add(this.cauldronText);
			add(this.banner);
			
			var height:int = 0;
			
			var candyButtons:Array = new Array(candies.length);
			for (var i:int = 0; i < candies.length; i++)
			{
				var candy:Candy = candies[i];
				var candyButton:FlxButton = new FlxButton(0, i * height, candy.getColorName(), selectCandy);
				height = candyButton.height;
				buttonHeight = height;
				add(candyButton);
			}
			
			FlxG.mouse.show();
		}
		
		private function selectCandy():void
		{
			var index:int = FlxG.mouse.y / this.buttonHeight; // index corresponding to the candy clicked
			if (cauldronIndices.indexOf(index) < 0)
			{
				cauldronIndices.push(index);
				if (cauldronIndices.length > 3)
				{
					cauldronIndices = cauldronIndices.slice(1);
				}
				var display:Array = new Array();
				for (var i:int = 0; i < cauldronIndices.length; i++)
				{
					var candy:Candy = candies[cauldronIndices[i]];
					display.push(candy.getColorName());
				}
				cauldronText.text = "Cauldron:\n| " + display.join(" | ") + " |";
				banner.text = "";
			}
			else {
				banner.text = "That candy is already in your cauldron!";
			}
		}
		
		private function combineCandy():void {
			if (cauldronIndices.length < 3) {
				banner.text = "You have to put 3 candies in the cauldron first!";
			}
			else {
				banner.text = "Mix, mix, swirl...";
				var cauldron:Array = new Array();
				for (var i:int = 0; i < cauldronIndices.length; i++) {
					var candy:Candy = candies[cauldronIndices[i]];
					cauldron.push(candy);
				}
				var weapon:Weapon = CraftLogic.craft(cauldron);
				banner.text = "You got a " + weapon.getDisplayName() + "!\nAttack: " + weapon.attack + " Defense: " + weapon.defense;
				
				var tempCandies:Array = new Array();
				for (i = 0; i < candies.length; i++) {
					if (cauldronIndices.indexOf(i) < 0) {
						var color:int = candies[i];
						tempCandies.push(color);
						Inventory.removeCandy(color);
					}
				}
				//candies = tempCandies;
				Inventory.addWeapon(weapon);
			}
		}
		
		private function done():void {
			FlxG.switchState(new ExplorePlayState());
		}
	}
}