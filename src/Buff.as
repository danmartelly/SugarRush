package {
	/**
	 * This class contains basic data about buffs (effects which 
	 * are applied to the player or the enemy during battle).
	 * 
	 * For simplicity, the effects of all buffs are applied when 
	 * you attack. This may change (but probably won't).
	 * 
	 * @author npinsker
	 */
	
	public class Buff {
		public var tag:String = "";
		public var name:String = "";
		public var desc:String = "";
		public var numTurns:int = 1;
		public var effect:Function = function(src:BattleCharacter, trg:BattleCharacter):void { }
		public var sound:Class;
			
		public function Buff(tag:String, name:String, desc:String, numTurns:int, effect:Function, sound:Class):void {
			this.tag = tag;
			this.name = name;
			this.numTurns = numTurns;
			this.effect = effect;
			this.sound = sound;
		}
		
		public function getDisplayName():String {
			return this.name;
		}
	}
}