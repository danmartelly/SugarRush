package
{
	import org.flixel.FlxTimer;
	import org.flixel.FlxSprite;
	
	public class ExploreCandyChest extends FlxSprite
	{
		private var isEnabled:Boolean = true;
		
		public function ExploreCandyChest(X:Number=500, Y:Number=500) {
			super(X, Y, null);
			this.loadGraphic(Sources.TreasureChest, true, false, 40, 40);
		}
		
		public function rewardCandy():void {
			if (isEnabled) {
				Inventory.addCandy(Inventory.COLOR_BLUE);
				this.frame = 1;
				isEnabled = false;
				var timer:FlxTimer = new FlxTimer();
				var that:FlxSprite = this;
				timer.start(1, 1, function(timer:FlxTimer){
					that.visible = false;
				});
			}
		}
	}
}