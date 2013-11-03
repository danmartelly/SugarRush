package
{
	import org.flixel.*;
	
	public class CraftingPlayState extends FlxState
	{
		//var logic:CraftLogic = new CraftLogic();
		private var candies:Array;
		
		override public function create():void{
			FlxG.bgColor = 0xaaffaacc;
			
			this.candies = new Array("a", "b", "c");
						
			var title:FlxText = new FlxText(0, 0, 100, "Crafting state");
			add(title);
			
			var height = 0;
			
			var candyButtons:Array = new Array(candies.length);
			for (var i:int = 0; i < candies.length; i++) {
				var candy:String = candies[i];
				var candyButton:FlxButton = new FlxButton(0, i * height, candy, testCallback);
				height = candyButton.height;
				candyButton.width = 50;
				add(candyButton);
			}
			
			FlxG.mouse.show();
		}
		
		private function testCallback():void{
			//cauldron.add
		}
	}
}