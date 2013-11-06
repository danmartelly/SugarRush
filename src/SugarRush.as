package
{
	import org.flixel.*;
	[SWF(width="600", height="480", backgroundColor="#000000")]
	public class SugarRush extends FlxGame
	{
		public function SugarRush()
		{

			super(640, 480, SplashScreenState, 1);
			PlayerData.instance.initialize();
		}
	}
}