package
{
	import org.flixel.*;
	import flash.geom.*;
	
	public class Enemy extends FlxSprite
	{
		
		private var _timer:Number = 0;
		private const changeWalkDirectionRate:Number = 5;
		private var _player:Player;
		
		public function Enemy(X:Number, Y:Number, player:Player)
		{
			super(X, Y, null);
			_player = player;
			velocity.y = 5;
		}
		
		override public function update():void {
			//random behavior when the player is not close by
			var distanceToPlayer:Number = 0;
			_timer += FlxG.elapsed;
			if (_timer > changeWalkDirectionRate) {
				_timer = 0;
				velocity.y = FlxG.random()*6 - 3;
				velocity.x = FlxG.random()*6 - 3;
			}
		}
	}
}