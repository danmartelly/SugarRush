package {
	/**
	 * @author ethanis
	 */
	public class Candy {
		private var color:String;
		public static const COLOR_RED:String = 'red';
		public static const COLOR_BLUE:String = 'blue';
		public static const COLOR_WHITE:String = 'white';
		
		public function Candy(color:String = COLOR_RED){
			this.color = color;
			/*
			switch (this.color){
		
				case 'red':
					trace('red candy');
					break;
				
				case 'blue':
					trace('blue candy');
					break;
				
				case 'white':
					trace('white candy');
					break;
			}
			*/
		}
		
		public function getColor():String {
			return this.color;
		}
	}
}