package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	public class BattleInventoryMenu extends FlxGroup
	{
		private var background:FlxSprite;
		private var endButton:FlxButton;
		private var squares:FlxGroup = new FlxGroup();
		private var inventoryCallback:Function;
		
		public function BattleInventoryMenu(inventoryCallback:Function)
		{
			background = new FlxSprite(210, 130);
			background.makeGraphic(193,280,0xff000000);
			add(background);
			background.visible = true;
			var weapons:Array = Inventory.getWeapons();
			
			for (var i:int = 0; i < weapons.length; i++) {
				var row:int = Math.floor(i/3);
				var col:int = i % 3;
				if (i == 9){ col = 1; }
				
				var weapon:Weapon = weapons[i];
				var square:FlxSprite = new FlxButton(220 + 60*col, 140 + 60*row, weapon.name, itemCallbackFn(i));
				square.makeGraphic(50, 50, 0xff00ff00);
				squares.add(square);
				add(square);
			}
			
			this.inventoryCallback = inventoryCallback;
						
			endButton = new FlxButton(263, 380, "Cancel", cancelCallback);
			endButton.draw();
			endButton.visible = true;
			add(endButton);
		}
		
		private function itemCallbackFn(i:int): Function
		{
			return function():void {
				inventoryCallback(i);
				cancelCallback();
			};
		}
		
		private function cancelCallback():void
		{
			this.exists = false;
			endButton.exists = false;
		}
		
		
	}
}