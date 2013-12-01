package
{
	import flash.geom.*;
	import org.flixel.*;
	
	public class ExploreCandyChest extends FlxSprite
	{
		private var isEnabled:Boolean = true;
		private const maxEnemiesAttacking:Number = 2;
		public var enemySlotsOccupied:Boolean = false;
		private const occupyDistance:Number = 90;
		
		private var _enemies:FlxGroup;
		
		public function ExploreCandyChest(X:Number, Y:Number, enemies:FlxGroup) {
			super(X, Y, null);
			_enemies = enemies;
			this.loadGraphic(Sources.TreasureChest, true, false, 40, 40);
		}
		
		public function rewardCandy():void {
			if (isEnabled) {
				Inventory.addCandy(Inventory.COLOR_BLUE);
				this.frame = 1;
				isEnabled = false;
				var timer:FlxTimer = new FlxTimer();
				var that:FlxSprite = this;
				timer.start(1, 1, function(timer:FlxTimer){
					that.visible = false;
				});
			}
		}
		
		override public function update():void {
			var selfPoint:Point = new Point();
			this.getMidpoint().copyToFlash(selfPoint);
			var occupiedEnemiesCount:Number = 0;
			for each (var enemy:ExploreEnemy in _enemies.members) {
				if (enemy == null) {continue;}
				var otherPoint:Point = new Point();
				enemy.getMidpoint().copyToFlash(otherPoint);
				var vectorFromOther:Point = selfPoint.subtract(otherPoint);
				var distance:Number = vectorFromOther.length;
				if (distance < occupyDistance) {
					occupiedEnemiesCount += 1;
					if (occupiedEnemiesCount > maxEnemiesAttacking) {
						break;
					}
				}
			}
			if (occupiedEnemiesCount > maxEnemiesAttacking) {
				enemySlotsOccupied = true;
			} else {
				enemySlotsOccupied = false;
			}
		}
	}
}