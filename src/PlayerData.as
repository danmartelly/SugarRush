package
{
	public class PlayerData
	{
		private static var _instance:PlayerData;
		public var weapons:Array;
		public var health:Number;
		
		// Follows the Singleton design pattern
		private function PlayerData()
		{
		}
		
		public static function get instance():PlayerData {
			if (_instance == null) {
				_instance = new PlayerData();
			}
			return _instance;
		}
		
		public function reset(initialWeapons:Array = null, initialHealth:Number = 10) {
			if (initialWeapons == null) {
				weapons = new Array();
			} else {
				weapons = initialWeapons;
			}
			health = initialHealth;
		}
		
		public function playerHasDied():Boolean {
			return health <= 0;
		}
		
		public function addWeapon(newWeapon:Weapon):void {
			weapons.push(newWeapon);
		}
		
		public function changeHealthBy(changeInHealth:Number) {
			health += changeInHealth;
		}
	}
}