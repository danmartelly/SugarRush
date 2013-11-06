package
{
	public class PlayerData
	{
		private static var _instance:PlayerData;
		public var weapons:Array;

		public var currentWeaponIndex:int = 0;
		public var currentHealth:int;
		public var maxHealth:int;
		
		public var health:Number;
		public var startingWeapon:Weapon = new Weapon("starter", 1, 0, null);
		public var inventory:Inventory;
		
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
		
		public function initialize(initialWeapons:Array = null, initialHealth:Number = 10, 
								   initialInventory:Inventory = null):void {
			if (initialWeapons == null) {
				weapons = new Array();
				weapons.push(startingWeapon);
			} else {
				weapons = initialWeapons;
			}
			currentHealth = initialHealth;
			maxHealth = initialHealth;
			inventory == initialInventory || new Inventory();
		}
		
		public function playerHasDied():Boolean {
			return currentHealth <= 0;
		}
		
		public function addWeapon(newWeapon:Weapon):void {
			weapons.push(newWeapon);
		}
		
		public function currentWeapon():Weapon {
			return weapons[currentWeaponIndex];
		}
	}
}
class SingletonLock{}