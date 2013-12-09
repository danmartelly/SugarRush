package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
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
		protected var _weaponInfo:FlxText;
		
		protected var _eatTab:FlxSprite;
		protected var _attackTab:FlxSprite;
		protected var _eatBackground:FlxSprite;
		protected var _attackBackground:FlxSprite;
		
		//eating button
		public var eatGroup:FlxGroup = new FlxGroup();
		public var _red:FlxButton = new FlxButton(FlxG.width * 0.635, FlxG.height * 0.925,"",candyCallback(Inventory.COLOR_RED));
		public var _blue:FlxButton = new FlxButton(FlxG.width * 0.735, FlxG.height * 0.925,"",candyCallback(Inventory.COLOR_BLUE));
		public var _white:FlxButton = new FlxButton(FlxG.width * 0.835, FlxG.height * 0.925,"",candyCallback(Inventory.COLOR_WHITE));
		
		protected var _inTab:Boolean=false; //true if a tab (attack, eat) is open
		public var _isEat:Boolean=false; //true if eat tab is open
		public var eatButton:FlxButton;
		
		// eatFunction expects 2 args: function(candy:int, healAmount:Number){}
		// baby type system is baby
		public var eatFunction:Function;
		
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] protected var fontCookies:Class;
		
		public function ExploreHUD(hasEat:Boolean = true)
		{	
			_inventoryBox = new FlxSprite(0, FlxG.height * 0.90).makeGraphic(FlxG.width, FlxG.height * 0.10, 0xFF7b421c);
			_inventoryBox.scrollFactor.x = _inventoryBox.scrollFactor.y = 0;
			_buttonBar = new FlxSprite(0, FlxG.height-FlxG.height * 0.10-25).makeGraphic(FlxG.width, 25, 0xffa86d46);
			_buttonBar.scrollFactor.x = _buttonBar.scrollFactor.y = 0;
			add(_inventoryBox);
			add(_buttonBar);
			
			_eatBackground=new FlxSprite(0, FlxG.height * 0.90).makeGraphic(FlxG.width, FlxG.height * 0.10, 0xffffb32d);
			_eatBackground.scrollFactor.x=_eatBackground.scrollFactor.y=0;
			_eatTab=new FlxSprite(FlxG.width/2-60, 420).makeGraphic(120, 15, 0xffffb32d);
			_eatTab.scrollFactor.x=_eatTab.scrollFactor.y=0;

			_attackBackground=new FlxSprite(0, FlxG.height * 0.90).makeGraphic(FlxG.width*0.5, FlxG.height * 0.10, 0xffff2329);
			_attackBackground.scrollFactor.x=_attackBackground.scrollFactor.y=0;
			_attackTab=new FlxSprite(2, 420).makeGraphic(120, 15, 0xffff2329);
			_attackTab.scrollFactor.x=_attackTab.scrollFactor.y=0;
			
			add(_attackTab);
			add(_attackBackground);
			
			//start off neutral state
			_eatTab.visible=false;
			_eatBackground.visible=false;
			_attackTab.visible=false;
			_attackBackground.visible=false;
			
			eatButton = new FlxButton(FlxG.width/2-60, 410, "EAT");
			eatButton.loadGraphic(Sources.buttonOrange);
			var eatLabel:FlxText=new FlxText(0,0,120,"EAT");
			eatLabel.setFormat("COOKIES", 17, 0xffffffff);
			eatLabel.alignment = "center";
			eatButton.label=eatLabel;
			eatButton.labelOffset=new FlxPoint(0,0);
			eatButton.scrollFactor.x = eatButton.scrollFactor.y = 0;
			eatButton.onDown = openCandyTab;
			
			if (hasEat){
				add(_eatTab);
				add(_eatBackground);
				add(eatButton);
			}
			
			_weaponsText = new FlxText(0, FlxG.height * 0.90, FlxG.width, "Weapons:");
			_candiesText = new FlxText(FlxG.width * 0.53, FlxG.height * 0.90, FlxG.width, "Candies:");
			_weaponsText.scrollFactor.x = _weaponsText.scrollFactor.y = 0;
			_candiesText.scrollFactor.x = _candiesText.scrollFactor.y = 0;
			_weaponsText.setFormat("COOKIES",15);
			_candiesText.setFormat("COOKIES",15);
			add(_weaponsText);
			add(_candiesText);
			
			_weaponInfo = new FlxText(125,FlxG.height-75,130, "");
			_weaponInfo.setFormat("COOKIES",15);
			_weaponInfo.color=0xffffffff;
			_weaponInfo.scrollFactor.x = _weaponInfo.scrollFactor.y = 0;
			add(_weaponInfo);
			
			_currentWeaponBox = new FlxSprite(0,0);
			_currentWeaponBox.makeGraphic(40, 40);
			_currentWeaponBox.fill(0x99ffffff);
			_currentWeaponBox.scrollFactor.x = _currentWeaponBox.scrollFactor.y = 0;
			add(_currentWeaponBox);
			_currentWeaponBox.visible=false;
			
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
			
			if (hasEat) {
				_red.makeGraphic(25,25,0xaaffffff);
				_red.scrollFactor.x = _red.scrollFactor.y = 0;
				_blue.makeGraphic(25,25,0xaaffffff);
				_blue.scrollFactor.x = _blue.scrollFactor.y = 0;
				_white.makeGraphic(25,25,0xaaffffff);
				_white.scrollFactor.x = _white.scrollFactor.y = 0;
				
				eatGroup.add(_red);
				eatGroup.add(_blue);
				eatGroup.add(_white);
			}
		}
		
		public function openAttack():void{
			remove(eatGroup);
			_inTab=true;
			_isEat=false;
			_eatTab.visible=false;
			_eatBackground.visible=false;
			_attackTab.visible=true;
			_attackBackground.visible=true;
		}
		
		public function openEat():void{
			add(eatGroup);
			_inTab=true;
			_isEat=true;
			_eatTab.visible=true;
			_eatBackground.visible=true;
			_attackTab.visible=false;
			_attackBackground.visible=false;
		}
		
		//closes both tabs, return to neutral state
		public function closeTab():void{
			_inTab=false;
			_isEat=false;
			_eatTab.visible=false;
			_eatBackground.visible=false;
			_attackTab.visible=false;
			_attackBackground.visible=false;
		}
		
		private function openCandyTab():void {
			if (!_isEat){
				this.openEat();
			} else {
				this.closeTab();
			}
		}
		
		private function weaponCallbackFn(i:int, that:ExploreHUD): Function
		{
			return function():void {
				PlayerData.instance.changeWeapon(i);
			};		
		}
		

		private function eatWeaponCallbackFn(i:int, that:ExploreHUD): Function {
			if(Inventory.weaponCount() > 1){
				return function():void {
					PlayerData.instance.changeWeapon(0);
					Inventory.removeWeaponAt(i);
					//hard coded
					eatFunction(-1,-5);
				};
			}else {
				return function():void {
					var x:FlxText = new FlxText(150,440,100,"This is your last weapon!");
					x.setFormat("COOKIES",14,0x000000);
					add(x);
				}
			}
			
		}
		
		public function candyCallback(color:int):Function {
			var that:ExploreHUD = this;
			
			return function():void {
				if (!PlayerData.instance.hasFullHealth() && Inventory.candyCount(color) > 0 ){
					FlxG.play(Sources.gainHealth);
					Inventory.removeCandy(color);
					var healAmount:Number = 5;
					PlayerData.instance.heal(healAmount);
					that.update();
					// here, call battle / overworld specific callback (eg: to change turn, etc)
					eatFunction(color, healAmount);
				} else {
					FlxG.play(Sources.error);
				}
			};
		}
		
		//checks if mouse is over a weapon
		//if yes, returns which weapon it is
		//if no, returns -1
		private function mouseHover():int{
			var x:int=FlxG.mouse.screenX;
			var y:int=FlxG.mouse.screenY;
			//check for each weapon if there's an overlap
			for (var i:int = 0; i < Inventory.weaponCount(); i++) {
				var weapon:Weapon = Inventory.getWeapons()[i];
				if (y>FlxG.height*0.91){
					var xPos:int=(FlxG.width/2) - ((4-i)*50) - 40;
					if (x>xPos && x<xPos+40){
						_weaponInfo.text=weapon.displayName;
						return i;
					}
				}
				
				if (i>4) return -1; //only displays 5 weapons
			}
			return -1;
		}
		
		override public function update():void {
			_redCount.text = "x" + Inventory.candyCount(0);
			_blueCount.text = "x" + Inventory.candyCount(1);
			_whiteCount.text = "x" + Inventory.candyCount(2);
			_healthLabel.text = "Health: " + PlayerData.instance.currentHealth;
			_killCount.text = "Kills: " + PlayerData.instance.killCount;
			
			//if _isEat, make it possible to select a candy
			
			for (var i:int = 0; i < Inventory.weaponCount(); i++) {
				var weapon:Weapon = Inventory.getWeapons()[i];
				var weaponSprite:FlxButton = _weaponSlots.recycle(FlxButton) as FlxButton;
				weaponSprite.x = (FlxG.width/2) - ((4-i)*50) - 40;	
				//weaponSprite.label = new FlxText(0, 0, 40, weapon.getDisplayName());
				weaponSprite.scrollFactor.x = weaponSprite.scrollFactor.y = 0;
				
				//weaponSprite.fill(0xFFFFFFFF);
				weaponSprite.y = FlxG.height * 0.91;

				//weaponSprite.label = new FlxText(0, 0, 40, weapon.displayName);
				weaponSprite.scrollFactor.x = weaponSprite.scrollFactor.y = 0;
				weaponSprite.loadGraphic(weapon.image);

				//weaponSprite.onDown = itemCallbackFn(i); //onUp doesn't work for some reason
				if (i == PlayerData.instance.currentWeaponIndex) {
					_currentWeaponBox.x = weaponSprite.x;
					_currentWeaponBox.y = weaponSprite.y;
				}
				
				//only want this to be possible if you are in eat/attack tab
				if (_inTab){
					if(!_isEat){
						weaponSprite.onDown = weaponCallbackFn(i,this); //onUp doesn't work for some reason
						//only show selection if we're in a tab
						_currentWeaponBox.visible=true;
					}else{
						weaponSprite.onDown = eatWeaponCallbackFn(i,this);
						_currentWeaponBox.visible=true;
					}
				} else {
					_currentWeaponBox.visible=false;
				}
			}
			
			mouseHover();
			
			super.update();
		}
	}
}