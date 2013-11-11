package {
	/**
	 * @author ethanis
	 */
	public class BattleCharacter {
		var currentHealth:Number;
		var maxHealth:Number;
		var isDead:Boolean = false;
		var attackStat:Number = 0;
		var defenseStat:Number = 0;
		var tempAttackStat:Number = 0;
		var tempDefenseStat:Number = 0;
		
		// used for weapon effects
		var buffs:Array = [];
		var flags:Array = [];
		
		public function BattleCharacter(currentHealth:Number, maxHealth:Number):void {
			this.currentHealth = currentHealth;
			this.maxHealth = maxHealth;
		}
		
		public function heal(amount:Number):void {
			this.currentHealth = Math.min((this.currentHealth + amount), maxHealth);
		}
		
		public function hurt(amount:Number):void {
			this.currentHealth = Math.max((this.currentHealth - amount), 0);
			if (this.currentHealth == 0){
				this.isDead = true;
			}
		}
		
		public function getAttackStat():Number {
			return this.attackStat;
		}
		
		public function getDefenseStat():Number {
			return this.defenseStat;
		}
		
		public function getHealthAsPercent():Number {
			return (currentHealth/maxHealth)*100;
		}
		
		//buff-related functions
		public function applyBuff(s:String, id:Number, turns:Number):void {
			for (var i=0; i<this.buffs.length; ++i) {
				if (this.buffs[i]["name"] == s) {
					this.buffs[i]["turns"] = turns;
					return;
				}
			}
			this.buffs.push({"name": s, "id": id, "turns": turns});
		}
		public function removeBuff(s:String):void {
			this.buffs.filter(function(obj:Object):Boolean { return obj["name"] != s; });
		}
		public function removeAllBuffs():void {
			this.buffs = [];
		}
		public function hasBuff(s:String):Boolean {
			for (var i:Object in this.buffs) {
				if (i["name"] == s) {
					return true;
				}
			}
			return false;
		}
		public function tickBuffs():void {
			var newBuffs = new Array();
			for (var i=0; i<this.buffs.length; ++i) {
				if (this.buffs[i]["turns"] > 0) {
					this.buffs[i]["turns"]--;
				}
				if (this.buffs[i]["turns"] > 0 || this.buffs[i]["turns"] == -1) {
					newBuffs.push(this.buffs[i]);
				}
			}
			this.buffs = newBuffs;
		}
		
		public function attack(opponent:BattleCharacter): Number {
			var damageAmount:Number = Math.max(1, (Math.floor(Math.random()*3*this.getAttackStat() + 1) - 
							    	   			   Math.floor(Math.random()*2*opponent.getDefenseStat())));

			opponent.hurt(damageAmount);
			
			for (var i=0; i<this.buffs.length; ++i) {
				var b:Buff = Weapon.BUFF_LIST[this.buffs[i]["id"]];
				b.effect(this, opponent);
			}
			this.tickBuffs();
			
			return damageAmount;
		}
	}
}
