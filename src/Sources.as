package  
{
	public class Sources 
	{                
		//images and spritesheets 
		[Embed(source="../assets/player_back.png")] public static var playerBack:Class;
		[Embed(source="../assets/player_front.png")] public static var playerFront:Class;
		[Embed(source="../assets/player_left.png")] public static var playerLeft:Class;
		[Embed(source="../assets/player_right.png")] public static var playerRight:Class;
		[Embed(source="../assets/map.png")] public static var ExploreBackground:Class;	
		[Embed(source="../assets/playerb_fight.png")] public static var battlePlayer:Class;
		[Embed(source="../assets/playerb_hurt.png")] public static var battlePlayerHurt:Class;	
		[Embed(source="../assets/playerb_eat.png")] public static var battlePlayerEat:Class;	
		[Embed(source="../assets/playerb_attack.png")] public static var battlePlayerAttack:Class;	

		[Embed(source="../assets/tomatosprite.png")] public static var Tomato:Class;
		[Embed(source="../assets/carrotsprite.png")] public static var Carrot:Class;
		[Embed(source="../assets/eggplantsprite.png")] public static var Eggplant:Class;
		[Embed(source="../assets/lettucesprite.png")] public static var Lettuce:Class;		
		
		//music and sound effects
		
		//text
		public static const enemyNames:Array = ["tomato", "carrot", "eggplant", "lettuce"];
		public static const enemyMap:Object = {
			"tomato": Tomato,
			"carrot": Carrot,
			"eggplant": Eggplant,
			"lettuce": Lettuce
		};
	}
}