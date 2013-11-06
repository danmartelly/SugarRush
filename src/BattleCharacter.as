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
			for (var i:Object in this.buffs) {
				if (i["name"] == s) {
					i["turns"] = turns;
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
			for (var i:Object in this.buffs) {
				if (i["turns"] > 0)
					i["turns"]--;
			}
			this.buffs.filter(function(obj:Object):Boolean { return obj["turns"] != 0; });
		}
		
		public function attack(opponent:BattleCharacter): Number {
			//var damageAmount:Number = (Math.floor(Math.random()*3*this.getAttackStat() + 1) - 
			//				    	   Math.floor(Math.random()*2*opponent.getDefenseStat()));
			var damageAmount:Number = Math.max(0, this.getAttackStat() - opponent.getDefenseStat());
			opponent.hurt(damageAmount);
			
			return damageAmount;
		}
	}
}
