package
{
	
	import org.flixel.*;
	
	
	public class PauseState extends FlxGroup
	{
		private var _bg:FlxSprite;
		private var _field:FlxText;
		private var _unpause:FlxText;
		public var showing:Boolean;
		
		private var _buffInfo:FlxText;
		private var _buffTitles:FlxText;
		private var _buffBackground:FlxSprite;
		
		internal var _displaying:Boolean;
		
		private var _finishCallback:Function;
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		public function PauseState()
		{
			var cover:FlxSprite = new FlxSprite(0,0);
			cover.makeGraphic(FlxG.width,FlxG.height,0x88ffffff);
			cover.scrollFactor.x=cover.scrollFactor.y=0;
			add(cover);
			
			_field = new FlxText(0,80, FlxG.width, "Paused");
			_field.setFormat("COOKIES", 30, 0xff000000, "center");
			_field.scrollFactor.x = _field.scrollFactor.y = 0;
			add(_field);
			
			_unpause = new FlxText(0,110, FlxG.width,
				"Press space to unpause");
			_unpause.setFormat("COOKIES", 20, 0xff000000, "center");
			_unpause.scrollFactor.x = _unpause.scrollFactor.y = 0;
			add(_unpause);
			
			_buffBackground = new FlxSprite(60,165);
			_buffBackground.makeGraphic(FlxG.width-100,140,0xffa86d46);
			_buffBackground.scrollFactor.x = _buffBackground.scrollFactor.y = 0;
			//add(_buffBackground);
			
			_buffTitles = new FlxText(20,170, 150,
				"Burn:\n" +
				"Freeze:\n" +
				"Drain:\n" +
				"Ignite:\n" +
				"Deep Freeze:\n" +
				"Mega Drain:\n" +
				"Pierce:\n" +
				"Dispel:\n" +
				"Cascade:");
			_buffTitles.setFormat("COOKIES", 15, 0xffffffff, "right");
			_buffTitles.scrollFactor.x = _buffTitles.scrollFactor.y = 0;
			//add(_buffTitles);
			
			_buffInfo = new FlxText(170,170, FlxG.width-170-20,
				"Chance of burn, damages the enemy over time.\n" +
				"Freezes enemy for one turn.\n" +
				"Chance of +1 blood sugar.\n" +
				"Burn, damages the enemy over time.\n" +
				"Freezes enemy for two turns.\n" +
				"Restores one point of blood sugar on hit.\n" +
				"Ignore the enemy\'s defense.\n" +
				"Removes status effects on the enemy for more damage.\n" +
				"Stronger with repeated attacks.");
			_buffInfo.setFormat("COOKIES", 15, 0xffffffff, "left");
			_buffInfo.scrollFactor.x = _buffInfo.scrollFactor.y = 0;
			//add(_buffInfo);
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