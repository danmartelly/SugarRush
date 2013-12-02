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
		private var _inGameMessage:FlxText;
		
		public function ExploreCandyChest(X:Number, Y:Number, chests:FlxGroup, enemies:FlxGroup, inGameMessage:FlxText) {
			super(X, Y, null);
			_enemies = enemies;
			_chests = chests;
			_inGameMessage = inGameMessage;
			loadGraphic(Sources.TreasureChest, true, false, 40, 40);
			addAnimation("open", [1]); 
			immovable = true;
			health = attackTimeUntilBroken; // your health is actually time
		}
		
		private function giveCandy():void {
			var candies:Array = [Inventory.COLOR_BLUE, Inventory.COLOR_RED, Inventory.COLOR_WHITE];
			var reward:int = int(FlxG.getRandom(candies))
			Inventory.addCandy(reward);
			showMessage("You got 1 candy");
		}
		
		private function giveMaxHealth():void {
			PlayerData.instance.maxHealth += 3;
			PlayerData.instance.currentHealth += 3;
			showMessage("You got +3 maxHealth");
		}
		
		public function rewardTreasure():void {
			if (isEnabled) {
				//select reward
				var rewardFunctions:Array = [giveCandy, giveMaxHealth];
				var choice:Function = FlxG.getRandom(rewardFunctions) as Function;
				choice.call();
				
				play("open");
				isEnabled = false;
				var timer:FlxTimer = new FlxTimer(); 
				var that:FlxBasic = this;
				timer.start(1,1,function(timer:FlxTimer){
					_chests.remove(that);
				});
			}
		}
		
		public function showMessage(message:String):void {	
			_inGameMessage.visible = true;
			_inGameMessage.text = message;
			var timer:FlxTimer = new FlxTimer();
			timer.start(1,1,function(timer:FlxTimer){
				_inGameMessage.visible = false;
			});
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