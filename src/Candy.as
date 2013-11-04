package {
	/**
	 * @author ethanis
	 */
	public class Candy {
		var type:int;
		const TYPE_SUGAR:int = 0;
		const TYPE_CINAMMON:int = 1;
		const TYPE_MINT:int = 2;
		const TYPE_CHOCOLATE:int = 3;
		
		public function Candy(type:int = TYPE_SUGAR){
			this.type = type;
		}
	}
}
