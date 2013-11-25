package  
{
	public class Sources 
	{                
		//images and spritesheets 
		[Embed(source="../assets/player_back.png")] public static var playerBack:Class;
		[Embed(source="../assets/player_front.png")] public static var playerFront:Class;
		[Embed(source="../assets/player_left.png")] public static var playerLeft:Class;
		[Embed(source="../assets/player_right.png")] public static var playerRight:Class;
		[Embed(source="../assets/playerb_fight.png")] public static var battlePlayer:Class;
		[Embed(source="../assets/playerb_hurt.png")] public static var battlePlayerHurt:Class;	
		[Embed(source="../assets/playerb_eat.png")] public static var battlePlayerEat:Class;	
		[Embed(source="../assets/playerb_attack.png")] public static var battlePlayerAttack:Class;	
		
		[Embed(source="../assets/rawcandy_blue.png")] public static var candyBlue:Class;	
		[Embed(source="../assets/rawcandy_red.png")] public static var candyRed:Class;	
		[Embed(source="../assets/rawcandy_white.png")] public static var candyWhite:Class;
		[Embed(source="../assets/rawcandy_disabled.png")] public static var candyDisabled:Class;
		[Embed(source="../assets/rawcandy_blueb.png")] public static var candyBlueBig:Class;	
		[Embed(source="../assets/rawcandy_redb.png")] public static var candyRedBig:Class;	
		[Embed(source="../assets/rawcandy_whiteb.png")] public static var candyWhiteBig:Class;
		[Embed(source="../assets/rawcandy_disabledb.png")] public static var candyDisabledBig:Class;

		[Embed(source="../assets/enemies/tomatosprite.png")] public static var Tomato:Class;
		[Embed(source="../assets/enemies/tomato_small.png")] public static var SmallTomato:Class;
		[Embed(source="../assets/enemies/carrotsprite.png")] public static var Carrot:Class;
		[Embed(source="../assets/enemies/carrot_small.png")] public static var SmallCarrot:Class;
		[Embed(source="../assets/enemies/eggplantsprite.png")] public static var Eggplant:Class;
		[Embed(source="../assets/enemies/eggplant_small.png")] public static var SmallEggplant:Class;
		[Embed(source="../assets/enemies/lettucesprite.png")] public static var Lettuce:Class;	
		[Embed(source="../assets/enemies/lettuce_small.png")] public static var SmallLettuce:Class;
		
		[Embed(source="../assets/weapons/axe_candycane.png")] public static var AxeCane:Class;
		[Embed(source="../assets/weapons/axe_chocolate.png")] public static var AxeChocolate:Class;
		[Embed(source="../assets/weapons/axe_cottoncandy.png")] public static var AxeCotton:Class;
		[Embed(source="../assets/weapons/axe_gumdrop.png")] public static var AxeGumdrop:Class;
		[Embed(source="../assets/weapons/axe_marshmallow.png")] public static var AxeMarsh:Class;
		[Embed(source="../assets/weapons/scythe_candycane.png")] public static var ScytheCane:Class;
		[Embed(source="../assets/weapons/scythe_chocolate.png")] public static var ScytheChocolate:Class;
		[Embed(source="../assets/weapons/scythe_cottoncandy.png")] public static var ScytheCotton:Class;
		[Embed(source="../assets/weapons/scythe_gumdrop.png")] public static var ScytheGumdrop:Class;
		[Embed(source="../assets/weapons/scythe_marshmallow.png")] public static var ScytheMarsh:Class;
		[Embed(source="../assets/weapons/star_candycane.png")] public static var StarCane:Class;
		[Embed(source="../assets/weapons/star_chocolate.png")] public static var StarChocolate:Class;
		[Embed(source="../assets/weapons/star_cottoncandy.png")] public static var StarCotton:Class;
		[Embed(source="../assets/weapons/star_gumdrop.png")] public static var StarGumdrop:Class;
		[Embed(source="../assets/weapons/star_marshmallow.png")] public static var StarMarsh:Class;
		[Embed(source="../assets/weapons/sword_candycane.png")] public static var SwordCane:Class;
		[Embed(source="../assets/weapons/sword_chocolate.png")] public static var SwordChocolate:Class;
		[Embed(source="../assets/weapons/sword_cottoncandy.png")] public static var SwordCotton:Class;
		[Embed(source="../assets/weapons/sword_gumdrop.png")] public static var SwordGumdrop:Class;
		[Embed(source="../assets/weapons/sword_marshmallow.png")] public static var SwordMarsh:Class;
		
		[Embed(source="../assets/button_eat.png")] public static var buttonEat:Class;	
		[Embed(source="../assets/button_attack.png")] public static var buttonAttack:Class;	
		[Embed(source="../assets/button_run.png")] public static var buttonRun:Class;	
		[Embed(source="../assets/button_craft.png")] public static var buttonCraft:Class;

		[Embed(source="../assets/cauldron.png")] public static var Cauldron:Class;
		
		[Embed(source="../assets/backdrops/map.png")] public static var ExploreBackground:Class;	
		[Embed(source="../assets/backdrops/battle_background.png")] public static var BattleBackground:Class;
		[Embed(source="../assets/backdrops/instructions.png")] public static var Instructions:Class;
		[Embed(source="../assets/backdrops/win.png")] public static var WinBackground:Class;
		[Embed(source="../assets/backdrops/lose.png")] public static var LoseBackground:Class;
		[Embed(source="../assets/backdrops/instructions2.png")] public static var Instructions2:Class;
		
		//fonts
		// Even if we comment this out it seems to still work?
		//because they're also put into each class that uses them.
		//since the code uses this by referring to the string "COOKIES", i'm not...really sure how it works
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] public static var fontCookies:Class;
		
		//music and sound effects
		[Embed(source="../assets/sound/vegetable_hurt1.mp3")] public static var vegetableHurt1:Class;
		[Embed(source="../assets/sound/vegetable_hurt2.mp3")] public static var vegetableHurt2:Class;
		[Embed(source="../assets/sound/battle_start.mp3")] public static var battleStart:Class;
		
		//buff stuff
		
		public static const defaultBuffStrings:Array = ["hit", "hit", "hit", "hit", "hit", "equip", "equip", "equip", "equip", "equip"];
		
		//text
		public static const enemyNames:Array = ["tomato", "carrot", "eggplant", "lettuce"];
		public static const enemyExploreSpriteMap:Object = {
			"tomato": SmallTomato,
			"carrot": SmallCarrot,
			"eggplant": SmallEggplant,
			"lettuce": SmallLettuce
		};
		public static const enemyBattleSpriteMap:Object = {
			"tomato": Tomato,
			"carrot": Carrot,
			"eggplant": Eggplant,
			"lettuce": Lettuce
		};
	}
}