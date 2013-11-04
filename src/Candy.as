package {
	/**
	 * @author ethanis
	 */
	public class Candy {
		var color:String;
		const COLOR_RED:String = 'red';
		const COLOR_BLUE:String = 'blue';
		const COLOR_WHITE:String = 'white';
		
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