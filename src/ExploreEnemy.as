package
{
	import flash.geom.*;
	
	import org.flixel.*;
	
	public class ExploreEnemy extends FlxSprite
	{
		
		private var _timer:Number = 0;
		private const changeWalkDirectionRate:Number = 5;
		private const aggroDistance:Number = 80; // distance for when enemy starts charging towards you
		private const aggroSpeed:Number = 50;
		private const avoidOtherEnemyDistance:Number = 80;
		private const ambleSpeed:Number = 10;
		private var nameGraphicMap:Object = {
			"carrot":Sources.SmallCarrot,
			"tomato":Sources.SmallTomato,
			"eggplant":Sources.SmallEggplant,
			"lettuce":Sources.SmallLettuce
		};
		public var enemyType:String;
		private var _player:ExplorePlayer;
		private var _enemies:FlxGroup;
		
		public function ExploreEnemy(X:Number, Y:Number, enemyType:String, enemyGroup:FlxGroup, player:ExplorePlayer)
		{	
			this.enemyType = enemyType;
			super(X, Y, nameGraphicMap[enemyType]);
			_enemies = enemyGroup;
			_player = player;
			velocity.y = FlxG.random()*2*ambleSpeed - ambleSpeed;
			velocity.x = FlxG.random()*2*ambleSpeed - ambleSpeed;
			maxVelocity = new FlxPoint(200, 200);
		}
		
		override public function update():void {
			if (x < 0){
				x = 0;
			}
			if ( x > (FlxG.width)) {
				x = FlxG.width;
			}
			if (y < 0){
				y = 0;
			}
			if ( y > (FlxG.height)) {
				y = (FlxG.height );
			}
			_timer += FlxG.elapsed;
			var selfPoint:Point = new Point();
			this.getMidpoint().copyToFlash(selfPoint);
			// run to the player if close by
			var playerPoint:Point = new Point();
			_player.getMidpoint().copyToFlash(playerPoint);
			var vectorToPlayer:Point = playerPoint.subtract(selfPoint);
			var playerDistance:Number = vectorToPlayer.length;
			if (playerDistance < aggroDistance) {
				vectorToPlayer.normalize(aggroSpeed)
				velocity.copyFromFlash(vectorToPlayer);
				return;
			}
			// try to be as far away from all enemies that are close by
			var velocityVector:Point = new Point();
			var enemyArray:Array = _enemies.members;
			for each (var otherEnemy:ExploreEnemy in enemyArray) {
				if (this == otherEnemy) {continue;}
				var otherPoint:Point = new Point();
				otherEnemy.getMidpoint().copyToFlash(otherPoint);
				var vectorFromOther:Point = selfPoint.subtract(otherPoint);
				var otherDistance:Number = vectorFromOther.length;
				if (otherDistance < avoidOtherEnemyDistance) {
					//react more to things close by using Coulomb's law
					var normalize:Number = 1/(otherDistance*otherDistance);
					vectorFromOther.normalize(normalize);
					velocityVector = velocityVector.add(vectorFromOther);
				}
			}
			// if velocityVector != 0 then we can apply it
			if (velocityVector.x != 0 || velocityVector.y != 0) {
				velocityVector.normalize(ambleSpeed); //TODO: change to ambleSpeed
				velocity.copyFromFlash(velocityVector);
				return;
			}
			
			
			//random behavior when no enemies or player is close by
			if (_timer > changeWalkDirectionRate) {
				_timer = 0;
				velocity.y = FlxG.random()*2*ambleSpeed - ambleSpeed;
				velocity.x = FlxG.random()*2*ambleSpeed - ambleSpeed;
			}
		}
	}
}