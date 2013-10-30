package
{
	import org.flixel.FlxSprite;
	
	public class Enemy extends FlxSprite
	{
		public function Enemy(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
		}
		
		override public function update():void {
			velocity.y = 3;
			velocity.x = 3;
		}
	}
}