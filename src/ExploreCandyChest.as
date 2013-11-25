package
{
	import org.flixel.FlxSprite;
	
	public class ExploreCandyChest extends FlxSprite
	{
		public function ExploreCandyChest(X:Number=0, Y:Number=0) {
			super(X, Y, null);
		}
		
		public function rewardCandy():void {
			Inventory.addCandy(Inventory.COLOR_BLUE);
			this.destroy();
		}
	}
}