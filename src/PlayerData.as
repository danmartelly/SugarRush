package
{
	public class PlayerData
	{
		private static var _instance:PlayerData;

		public var currentWeaponIndex:int = 0;
		public var currentHealth:int;
		public var maxHealth:int;
		
		public var startingWeapon:Weapon = new Weapon("starter", 1, 0, null);
		public var opWeapon:Weapon = new Weapon("OP", 50, 50, null);
		
		// Follows the Singleton design pattern
		public function PlayerData(lock:SingletonLock)
		{
		}
		
		public static function get instance():PlayerData {
			if (_instance == null) {
				_instance = new PlayerData(new SingletonLock());
			}
			return _instance;
		}
		
		public function initialize(initialWeapons:Array = null, initialHealth:Number = 10):void {
			if (initialWeapons == null) {
				//addWeapon(new Weapon("fire", 1, 0, {"hit": 1}));
				Inventory.addWeapon(startingWeapon);
				Inventory.addWeapon(opWeapon);
			}
			currentHealth = initialHealth;
			maxHealth = initialHealth;
		}
		
		public function playerHasDied():Boolean {
			return currentHealth <= 0;
		}
		
		public function addWeapon(newWeapon:Weapon):void {
			Inventory.addWeapon(newWeapon);
		}
		
		public function currentWeapon():Weapon {
			return Inventory.getWeapons()[currentWeaponIndex];
		}
	}
}
class SingletonLock{}