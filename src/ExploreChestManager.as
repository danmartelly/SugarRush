package
{
	import org.flixel.*;
	
	public class ExploreChestManager extends FlxGroup
	{
		public const creationRate:Number = 20;
		public const maxChests:Number = 3;
		private const spawnRegions:Array = [
			new FlxRect(0, 70, 100, ExplorePlayState.levelY - 140 - 75), //left
			new FlxRect(ExplorePlayState.levelX - 100 - 40, 70, 100, ExplorePlayState.levelY - 140 - 75), //right
			new FlxRect(70, 0, ExplorePlayState.levelX - 140, 100), //up
			new FlxRect(70, ExplorePlayState.levelY - 100 - 75 - 40, ExplorePlayState.levelX - 140, 100), //down
		];
		private var firstTime:Boolean = true;
		
		private var _enemies:FlxGroup
		private var _inGameMessage:FlxText;
		
		public function ExploreChestManager(enemies:FlxGroup, inGameMessage:FlxText, MaxSize:uint=0)
		{
			super(MaxSize);
			_inGameMessage = inGameMessage;
			_enemies = enemies;
		}
		
		override public function update():void {
			super.update();
			if (firstTime) {
				firstTime = false;
				for (var i:Number = 0 ; i < maxChests ; i++) {
					spawnRandomChest();
				}
			}
			
			
		}
		
		public function spawnRandomChest():void {
			var region:FlxRect = FlxG.getRandom(spawnRegions) as FlxRect;
			var xRect:Number = Math.floor(Math.random()*region.width);
			var yRect:Number = Math.floor(Math.random()*region.height);
			var xCoord:Number = region.left + xRect;
			var yCoord:Number = region.top + yRect;
			add(new ExploreCandyChest(xCoord, yCoord, this, _enemies, _inGameMessage));
		}
	}
}