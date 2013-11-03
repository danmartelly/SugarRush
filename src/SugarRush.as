package
{
	import org.flixel.*;
	
	[SWF(width="1200", height="800", backgroundColor="#ffffff", frameRate="30")]
	public class SugarRush extends FlxGame
	{
		public function SugarRush()
		{
			super(1200, 800, BattlePlayState, 1);
		}
	}
}