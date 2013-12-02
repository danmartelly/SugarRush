package {
	import flash.utils.describeType;
	
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
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
		public function getPlayerFlags():Array {
			return player.flags;
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
		
		public function useCandy(healAmount:Number):void {
			this.player.heal(healAmount);
			this.state.healthCallback();
			endTurn();
		}
		
		public function enemyTurn(self:BattleLogic):Function {
			return function():void {
				var enemyDamage:Number = self.enemy.attack(player);
				self.state.enemyAttackCallback(enemyDamage);
				self.state.healthCallback();
				self.endTurn();
			};
		}
		
		public function endTurn():void {
			turn = (turn + 1) % 2;
			
			if (turn == ENEMY_TURN){
				player.removeTempStats();
			} else { 
				enemy.removeTempStats();
			}
			
			if (player.isDead) {
				this.state.endBattleCallback(ENEMY_WON);
			} else if (enemy.isDead) {
				player.data.killCount += 1;
				this.state.endBattleCallback(PLAYER_WON);
			} else {
				this.state.turnCallback(turn);
			}
			
<<<<<<< HEAD
			// 2-second delay on turn-change
			var timer:FlxTimer = new FlxTimer();
			timer.start(2,1, function(timer:FlxTimer):void {
				if (turn == ENEMY_TURN && !enemy.isDead){
					enemy.attack(player);
					state.healthCallback();
					endTurn();
				}
			});
=======
			var self:BattleLogic = this;
			// 1-second delay on turn-change
			if (turn == ENEMY_TURN && !enemy.isDead){
				(new FlxTimer).start(1, 1, enemyTurn(this));
			}
>>>>>>> 87d5846f842927778946ae86deef01b51fc1541c
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
