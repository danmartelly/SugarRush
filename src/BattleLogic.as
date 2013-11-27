package {
	import org.flixel.FlxTimer;
	import flash.utils.describeType;
	import org.flixel.FlxG;
	/**
	 * @author ethanis
	 */
	 
	public class BattleLogic {
		var turn:int = 0;
		public var player:BattlePlayer = new BattlePlayer(PlayerData.instance);
		var enemy:BattleEnemy;
		var state:BattlePlayState;
		
		var itemsPerPage:int;
		var inventoryPage:int;
		
		public function BattleLogic(state:BattlePlayState, enemyData:BattleEnemy, itemsPerPage:int=5){
			this.itemsPerPage = itemsPerPage;
			this.state = state;
			enemy = enemyData;
			
			initializePlayer();
		}
		
		public function initializePlayer():void {
			switchWeaponIndex(player.data.currentWeaponIndex); //in order to re-apply buffs
		}
		public function useRun():void {
			this.state.endBattleCallback(RAN_AWAY);
		}
		
		public function useAttack():Number {
			var dmg:Number=player.attack(enemy);
			this.state.healthCallback();
			endTurn();
			return dmg;
		}
		
		private static function randomEnemy():String {
			var enemyCount:int = Sources.enemyNames.length;
			var enemyIndex:int = Math.floor(Math.random()*enemyCount);
			return Sources.enemyNames[enemyIndex];
		}
		
		// couldn't name it just switch() because it's a reserved word
		public function switchWeaponIndex(index:int):void {
			player.data.currentWeaponIndex = index;
			var weapon:Weapon = player.data.currentWeapon();
			
			player.removeAllBuffs(); //this is suspect but will work as long as we don't add more weapons
			if (weapon.buffs["equip"]) {
				var i:int = weapon.buffs["equip"];
				var b:Buff = Weapon.BUFF_LIST[i];
				player.applyBuff(b.tag, i, b.numTurns);
			}
		}
		
		public function useCandy():void {
			if (Inventory.hasCandy() && player.currentHealth !== player.maxHealth) {
				FlxG.play(Sources.gainHealth);
				Inventory.removeCandy(Inventory.randomCandy());
				player.heal(5);
				this.state.showHealth();
				this.state.healthCallback();
				endTurn();
			}
			else {
				FlxG.play(Sources.error);
			}
		}
		
		private function endTurn():void {
			turn = (turn + 1) % 2;
			
			if (turn == ENEMY_TURN) player.removeTempStats();
			else enemy.removeTempStats();
			
			if (player.isDead) {
				this.state.endBattleCallback(ENEMY_WON);
			}else if (enemy.isDead) {
				player.data.killCount += 1;
				this.state.endBattleCallback(PLAYER_WON);
			} else {
				this.state.turnCallback(turn);
			}
			
			// 1-second delay on turn-change
			var timer:FlxTimer = new FlxTimer();
			timer.start(1,1, function(timer:FlxTimer):void {
				if (turn == ENEMY_TURN && !enemy.isDead){
					enemy.attack(player);
					state.healthCallback();
					endTurn();
				}
			});
		}
		
		// WALTER, USE THESE
		public function playerHealthPercent():Number {
			return player.getHealthAsPercent();
		}
		
		public function enemyHealthPercent():Number {
			return enemy.getHealthAsPercent();
		}
		
		// inventory pagination for gui
		public function currentInventoryPage():Array {
			return [];
		}
		
		
		// if your turn
		public static const PLAYER_TURN:int = 0;
		// if enemy's turn
		public static const ENEMY_TURN:int = 1;
		
		// reasons for battle ending
		public static const PLAYER_WON:int = 0;
		public static const ENEMY_WON:int = 1;
		public static const RAN_AWAY:int = 2;
	}	
}
