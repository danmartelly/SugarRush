package
{
	import org.flixel.*;
	
	public class CraftingPlayState extends FlxState
	{
		//var logic:CraftLogic = new CraftLogic();
		private var candies:Array;
		private var cauldron:Array = new Array();
		private var buttonHeight:int;
		private var cauldronText:FlxText = new FlxText(100, 100, 500, "");
		private var banner:FlxText = new FlxText(100, 300, 500, "");
		
		override public function create():void
		{
			FlxG.bgColor = 0xaaffaacc;
			
			this.candies = new Array("a", "b", "c", "b", "a"); // Need to pull this from the player's inventory
			
			var title:FlxText = new FlxText(0, 0, 100, "Crafting state");
			var craftButton = new FlxButton(100, 200, "COMBINE", combineCandy);
			add(title);
			add(craftButton);
			add(this.cauldronText);
			add(this.banner);
			
			var height:int = 0;
			
			var candyButtons:Array = new Array(candies.length);
			for (var i:int = 0; i < candies.length; i++)
			{
				var candy:String = candies[i];
				var candyButton:FlxButton = new FlxButton(0, i * height, candy, selectCandy);
				height = candyButton.height;
				buttonHeight = height;
				candyButton.width = 50;
				add(candyButton);
			}
			
			FlxG.mouse.show();
		}
		
		private function selectCandy():void
		{
			var index:int = FlxG.mouse.y / this.buttonHeight; // index corresponding to the candy clicked
			if (cauldron.indexOf(index) < 0)
			{
				cauldron.push(index);
				if (cauldron.length > 3)
				{
					cauldron = cauldron.slice(1);
				}
				var display:Array = new Array();
				for (var i:int = 0; i < cauldron.length; i++)
				{
					display.push(candies[cauldron[i]]);
				}
				cauldronText.text = "Cauldron:\n| " + display.join(" | ") + " |";
				banner.text = "";
			}
			else {
				banner.text = "That candy is already in your cauldron!";
			}
		}
		
		private function combineCandy():void {
			if (cauldron.length < 3) {
				banner.text = "You have to put 3 candies in the cauldron first!";
			}
			else {
				banner.text = "Mix, mix, swirl...";
				// crafting function from craftLogic goes here, using the 3 candies in cauldron
			}
		}
	}
}