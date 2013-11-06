package
{
	public class PlayerData
	{
		private static var _instance:PlayerData;
		public var weapons:Array;
		public var health:Number;
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
								   initialInventory:Inventory = new Inventory()):void {
			if (initialWeapons == null) {
				weapons = new Array();
			} else {
				weapons = initialWeapons;
			}
			health = initialHealth;
			inventory == initialInventory || new Inventory();
		}
		
		public function playerHasDied():Boolean {
			return health <= 0;
		}
		
		public function addWeapon(newWeapon:Weapon):void {
			weapons.push(newWeapon);
		}
		
		public function changeHealthBy(changeInHealth:Number):void {
			health += changeInHealth;
		}
	}
}
class SingletonLock{}