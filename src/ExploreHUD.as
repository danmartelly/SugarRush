package
{
	import org.flixel.*;
	
	public class ExploreHUD extends FlxGroup
	{
		private var worldEdgeRight:Number = FlxG.worldBounds.x;
		private var worldEdgeBottom:Number = FlxG.worldBounds.y;
		protected var healthLabel:FlxText = new FlxText(0, 5, 100, "Health: ");
		protected var healthValLabel:FlxText = new FlxText(worldEdgeRight - 50, 5, 20, "-1/10");
		protected var candyLabel:FlxText = new FlxText(worldEdgeRight - 150, 15, 100, "Candies: ");
		protected var candyValLabel:FlxText = new FlxText(worldEdgeRight - 50, 15, 20, "-1");
		
		public function ExploreHUD()
		{
			healthLabel = new FlxText(0, 5, 100, "Health: ");
			healthValLabel= new FlxText(worldEdgeRight - 50, 5, 20, "-1/10");
			candyLabel = new FlxText(worldEdgeRight - 150, 15, 100, "Candies: ");
			candyValLabel = new FlxText(worldEdgeRight - 50, 15, 20, "-1");;
			var thing:Number = FlxG.worldBounds.x;
			this.add(healthLabel);
			this.add(healthValLabel);
			this.add(candyLabel);
			this.add(candyValLabel);
		}
	}
}