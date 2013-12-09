package
{
	public class PlayerData
	{
		private static var _instance:PlayerData;

		public var currentWeaponIndex:int;
		public var currentHealth:int;
		public var maxHealth:int;
		public var killCount:int;
		
		public var hasUpdatedWeapon:Boolean = true;
		
		public var startingWeapon:Weapon = CraftLogic.generateBasicWeapon();
		//public var hax0rWeapon:Weapon = new Weapon("Scythe", "Marsh", 1, 0, Weapon.WW_SPECIAL);
		
		public static var weaponList:Object = { };
		
		public var difficulty:int;
		
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
		
		public function initialize(initialWeapons:Array = null, initialHealth:Number = BalanceHooks.playerStartHealth):void {
			if (initialWeapons == null) {
				//addWeapon(new Weapon("fire", 1, 0, {"hit": 1}));
				Inventory.addWeapon(startingWeapon);
				//Inventory.addWeapon(hax0rWeapon);
			}
			currentHealth = initialHealth;
			maxHealth = initialHealth;
			currentWeaponIndex = 0;
			killCount = 0;
			difficulty = 1;
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
		
		public function changeWeapon(index:int):void {
			currentWeaponIndex = index;
			hasUpdatedWeapon = false;
		}
		
		public function removeWeapon():void {
			
		}
		public static function recordCraftedWeapon(s:String, w:Weapon):void {
			weaponList[s] = [w.weaponType, w.weaponMod, w.attack, w.defense, w.buff];
		}
		
		public function hasFullHealth():Boolean {
			return this.currentHealth == this.maxHealth;
		}
		
		public function heal(amount:Number):void {
			this.currentHealth = Math.min((this.currentHealth + amount), this.maxHealth);
		}
	}
}
class SingletonLock{}