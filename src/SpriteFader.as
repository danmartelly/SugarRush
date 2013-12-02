package {
	import mx.utils.NameUtil;
	import org.flixel.FlxTimer;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;

//	HI LILI!	
//	This is an example of how to use the fader!

//	var red:FlxSprite = new FlxSprite(0,0);
//	red.makeGraphic(50, 50, 0xffff0000);
//	var blue:FlxSprite = new FlxSprite(0,0);
//	blue.makeGraphic(50, 50, 0xff0000ff);
//	var fader:SpriteFader = new SpriteFader(red, blue);
//	add(fader);
//	fader.animate(5.0);
	 
	public class SpriteFader extends FlxGroup {
		private var _isFading:Boolean = false;
		private var _increment:Number = 0.01;
		private var _fromImage:FlxSprite;
		private var _toImage:FlxSprite;
		
		public function SpriteFader(fromImage:FlxSprite, toImage:FlxSprite = null){
			_fromImage = fromImage;
			_toImage = toImage;
			
			this.reset();
			if (_toImage){
				this.add(_toImage);
			}
			this.add(_fromImage);
		}
		
		public function reset():void {
			_fromImage.alpha = 1.0;
			if (_toImage){
				_toImage.alpha = 0.0;
			}
		}
		
		override public function update():void {
			if (_isFading == true){
				_fromImage.alpha -= _increment;
				if (_toImage){
					_toImage.alpha += _increment;
				}
			}
			
			if (_fromImage.alpha <= 0){
				_fromImage.alpha = 0;
				_isFading = false;
			}
			
			super.update();
		}
		
		public function replaceImages(from:FlxSprite, to:FlxSprite):void{
			_fromImage=from;
			_toImage=to;
			reset();
		}
		
		public function animate(seconds:Number = 1.0):void {
			_increment = 1.0 / (seconds * FlxG.framerate);
			_isFading = true;
		}
	}
}
