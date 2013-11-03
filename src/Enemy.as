package
{
	import flash.geom.*;
	
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{
		
		private var _timer:Number = 0;
		private const changeWalkDirectionRate:Number = 5;
		private const aggroDistance:Number = 100; // distance for when enemy starts charging towards you
		private const aggroSpeed:Number = 120;
		private var _player:Player;
		private var _enemies:FlxGroup;
		
		public function Enemy(X:Number, Y:Number, enemyGroup:FlxGroup, player:Player)
		{
			super(X, Y, null);
			_player = player;
			velocity.y = 5;
			maxVelocity = new FlxPoint(200, 200);
		}
		
		override public function update():void {
			_timer += FlxG.elapsed;
			// run to the player if close by
			var playerPoint:Point = new Point();
			_player.getMidpoint().copyToFlash(playerPoint);
			var selfPoint:Point = new Point();
			this.getMidpoint().copyToFlash(selfPoint);
			var vectorToPlayer:Point = playerPoint.subtract(selfPoint);
			var playerDistance:Number = vectorToPlayer.length;
			var angleToPlayer:Number = Math.atan2(vectorToPlayer.y,vectorToPlayer.x);
			if (playerDistance < aggroDistance) {
				vectorToPlayer.normalize(aggroSpeed)
				velocity.copyFromFlash(vectorToPlayer);
				return;
			}
			
			//random behavior when no enemies or player is close by
			if (_timer > changeWalkDirectionRate) {
				_timer = 0;
				velocity.y = FlxG.random()*6 - 3;
				velocity.x = FlxG.random()*6 - 3;
			}
		}
	}
}