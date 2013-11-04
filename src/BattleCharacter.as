package {
	/**
	 * @author ethanis
	 */
	public class BattleCharacter {
		var currentHealth:Number;
		var maxHealth:Number;
		var isDead:Boolean = false;
		var weapon:Weapon = null;
		var attackStatModifier:Number = 0;
		var defenseStatModifier:Number = 0;
		var buffs:Array = [];
		
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
			return this.weapon.attack + this.attackStatModifier;
		}
		
		public function getDefenseStat():Number {
			return this.weapon.defense + this.defenseStatModifier;
		}
		
		public function getHealthAsPercent():Number {
			return (currentHealth/maxHealth)*100;
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
				i["turns"]--;
			}
			this.buffs.filter(function(obj) { return obj["turns"] > 0; });
		}
		
		public function attack(opponent:BattleCharacter): Number {
			var damageAmount:Number = (Math.floor(Math.random()*3*this.getAttackStat() + 1) - 
							    	   Math.floor(Math.random()*2*opponent.getDefenseStat()));
			opponent.hurt(damageAmount);
			return damageAmount;
		}
	}
}
