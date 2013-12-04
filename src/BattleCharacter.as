package {
	/**
	 * @author ethanis
	 */
	
	import org.flixel.FlxG;
	
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
			this.currentHealth = Math.min((this.currentHealth + amount), this.maxHealth);
		}
		
		public function hurt(amount:Number):void {
			this.currentHealth = Math.max((this.currentHealth - amount), 0);
			if (this.currentHealth == 0){
				this.isDead = true;
			}
		}
		
		public function getAttackStat():Number {
			return this.attackStat + this.tempAttackStat;
		}
		
		public function getDefenseStat():Number {
			return this.defenseStat + this.tempDefenseStat;
		}
		
		public function getHealthAsPercent():Number {
			return (currentHealth/maxHealth)*100.0;
		}
		
		public function removeTempStats():void {
			this.tempAttackStat = this.tempDefenseStat = 0;
		}
		
		//buff-related functions
		public function applyBuff(s:String, id:Number, turns:Number):void {
			for (var i:int=0; i<this.buffs.length; ++i) {
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

		public function hasBuff(tag:String):Boolean {
			var foundBuff:Boolean = false;
			for (var i:uint = 0; i < this.buffs.length; i+=1){
				var buff:Object = buffs[i];
				if (buff.tag == tag) {
					foundBuff = true;
				}
			}
			return foundBuff;
		}

		public function findBuff(s:String):Object {
			for (var i:int=0; i<this.buffs.length; ++i) {
				if (this.buffs[i]["name"] == s) {
					return this.buffs[i];
				}
			}
			return null;
		}

		public function getBuffText():String {
			var output:String = "";
			if (this.buffs.length > 0) {
				var buff:Buff = Weapon.BUFF_LIST[this.buffs[0]["id"]];
				var buffName:String = buff.getDisplayName();
				//output += (output != "" ? " " : ""); //puts a space before any additional buffs
				output += buffName;
			}
			
			FlxG.play(buff.sound);
			return output;
		}
		
		public function tickBuffs():void {
			var newBuffs:Array = new Array();
			for (var i:int=0; i<this.buffs.length; ++i) {
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
			for (var i:int=0; i<this.buffs.length; ++i) {
				var b:Buff = Weapon.BUFF_LIST[this.buffs[i]["id"]];
				b.effect(this, opponent);
			}
			var opponentDefense:int = opponent.getDefenseStat();
			
			var damageAmount:Number = Math.max(1, (Math.floor(Math.random()*3*this.getAttackStat() + 1) - 
				Math.floor(Math.random()*2*opponentDefense)));
			
			if (this.getAttackStat() == 0)
				damageAmount = 0;
			if (this.flags[0] == 'crit')
				damageAmount *= 2;
			
			opponent.hurt(damageAmount);
			
			this.tickBuffs();
			
			return damageAmount;
		}
	}
}
