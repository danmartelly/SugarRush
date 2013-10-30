package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		public function Player(X:Number=50, Y:Number=50)
		{
			super(X, Y);
			makeGraphic(10, 12, 0xffaa11aa);
			maxVelocity.x = 80;
			maxVelocity.y = 80;
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
		}
		
		override public function update():void {
			acceleration.x = 0;
			acceleration.y = 0;
			if (FlxG.keys.LEFT) {
				acceleration.x = -maxVelocity.x * 4;
			}
			if (FlxG.keys.RIGHT) {
				acceleration.x = maxVelocity.x * 4;
			}
			if (FlxG.keys.UP) {
				acceleration.y = -maxVelocity.y * 4;
			}
			if (FlxG.keys.DOWN) {
				acceleration.y = maxVelocity.y * 4;
			}
		}
	}
}