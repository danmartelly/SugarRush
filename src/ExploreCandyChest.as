package
{
	import org.flixel.FlxTimer;
	import org.flixel.FlxSprite;
	
	public class ExploreCandyChest extends FlxSprite
	{
		public function ExploreCandyChest(X:Number=500, Y:Number=500) {
			super(X, Y, null);
			this.loadGraphic(Sources.TreasureChest, true, false, 40, 40);
		}
		
		public function rewardCandy():void {
			Inventory.addCandy(Inventory.COLOR_BLUE);
			this.frame = 1;
			var timer:FlxTimer = new FlxTimer();
			var candy:ExploreCandyChest = this;
			timer.start(1, 1, function(timer:FlxTimer):void {
				if (timer.finished){
					candy.destroy();
				}
			});
		}
	}
}