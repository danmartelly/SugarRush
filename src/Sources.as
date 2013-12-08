package  
{
	public class Sources 
	{                
		//images and spritesheets 
		[Embed(source="../assets/player/player_back.png")] public static var playerBack:Class;
		[Embed(source="../assets/player/player_front.png")] public static var playerFront:Class;
		[Embed(source="../assets/player/player_left.png")] public static var playerLeft:Class;
		[Embed(source="../assets/player/player_right.png")] public static var playerRight:Class;
		
		[Embed(source="../assets/player/playerb_fight.png")] public static var battlePlayer:Class;
		[Embed(source="../assets/player/playerb_hurt.png")] public static var battlePlayerHurt:Class;	
		[Embed(source="../assets/player/playerb_eat.png")] public static var battlePlayerEat:Class;	
		[Embed(source="../assets/player/playerb_attack.png")] public static var battlePlayerAttack:Class;	
		
		[Embed(source="../assets/player/playerwalk.png")] public static var playerWalk:Class;
		
		[Embed(source="../assets/rawcandy_blue.png")] public static var candyBlue:Class;	
		[Embed(source="../assets/rawcandy_red.png")] public static var candyRed:Class;	
		[Embed(source="../assets/rawcandy_white.png")] public static var candyWhite:Class;
		[Embed(source="../assets/rawcandy_disabled.png")] public static var candyDisabled:Class;
		[Embed(source="../assets/rawcandy_blueb.png")] public static var candyBlueBig:Class;	
		[Embed(source="../assets/rawcandy_redb.png")] public static var candyRedBig:Class;	
		[Embed(source="../assets/rawcandy_whiteb.png")] public static var candyWhiteBig:Class;
		[Embed(source="../assets/rawcandy_disabledb.png")] public static var candyDisabledBig:Class;

		[Embed(source="../assets/enemies/broccolisprite.png")] public static var Broccoli:Class;	
		[Embed(source="../assets/enemies/broccoli_small.png")] public static var SmallBroccoli:Class;
		[Embed(source="../assets/enemies/tomatosprite.png")] public static var Tomato:Class;
		[Embed(source="../assets/enemies/tomato_small.png")] public static var SmallTomato:Class;
		[Embed(source="../assets/enemies/carrotsprite.png")] public static var Carrot:Class;
		[Embed(source="../assets/enemies/carrot_small.png")] public static var SmallCarrot:Class;
		[Embed(source="../assets/enemies/eggplantsprite.png")] public static var Eggplant:Class;
		[Embed(source="../assets/enemies/eggplant_small.png")] public static var SmallEggplant:Class;
		[Embed(source="../assets/enemies/cabbagesprite.png")] public static var Lettuce:Class;	
		[Embed(source="../assets/enemies/lettuce_small.png")] public static var SmallLettuce:Class;
		[Embed(source="../assets/enemies/onionsprite.png")] public static var Onion:Class;	
		[Embed(source="../assets/enemies/onion_small.png")] public static var SmallOnion:Class;
		
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
		
		[Embed(source="../assets/button_red.png")] public static var buttonRed:Class;	
		[Embed(source="../assets/button_blue.png")] public static var buttonBlue:Class;	
		[Embed(source="../assets/button_green.png")] public static var buttonGreen:Class;	
		[Embed(source="../assets/button_orange.png")] public static var buttonOrange:Class;

		[Embed(source="../assets/cauldron.png")] public static var Cauldron:Class;
		[Embed(source="../assets/treasure.png")] public static var TreasureChest:Class;
		[Embed(source="../assets/crafthouse.png")] public static var CraftHouse:Class;
		[Embed(source="../assets/portal.png")] public static var Portal:Class;
		[Embed(source="../assets/portal_sheet.png")] public static var PortalSheet:Class;
		
		[Embed(source="../assets/backdrops/instructions.png")] public static var Instructions:Class;
		[Embed(source="../assets/backdrops/instructions_small.png")] public static var InstructionsSmall:Class;

		[Embed(source="../assets/backdrops/battle_background.png")] public static var BattleBackground:Class;
		[Embed(source="../assets/backdrops/win.png")] public static var WinBackground:Class;
		[Embed(source="../assets/backdrops/lose.png")] public static var LoseBackground:Class;
		[Embed(source="../assets/backdrops/intro1.png")] public static var intro1:Class;
		[Embed(source="../assets/backdrops/intro2.png")] public static var intro2:Class;
		[Embed(source="../assets/backdrops/intro3.png")] public static var intro3:Class;
		
		public static const intros:Array=[intro1, intro2, intro3, Instructions];
		
		[Embed(source="../assets/backdrops/map_clouds.png")] public static var mapClouds:Class;
		[Embed(source="../assets/backdrops/map.png")] public static var ExploreBackground:Class;	
		[Embed(source="../assets/backdrops/map1.png")] public static var map1:Class;
		[Embed(source="../assets/backdrops/map2.png")] public static var map2:Class;
		[Embed(source="../assets/backdrops/map3.png")] public static var map3:Class;
		[Embed(source="../assets/backdrops/map4.png")] public static var map4:Class;
		[Embed(source="../assets/backdrops/map5.png")] public static var map5:Class;
		public static const maps:Array=[map1, map2, map3, map4, map5];
		
		[Embed(source="../assets/cursor.png")] public static var cursor:Class;
		[Embed(source="../assets/craftbutton.png")] public static var CraftButton:Class;
		
		[Embed(source="../assets/backdrops/instructions2.png")] public static var Instructions2:Class;
		[Embed(source="../assets/backdrops/instructions_small.png")] public static var instrucSmall:Class;
		[Embed(source="../assets/backdrops/title.png")] public static var SplashScreenBackground:Class;
		
		//fonts
		// Even if we comment this out it seems to still work?
		//because they're also put into each class that uses them.
		//since the code uses this by referring to the string "COOKIES", i'm not...really sure how it works
		[Embed(source="../assets/Cookies.ttf", fontName="COOKIES", embedAsCFF="false")] public static var fontCookies:Class;
		
		//music and sound effects
		[Embed(source="../assets/sound/player_hurt.mp3")] public static var playerHurt:Class;
		[Embed(source="../assets/sound/vegetable_hurt1.mp3")] public static var vegetableHurt1:Class;
		[Embed(source="../assets/sound/vegetable_hurt2.mp3")] public static var vegetableHurt2:Class;
		[Embed(source="../assets/sound/battle_start.mp3")] public static var battleStart:Class;
		[Embed(source="../assets/sound/explosion.mp3")] public static var explosion:Class;
		[Embed(source="../assets/sound/death.mp3")] public static var death:Class;
		[Embed(source="../assets/sound/treasure.mp3")] public static var treasure:Class;
		[Embed(source="../assets/sound/max_health.mp3")] public static var maxHealth:Class;
		[Embed(source="../assets/sound/gain_health.mp3")] public static var gainHealth:Class;
		[Embed(source="../assets/sound/burn.mp3")] public static var burn:Class;
		[Embed(source="../assets/sound/freeze.mp3")] public static var freeze:Class;
		[Embed(source="../assets/sound/empty.mp3")] public static var empty:Class;
		[Embed(source="../assets/sound/craft_weapon.mp3")] public static var craftWeapon:Class;
		[Embed(source="../assets/sound/select.mp3")] public static var select:Class;
		[Embed(source="../assets/sound/deselect.mp3")] public static var deselect:Class;
		[Embed(source="../assets/sound/error.mp3")] public static var error:Class;
		
		// candy stuff
		public static const candies:Array = [candyRed, candyBlue, candyWhite];
		
		//buff stuff
		public static const defaultBuffStrings:Array = ["hit", "hit", "hit", "equip", "hit", "hit", "equip", "equip", "equip", "equip"];
		
		//text
		public static const enemyNames:Array = ["broccoli", "tomato", "carrot", "eggplant", "lettuce", "onion"];
		public static const enemyExploreSpriteMap:Object = {
			"broccoli": SmallBroccoli,
			"tomato": SmallTomato,
			"carrot": SmallCarrot,
			"eggplant": SmallEggplant,
			"lettuce": SmallLettuce,
			"onion": SmallOnion
		};
		public static const enemyBattleSpriteMap:Object = {
			"broccoli": Broccoli,
			"tomato": Tomato,
			"carrot": Carrot,
			"eggplant": Eggplant,
			"lettuce": Lettuce,
			"onion": Onion
		};
		
	}
}