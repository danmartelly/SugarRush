package
{
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{
		
		private var _timer:Number = 0;
		private const changeWalkDirectionRate:Number = 5;
		
		public function Enemy(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			velocity.y = 5;
		}
		
		override public function update():void {
			//random behavior when the player is not close by
			_timer += FlxG.elapsed;
			if (_timer > changeWalkDirectionRate) {
				_timer = 0;
				velocity.y = FlxG.random()*6 - 3;
				velocity.x = FlxG.random()*6 - 3;
			}
		}
	}
}