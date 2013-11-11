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
			background = new FlxSprite(220, 140);
			background.makeGraphic(100,100,0xff000000);
			add(background);
			background.visible = true;
			
			endButton = new FlxButton(330, 250, "Cancel", cancelCallback);
			endButton.draw();
			endButton.visible = true;
			add(endButton);
			
			
		}
		
		private function cancelCallback():void
		{
			this.exists = false;
			endButton.exists = false;
		}
		
		
	}
}