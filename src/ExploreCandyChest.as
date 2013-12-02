package
{
	import flash.geom.Point;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	
	public class ExploreCandyChest extends FlxSprite
	{
		private var isEnabled:Boolean = true;
		public var enemySlotsOccupied:Boolean = false;
		
		private const maxEnemiesAttacking:Number = 2;
		private const occupyDistance:Number = 90;
	
		private var _enemies:FlxGroup;
		
		public function ExploreCandyChest(X:Number, Y:Number, enemies:FlxGroup) {
			super(X, Y, null);
			_enemies = enemies;
			loadGraphic(Sources.TreasureChest, true, false, 40, 40);
			addAnimation("open", [1]); 
		}
		
		public function rewardCandy():void {
			if (isEnabled) {
				Inventory.addCandy(Inventory.COLOR_BLUE);
				
				play("open");
				isEnabled = false;
				
				var timer:FlxTimer = new FlxTimer(); 
				timer.start(1,1,function(timer:FlxTimer){
					visible = false;
				});
				
			}
		}
		
		public static function CreateGotCandyMessage(position:FlxPoint):FlxText {
			var getCandyTxt:FlxText = new FlxText(position.x, position.y, 300, "You got 1 candy!"); 
			getCandyTxt.setFormat("COOKIES",20);
			getCandyTxt.color = 0xffffffff;
			return getCandyTxt;
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