package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class NewUIHUD extends FlxState
	{
		private var attackButton:FlxButton;
		private var eatButton:FlxButton;
		private var attackSprite:FlxSprite;
		private var eatSprite:FlxSprite;
		
		public function NewUIHUD(){
			FlxG.bgColor = 0xff00ff00;
			add(new FlxSprite(0,407).makeGraphic(90,30,0xffff0000));
			attackButton = new FlxButton(5, 412, "ATTACK", renderAttackSprite);
			add(new FlxSprite(90,407).makeGraphic(90,30,0xff0000ff));
			eatButton = new FlxButton(95, 412, "EAT", renderEatSprite);
			
			attackSprite = new FlxSprite(0, 437);
			attackSprite.makeGraphic(640,150,0xffff0000);
			attackSprite.visible = true;
			add(attackSprite);
			
			eatSprite = new FlxSprite(0, 437);
			eatSprite.makeGraphic(640,150,0xff0000ff);
			eatSprite.visible = false;
			add(eatSprite);
			
			add(attackButton);
			add(eatButton);
			FlxG.mouse.show();
			

		}
		
		private function renderWeapons():void {
			
		}
		
		private function renderEatSprite():void
		{
			attackSprite.visible = false;
			eatSprite.visible = true;
//			attackButton.active = true;
//			eatButton.active = false;			
			
		}
		
		private function renderAttackSprite():void
		{
			attackSprite.visible = true;
			eatSprite.visible = false;
//			attackButton.active = false;
//			eatButton.active = true;
			
		}
	}
}