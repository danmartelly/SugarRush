package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxGroup;

	public class NewUIHUD extends FlxState
	{
		private var attackButton:FlxButton;
		private var eatButton:FlxButton;
		private var attackSprite:FlxSprite;
		private var eatSprite:FlxSprite;
		private var weaponGroup:FlxGroup;
		private var candyGroup:FlxGroup;
		
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
			weaponGroup = renderWeapons();
			add(weaponGroup);
			candyGroup = renderCandy();
			candyGroup.visible = false;
			add(candyGroup);
			FlxG.mouse.show();
			

		}
		
		private function renderWeapons():FlxGroup {
			var weapons:FlxGroup = new FlxGroup();
			var weapon_count:Number = Inventory.weaponCount();
			for(var i:Number = 0; i < weapon_count; i++){
				weapons.add(new FlxSprite(i * 40 + 5, 440).makeGraphic(30,30,0xff00ff00));
			}
			return weapons;
		}
		
		private function renderCandy():FlxGroup {
			var candies:FlxGroup = new FlxGroup();
			var i:Number;
			for(i = 0; i < Inventory.candyCount(Inventory.COLOR_RED); i++){
				candies.add(new FlxSprite(i* 40 + 5, 440).makeGraphic(30,30,0xffff0000));
			}
			var lastI:Number = (i+1) * 40 + 5;
			for(i = 0; i < Inventory.candyCount(Inventory.COLOR_WHITE); i++){
				candies.add(new FlxSprite(i* 40 + lastI, 440).makeGraphic(30,30,0xffffffff));
			}
			
			lastI = (i+1) * 40 + 5;
			for(i = 0; i < Inventory.candyCount(Inventory.COLOR_BLUE); i++){
				candies.add(new FlxSprite(i* 40 + lastI, 440).makeGraphic(30,30,0xff000099));
			}
			return candies;
		}
		
		private function renderEatSprite():void
		{
			attackSprite.visible = false;
			eatSprite.visible = true;		
			weaponGroup.visible = false;
			candyGroup.visible = true;
		}
		
		private function renderAttackSprite():void
		{
			attackSprite.visible = true;
			eatSprite.visible = false;
			weaponGroup.visible = true;
			candyGroup.visible = false;
			
		}
	}
}