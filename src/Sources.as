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
		[Embed(source="../assets/tomato.png")] public static var tomatoEnemy:Class;
		[Embed(source="../assets/carrot.png")] public static var carrotEnemy:Class;
		//music and sound effects
		
		//text
		
		var enemyMap:Object = {
			"tomato": tomatoEnemy,
			"carrot": carrotEnemy
		};
	}
}