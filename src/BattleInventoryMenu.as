package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;

	public class BattleInventoryMenu extends FlxGroup
	{
		private var background:FlxSprite;
		private var endButton:FlxButton;
		public function BattleInventoryMenu()
		{
//			background = new FlxSprite(220, 140);
//			background = new FlxSprite(220, 140).makeGraphic(200, 200, 0x00ff00);
//			background.draw();
//			background.visible = true;
//			add(background);
			
			endButton = new FlxButton(330, 250, "Cancel", cancelCallback);
			endButton.draw();
			endButton.visible = true;
			add(endButton);
			
			
		}
		
		private function cancelCallback():void
		{
			this.destroy();
		}
		
		
	}
}