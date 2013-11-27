package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class ExplorePlayer extends FlxSprite
	{
		
		

		public var playerwidth:Number = 35;
		public var playerheight:Number = 60;
		public var invincibilityTime:Number = 0;
		
		private var mapWidth:Number=720; //1200;
		private var mapHeight:Number=480; //800;
		
		public var dirFacing:String="front";
		

		public function ExplorePlayer(X:Number=300, Y:Number=200)
		{
			super(X, Y);
			//makeGraphic(10, 12, 0xffaa11aa);
			velocity.x = 0;
			velocity.y = 0;
			maxVelocity.x = 90;
			maxVelocity.y = 90;
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
			loadGraphic(Sources.playerWalk, true, true,35,60);
			
			addAnimation("left", [0]); //name of animation, used frames, frames per second
			addAnimation("right", [5]);
			addAnimation("front", [10]);
			addAnimation("back", [16]);
			
			addAnimation("walkLeft", [1,2,3,4], 10);
			addAnimation("walkRight", [6,7,8,9], 10);
			addAnimation("walkFront", [11,12,13,14,15], 10);
			addAnimation("walkBack", [16,17,18,19,20], 10);
			
		}
		
		override public function update():void {
			acceleration.x = 0;
			acceleration.y = 0;
			if (x < 0){
				x = 0;
			}
			if ( x > (FlxG.worldBounds.width - playerwidth)) {
				x = mapWidth - playerwidth;
			}
			if (y < 0){
				y = 0;
			}
			if ( y > (FlxG.worldBounds.height - (playerheight+75))) { //75 is lower bar
				y = (mapHeight - (playerheight+75));
			}
			
			if (FlxG.keys.LEFT) {
				velocity.x = -maxVelocity.x * 4;
				dirFacing="left";
				play('walkLeft');
			}
			else if (FlxG.keys.RIGHT) {
				velocity.x = maxVelocity.x * 4;
				dirFacing="right";
				play('walkRight');
			}
			else if (FlxG.keys.UP) {
				velocity.y = -maxVelocity.y * 4;
				dirFacing="back";
				play('walkBack');
			}
			else if (FlxG.keys.DOWN) {
				velocity.y = maxVelocity.y * 4;
				dirFacing="front";
				play('walkFront');
			}
			
			else{
				play(dirFacing);
			}
		}
	}
}