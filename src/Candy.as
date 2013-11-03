package {
	/**
	 * @author ethanis
	 */
	public class Candy {
		var type:Number;
		const TYPE_SUGAR:Number = 0;
		const TYPE_CINAMMON:Number = 1;
		const TYPE_MINT:Number = 2;
		const TYPE_CHOCOLATE:Number = 3;
		
		public function Candy(type:Number = TYPE_SUGAR){
			this.type = type;
		}
	}
}
