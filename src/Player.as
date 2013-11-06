package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite
	{
		[Embed(source="../assets/player_back.png")] protected var playerBack:Class;
		[Embed(source="../assets/player_front.png")] protected var playerFront:Class;
		[Embed(source="../assets/player_left.png")] protected var playerLeft:Class;
		[Embed(source="../assets/player_right.png")] protected var playerRight:Class;
		
		public var levelX:Number = 800;
		public var levelY:Number = 600;
		public var playerwidth:Number = 35;
		public var playerheight:Number = 60;
		
		
		public function Player(X:Number=50, Y:Number=50)
		{
			super(X, Y);
			makeGraphic(10, 12, 0xffaa11aa);
			velocity.x = 0;
			velocity.y = 0;
			maxVelocity.x = 90;
			maxVelocity.y = 90;
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
			loadGraphic(playerFront);
			
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = levelX;
			FlxG.worldBounds.height = levelY;
		}
		
		override public function update():void {
			acceleration.x = 0;
			acceleration.y = 0;
			if (x < 0){
				x = 0;
			}
			if ( x > (FlxG.width - playerwidth)) {
				x = FlxG.width - playerwidth;
			}
			if (y < 0){
				y = 0;
			}
			if ( y > (FlxG.height - playerheight)) {
				y = (FlxG.height - playerheight);
			}
			
			if (FlxG.keys.LEFT) {
				velocity.x = -maxVelocity.x * 4;
				loadGraphic(playerLeft);
			}
			if (FlxG.keys.RIGHT) {
				velocity.x = maxVelocity.x * 4;
				loadGraphic(playerRight);
			}
			if (FlxG.keys.UP) {
				velocity.y = -maxVelocity.y * 4;
				loadGraphic(playerBack);
			}
			if (FlxG.keys.DOWN) {
				velocity.y = maxVelocity.y * 4;
				loadGraphic(playerFront);
			}
		}
	}
}