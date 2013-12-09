package
{
	import org.flixel.*;
	
	public class WeaponDescriptorUI extends FlxGroup
	{
		
		protected var _background:FlxSprite;
		protected var _specialPreText:FlxText;
		protected var _specialText:FlxText;
//		protected var _specialIcon:FlxSprite; // optional
		protected var _descriptionText:FlxText;
		protected var _weaponName:FlxText;
		
		private var exploreHUD:ExploreHUD;
		
		public function WeaponDescriptorUI(exploreHUD:ExploreHUD, MaxSize:uint=0)
		{
			super(MaxSize);
			this.exploreHUD = exploreHUD;
			
			_background = new FlxSprite(0, 340).makeGraphic(260, 67, 0xaa7b421c);
			_background.scrollFactor.x = _background.scrollFactor.y = 0;
			add(_background);
			
			_weaponName = new FlxText(3, 342, 252, "Weapon Name");
			_weaponName.setFormat("COOKIES",13,0xffffffff,"left");
			_weaponName.scrollFactor.x = _weaponName.scrollFactor.y = 0;
			add(_weaponName);
			
			_specialPreText = new FlxText(3, 358, 100, "Special : ");
			_specialPreText.setFormat("COOKIES",15,0xffffffff,"left");
			_specialPreText.scrollFactor.x = _specialPreText.scrollFactor.y = 0;
			add(_specialPreText);
			
			_specialText = new FlxText(72, 358, 200, "Burn");
			_specialText.setFormat("COOKIES",15,0xffffffff,"left");
			_specialText.scrollFactor.x = _specialText.scrollFactor.y = 0;
			add(_specialText);
			
//			_specialIcon = new FlxSprite(233, 372).makeGraphic(20, 20, 0xff000044);
//			_specialIcon.scrollFactor.x = _specialIcon.scrollFactor.y = 0;
//			add(_specialIcon);
			
			_descriptionText = new FlxText(3, 374, 252, "It burns you duh!");
			_descriptionText.setFormat("COOKIES",13,0xffffffff,"left");
			_descriptionText.scrollFactor.x = _descriptionText.scrollFactor.y = 0;
			add(_descriptionText);
		}
		
		override public function update():void {
			super.update();
			// find out which weapon if any is being hovered over.
			// -1 indicates that no weapon is hovered over
			var weaponIndex:int = exploreHUD.mouseHover();
			if (weaponIndex < 0) {
				this.visible = false;
			} else {
				this.visible = true;
				var weapon:Weapon = Inventory.getWeapons()[weaponIndex];
				var buff:Buff = weapon.getBuff();
				this._specialText.text = buff.name;
				this._descriptionText.text = buff.desc;
				this._weaponName.text = weapon.displayName;
			}
			
		}
	}
}