package
{
	
	import org.flixel.*;
	
	
	public class PauseState extends FlxGroup
	{
		private var _bg:FlxSprite;
		private var _field:FlxText;
		private var _unpause:FlxText;
		public var showing:Boolean;
		
		internal var _displaying:Boolean;
		
		private var _finishCallback:Function;
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		public function PauseState()
		{
			
			_field = new FlxText(0,200, FlxG.width, "Paused");
			_field.setFormat("COOKIES", 30, 0xff000000, "center");
			_field.scrollFactor.x = _field.scrollFactor.y = 0;
			add(_field);
			
			_unpause = new FlxText(0,230, FlxG.width,
				"Press space to unpause");
			_unpause.setFormat("COOKIES", 20, 0xff000000, "center");
			_unpause.scrollFactor.x = _unpause.scrollFactor.y = 0;
			add(_unpause);
		}
		
		public function showPaused():void
		{
			_displaying = true;
			showing = true;
		}
		
		override public function update():void
		{
			if (_displaying)
			{
				{
					_field.text = "Paused";
				}
				if(FlxG.keys.SPACE)
				{
					this.kill();
					this.exists = false;
					showing = false;
					_displaying = false;
					if (_finishCallback != null) _finishCallback();
					
				}
				else
				{
					
					showing = true;
					_displaying = true;
					
				}
				
				super.update();
			}
		}
		
		public function set finishCallback(val:Function):void
		{
			_finishCallback = val;
		}
		
	}
}