package {
	/**
	 * @author ethanis
	 */
	public class BattleEnemy extends BattleCharacter {
		public var name:String;
		
		public function BattleEnemy(currentHealth:Number, maxHealth:Number, name:String):void {
			super(currentHealth, maxHealth);
			this.name = name;
		}
	}
}
