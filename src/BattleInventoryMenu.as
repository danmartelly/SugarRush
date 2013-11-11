package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	public class BattleInventoryMenu extends FlxGroup
	{
		private var background:FlxSprite;
		private var endButton:FlxButton;
		public function BattleInventoryMenu()
		{
			background = new FlxSprite(210, 130);
			background.makeGraphic(193,280,0xff000000);
			add(background);
			background.visible = true;
			
			var square:FlxSprite = new FlxSprite(220, 140);
			square.makeGraphic(50,50, 0xff00ff00);
			add(square);
			square.visible = true;
			
			square = new FlxSprite(280, 140);
			square.makeGraphic(50, 50, 0xff00ff00);
			add(square);
			
			square = new FlxSprite(340, 140);
			square.makeGraphic(50, 50, 0xff00ff00);
			add(square);
			
			square = new FlxSprite(220, 200);
			square.makeGraphic(50,50,0xff00ff00);
			add(square);
			
			square = new FlxSprite(280, 200);
			square.makeGraphic(50,50,0xff00ff00);
			add(square);
			
			square = new FlxSprite(340, 200);
			square.makeGraphic(50,50,0xff00ff00);
			add(square);
			
			square = new FlxSprite(220, 260);
			square.makeGraphic(50,50,0xff00ff00);
			add(square);
			
			square = new FlxSprite(280, 260);
			square.makeGraphic(50,50,0xff00ff00);
			add(square);
			
			square = new FlxSprite(340, 260);
			square.makeGraphic(50,50,0xff00ff00);
			add(square);
			
			square = new FlxSprite(280, 320);
			square.makeGraphic(50,50,0xff00ff00);
			add(square);
			
			
			endButton = new FlxButton(263, 380, "Cancel", cancelCallback);
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