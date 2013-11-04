package {
	/**
	 * @author ethanis
	 */
	public class Candy {
<<<<<<< HEAD
		var color:String
		public static const COLOR_RED:String = 'red';
		public static const COLOR_BLUE:String = 'blue';
		public static const COLOR_WHITE:String = 'white';
=======
		var color:String;
		const COLOR_RED:String = 'red';
		const COLOR_BLUE:String = 'blue';
		const COLOR_WHITE:String = 'white';
>>>>>>> b2eb9af646903b7c1516c4e16d5f265e3ebb178c
		
		public function Candy(color:String = COLOR_RED){
			this.color = color;
			
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
		}
	}
}