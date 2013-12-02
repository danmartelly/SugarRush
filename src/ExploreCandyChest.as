package
{
	import flash.geom.*;
	
	import org.flixel.*;
	
	public class ExploreCandyChest extends FlxSprite
	{
		private var isEnabled:Boolean = true;
		private const maxEnemiesAttacking:Number = 2;
		private const attackTimeUntilBroken:Number = 3;
		public var enemySlotsOccupied:Boolean = false;
		
		private const occupyDistance:Number = 80;
		
		private var _enemies:FlxGroup;
		private var _chests:FlxGroup;
		
		public function ExploreCandyChest(X:Number, Y:Number, chests:FlxGroup, enemies:FlxGroup) {
			super(X, Y, null);
			_enemies = enemies;
			_chests = chests;
			loadGraphic(Sources.TreasureChest, true, false, 40, 40);
			addAnimation("open", [1]); 
			immovable = true;
			health = attackTimeUntilBroken; // your health is actually time
		}
		
		public function rewardCandy():void {
			if (isEnabled) {
				Inventory.addCandy(Inventory.COLOR_BLUE);
				
				play("open");
				isEnabled = false;
				var timer:FlxTimer = new FlxTimer(); 
				var that:FlxBasic = this;
				timer.start(1,1,function(timer:FlxTimer){
					_chests.remove(that);
				});
				
			}
		}
		
		public static function CreateGotCandyMessage(position:FlxPoint):FlxText {
			var getCandyTxt:FlxText = new FlxText(position.x, position.y, 300, "You got 1 candy!"); 
			getCandyTxt.setFormat("COOKIES",20);
			getCandyTxt.color = 0x00000000;
			return getCandyTxt;
		}
		
		override public function update():void {
			//decide whether there are enough enemies close by or not
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
			if (occupiedEnemiesCount >= maxEnemiesAttacking) {
				enemySlotsOccupied = true;
			} else {
				enemySlotsOccupied = false;
			}
		}
	}
}