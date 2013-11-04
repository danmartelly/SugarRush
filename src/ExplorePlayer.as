package
{
	import org.flixel.*;
	
	public class ExplorePlayer extends FlxSprite
	{
		[Embed(source="../assets/player_back.png")] protected var playerBack:Class;
		[Embed(source="../assets/player_front.png")] protected var playerFront:Class;
		[Embed(source="../assets/player_left.png")] protected var playerLeft:Class;
		[Embed(source="../assets/player_right.png")] protected var playerRight:Class;
		
		public function ExplorePlayer(X:Number=50, Y:Number=50)
		{
			super(X, Y);
			makeGraphic(10, 12, 0xffaa11aa);
			maxVelocity.x = 90;
			maxVelocity.y = 90;
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
			loadGraphic(playerFront);
		}
		
		override public function update():void {
			acceleration.x = 0;
			acceleration.y = 0;
			if (FlxG.keys.LEFT) {
				acceleration.x = -maxVelocity.x * 4;
				loadGraphic(playerLeft);
			}
			if (FlxG.keys.RIGHT) {
				acceleration.x = maxVelocity.x * 4;
				loadGraphic(playerRight);
			}
			if (FlxG.keys.UP) {
				acceleration.y = -maxVelocity.y * 4;
				loadGraphic(playerBack);
			}
			if (FlxG.keys.DOWN) {
				acceleration.y = maxVelocity.y * 4;
				loadGraphic(playerFront);
			}
		}
	}
}