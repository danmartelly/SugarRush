package {
	/**
	 * @author ethanis
	 */
	public class Candy {
		private var colorNumber:int;
		private var colorName:String;
		
		// These match the basic specials in Weapon.
		public static const COLOR_RED:int = 1;
		public static const COLOR_BLUE:int = 2;
		public static const COLOR_WHITE:int = 3;
		
		public function Candy(colorNumber:int = COLOR_RED){
			this.colorNumber = colorNumber;
			switch (this.colorNumber){
				case 1:
					this.colorName = 'red';
					break;
				case 2:
					this.colorName = 'blue';
					break;
				case 3:
					this.colorName = 'white';
					break;
			}
		}
		
		public function getColorNumber():int {
			return this.colorNumber;
		}
		
		public function getColorName():String {
			return this.colorName;
		}
	}
}