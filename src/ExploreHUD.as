package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class ExploreHUD extends FlxGroup
	{
		public var _healthLabel:FlxText;
		
		protected var _inventoryBox:FlxSprite;
		protected var _buttonBar:FlxSprite;
		protected var _inventoryDividerH:FlxSprite;
		protected var _inventoryDividerV:FlxSprite;
		protected var _weaponsText:FlxText;
		protected var _candiesText:FlxText;
		protected var _weaponSlots:FlxGroup;
		protected var _weaponStatsGroup:FlxGroup;
		protected var _redSprite:FlxSprite;
		protected var _blueSprite:FlxSprite;
		protected var _whiteSprite:FlxSprite;
		protected var _redCount:FlxText;
		protected var _blueCount:FlxText;
		protected var _whiteCount:FlxText;
		protected var _killCount:FlxText;
		protected var _currentWeaponBox:FlxSprite;
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		public function ExploreHUD()
		{	
			_inventoryBox = new FlxSprite(0, FlxG.height * 0.90).makeGraphic(FlxG.width, FlxG.height * 0.10, 0xFF7b421c);
			_inventoryBox.scrollFactor.x = _inventoryBox.scrollFactor.y = 0;
			_buttonBar = new FlxSprite(0, FlxG.height-FlxG.height * 0.10-25).makeGraphic(FlxG.width, 25, 0xffa86d46);
			_buttonBar.scrollFactor.x = _buttonBar.scrollFactor.y = 0;
			add(_inventoryBox);
			add(_buttonBar);
			
			_weaponsText = new FlxText(0, FlxG.height * 0.90, FlxG.width, "Weapons:");
			_candiesText = new FlxText(FlxG.width * 0.50, FlxG.height * 0.90, FlxG.width, "Candies:");
			_weaponsText.scrollFactor.x = _weaponsText.scrollFactor.y = 0;
			_candiesText.scrollFactor.x = _candiesText.scrollFactor.y = 0;
			_weaponsText.setFormat("COOKIES",15);
			_candiesText.setFormat("COOKIES",15);
			add(_weaponsText);
			add(_candiesText);
			
			_currentWeaponBox = new FlxSprite(0,0);
			_currentWeaponBox.makeGraphic(40, 40);
			_currentWeaponBox.fill(0x99ffffff);
			_currentWeaponBox.scrollFactor.x = _currentWeaponBox.scrollFactor.y = 0;
			add(_currentWeaponBox);
			
			_weaponSlots = new FlxGroup(5);
			add(_weaponSlots);
			_weaponStatsGroup = new FlxGroup(5);
			add(_weaponStatsGroup);
			
			_redSprite = new FlxSprite(FlxG.width * 0.63, FlxG.height * 0.92, Sources.candyRed);
			_blueSprite = new FlxSprite(FlxG.width * 0.73, FlxG.height * 0.92, Sources.candyBlue);
			_whiteSprite = new FlxSprite(FlxG.width * 0.83, FlxG.height * 0.92, Sources.candyWhite);
			_redSprite.scrollFactor.x = _redSprite.scrollFactor.y = 0;
			_blueSprite.scrollFactor.x = _blueSprite.scrollFactor.y = 0;
			_whiteSprite.scrollFactor.x = _whiteSprite.scrollFactor.y = 0;
			add(_redSprite);
			add(_blueSprite);
			add(_whiteSprite);
			
			_redCount = new FlxText(FlxG.width * 0.68, FlxG.height * 0.94, FlxG.width, "x" + Inventory.candyCount(0));
			_blueCount = new FlxText(FlxG.width * 0.78, FlxG.height * 0.94, FlxG.width, "x" + Inventory.candyCount(1));
			_whiteCount = new FlxText(FlxG.width * 0.88, FlxG.height * 0.94, FlxG.width, "x" + Inventory.candyCount(2));
			_redCount.scrollFactor.x = _redCount.scrollFactor.y = 0;
			_blueCount.scrollFactor.x = _blueCount.scrollFactor.y = 0;
			_whiteCount.scrollFactor.x = _whiteCount.scrollFactor.y = 0;
			_redCount.setFormat("COOKIES",13);
			_blueCount.setFormat("COOKIES",13);
			_whiteCount.setFormat("COOKIES",13);
			add(_redCount);
			add(_blueCount);
			add(_whiteCount);
			
			_healthLabel = new FlxText(FlxG.width - 90, FlxG.height - 90, 90, "Health: ");
			_healthLabel.scrollFactor.x = _healthLabel.scrollFactor.y = 0;
			_healthLabel.setFormat("COOKIES",15);
			_healthLabel.color=0xff000000;
			add(_healthLabel);
			
			_killCount = new FlxText(FlxG.width - 90, 10, 90, "Kills: ");
			_killCount.scrollFactor.x = _killCount.scrollFactor.y = 0;
			_killCount.setFormat("COOKIES", 15, 0xff000000);
			add(_killCount);
		}
		
		private function itemCallbackFn(i:int): Function
		{
			return function():void {
				PlayerData.instance.changeWeapon(i);
			};
		}
		
		override public function update():void {
			_redCount.text = "x" + Inventory.candyCount(0);
			_blueCount.text = "x" + Inventory.candyCount(1);
			_whiteCount.text = "x" + Inventory.candyCount(2);
			_healthLabel.text = "Health: " + PlayerData.instance.currentHealth;
			_killCount.text = "Kills: " + PlayerData.instance.killCount;
			
			for (var i:int = 0; i < Inventory.weaponCount(); i++) {
				var weapon:Weapon = Inventory.getWeapons()[i];
				var weaponSprite:FlxButton = _weaponSlots.recycle(FlxButton) as FlxButton;
				weaponSprite.x = (FlxG.width/2) - ((4-i)*50) - 40;
				weaponSprite.y = FlxG.height * 0.91;

				//weaponSprite.label = new FlxText(0, 0, 40, weapon.displayName);
				weaponSprite.scrollFactor.x = weaponSprite.scrollFactor.y = 0;
				weaponSprite.loadGraphic(weapon.image);
				weaponSprite.onDown = itemCallbackFn(i); //onUp doesn't work for some reason
				
				if (i == PlayerData.instance.currentWeaponIndex) {
					_currentWeaponBox.x = weaponSprite.x;
					_currentWeaponBox.y = weaponSprite.y;
				}
				
			}
			
			super.update();
		}
	}
}