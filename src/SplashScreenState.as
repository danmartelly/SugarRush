package
{
	import org.flixel.*;
	
	public class SplashScreenState extends FlxState
	{
		[Embed(source="assets/title.png")] protected var backgroundImg:Class;
		
		public var background:FlxSprite;
		private var _timer:Number = 0;
		private const switchScreenTime:Number = 4;
		private const startFadeEffectTime:Number = switchScreenTime/2;
		private var mFade:Number;
		private var bFade:Number;
		
		public function SplashScreenState()
		{
			mFade = 1/(startFadeEffectTime - switchScreenTime);
			bFade = 0 - mFade*switchScreenTime;
			background = new FlxSprite(0,0);
			background.loadGraphic(backgroundImg);
			add(background);
		}
		
		override public function update():void {
			_timer += FlxG.elapsed;
			if (_timer > switchScreenTime || FlxG.keys.any()) {
				FlxG.switchState(new ExplorePlayState());
			}
			//fade the background after a certain amount of time to 0
			background.alpha = Math.min(mFade*_timer+bFade,1);
		}
	}
}