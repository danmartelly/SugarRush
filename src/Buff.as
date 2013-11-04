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
		public var effect:Function = function() { }
			
		public function Buff(tag:String, name:String, effect:Function):void {
			this.tag = tag;
			this.name = name;
			this.effect = effect;
		}
	}
}