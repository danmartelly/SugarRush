package {
	/**
	 * @author ethanis
	 */
	public class Candy {
		private var colorNumber:int;
		private var colorName:String;
		
		public static const COLOR_RED:int = 0;
		public static const COLOR_BLUE:int = 1;
		public static const COLOR_WHITE:int = 2;
		
		public function Candy(colorNumber:int = COLOR_RED){
			this.colorNumber = colorNumber;
			switch (this.colorNumber){
				case COLOR_RED:
					this.colorName = 'red';
					break;
				case COLOR_BLUE:
					this.colorName = 'blue';
					break;
				case COLOR_WHITE:
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