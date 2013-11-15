package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class ExplorePlayer extends FlxSprite
	{
		
		

		public var playerwidth:Number = 35;
		public var playerheight:Number = 60;
		

		public function ExplorePlayer(X:Number=50, Y:Number=50)
		{
			super(X, Y);
			makeGraphic(10, 12, 0xffaa11aa);
			velocity.x = 0;
			velocity.y = 0;
			maxVelocity.x = 90;
			maxVelocity.y = 90;
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
			loadGraphic(Sources.playerFront);
			
			
		}
		
		override public function update():void {
			acceleration.x = 0;
			acceleration.y = 0;
			if (x < 0){
				x = 0;
			}
			if ( x > (1200 - playerwidth)) {
				x = 1200 - playerwidth;
			}
			if (y < 0){
				y = 0;
			}
			if ( y > (800 - (playerheight+75))) { //75 is lower bar
				y = (800 - (playerheight+75));
			}
			
			if (FlxG.keys.LEFT) {
				velocity.x = -maxVelocity.x * 4;
				loadGraphic(Sources.playerLeft);
			}
			if (FlxG.keys.RIGHT) {
				velocity.x = maxVelocity.x * 4;
				loadGraphic(Sources.playerRight);
			}
			if (FlxG.keys.UP) {
				velocity.y = -maxVelocity.y * 4;
				loadGraphic(Sources.playerBack);
			}
			if (FlxG.keys.DOWN) {
				velocity.y = maxVelocity.y * 4;
				loadGraphic(Sources.playerFront);
			}
		}
	}
}