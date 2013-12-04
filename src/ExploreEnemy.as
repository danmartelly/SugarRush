package
{
	import flash.geom.*;
	import org.flixel.*;
	
	public class ExploreEnemy extends FlxSprite
	{
		
		private var _timer:Number = 0;
		private const changeWalkDirectionRate:Number = 5;
		private const playerAggroDistance:Number = 80; // distance for when enemy starts charging towards you
		private const playerAggroSpeed:Number = 50;
		private const avoidOtherEnemyDistance:Number = 80;
		private const ambleSpeed:Number = 10;
		private const chestAggroDistance:Number = 80; // this should be smaller than chestBufferDistance
		private const chestWiggleDistance:Number = 20;
		private const chestAggroSpeed:Number = 30;
		private const chestBufferDistance:Number = 100;
		
		public var enemyData:BattleEnemy;
		
		private var _player:ExplorePlayer;
		private var _enemies:FlxGroup;
		private var _chests:FlxGroup;
		
		public function ExploreEnemy(X:Number, Y:Number, enemyData:BattleEnemy, 
									 enemyGroup:FlxGroup, chests:FlxGroup, player:ExplorePlayer)
		{	
			this.enemyData = enemyData;
			super(X, Y, this.enemyData.exploreAsset());
			_enemies = enemyGroup;
			_player = player;
			_chests = chests;
			velocity.y = FlxG.random()*2*ambleSpeed - ambleSpeed;
			velocity.x = FlxG.random()*2*ambleSpeed - ambleSpeed;
			maxVelocity = new FlxPoint(200, 200);
		}
		
		override public function update():void {
			if (enemyData.currentHealth <= 0) {
				_enemies.remove(this);
			}
			
			if (x < 0){
				x = 0;
			}
			if ( x > (FlxG.worldBounds.width - this.frameWidth)) {
				x = FlxG.worldBounds.width - this.frameWidth;
			}
			if (y < 0){
				y = 0;
			}
			if ( y > (FlxG.worldBounds.height - (this.frameHeight+75))) { //75 is lower bar
				y = (FlxG.worldBounds.height - (this.frameHeight+75));
			}
			_timer += FlxG.elapsed;
			var selfPoint:Point = new Point();
			this.getMidpoint().copyToFlash(selfPoint);
			// run to the player if close by
			var playerPoint:Point = new Point();
			_player.getMidpoint().copyToFlash(playerPoint);
			var vectorToPlayer:Point = playerPoint.subtract(selfPoint);
			var playerDistance:Number = vectorToPlayer.length;
			if (_player.invincibilityTime == 0 && playerDistance < playerAggroDistance) {
				vectorToPlayer.normalize(playerAggroSpeed)
				velocity.copyFromFlash(vectorToPlayer);
				return;
			}
			// surround a nearby chest
			for each (var chest:ExploreCandyChest in _chests.members) {
				if (chest == null) {continue;}
				var otherPoint:Point = new Point();
				chest.getMidpoint().copyToFlash(otherPoint);
				var vectorToChest:Point = otherPoint.subtract(selfPoint);
				var distance:Number = vectorToChest.length;
				// if you're within aggro distance always aggro
				if (distance < chestAggroDistance) {
					if (distance < chestWiggleDistance) {
						// this makes them rotate clockwise
						vectorToChest.normalize(chestAggroSpeed);
						velocity.x = vectorToChest.y;
						velocity.y = -vectorToChest.x;
						return;
					}
					vectorToChest.normalize(chestAggroSpeed);
					velocity.copyFromFlash(vectorToChest);
					return;
				}
				// if the chest is already being attacked by enough enemies and you're
				// starting to get too close (but not within aggro distance)
				if (chest.enemySlotsOccupied && distance < chestBufferDistance) {
					vectorToChest.normalize(ambleSpeed);
					velocity.copyFromFlash((new Point()).subtract(vectorToChest));
					return;
				}
				
			}
			
			// try to be as far away from all enemies that are close by
			var velocityVector:Point = new Point();
			for each (var otherEnemy:ExploreEnemy in _enemies.members) {
				if (this == otherEnemy || otherEnemy == null) {continue;}
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
			
			
			//random behavior when nothing of interest is close by
			if (_timer > changeWalkDirectionRate) {
				_timer = 0;
				velocity.y = FlxG.random()*2*ambleSpeed - ambleSpeed;
				velocity.x = FlxG.random()*2*ambleSpeed - ambleSpeed;
			}
		}
	}
}