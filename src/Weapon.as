package {
	/**
	 * @author ethanis
	 */
	public class Weapon {
		var attack:int = 1;
		var defense:int = 0;
		var name:String = "";

		var special:Number = 0;
		
		public const NO_SPECIAL:int = 0;
		public const RED_SPECIAL:int = 1;
		public const BLUE_SPECIAL:int = 2;
		public const WHITE_SPECIAL:int = 3;
		public const RR_SPECIAL:int = 4;
		public const BB_SPECIAL:int = 5;
		public const WW_SPECIAL:int = 6;
		public const RB_SPECIAL:int = 7;
		public const RW_SPECIAL:int = 8;
		public const WB_SPECIAL:int = 9;
		
		// this might get moved later -npinsker
		public const BUFF_LIST:Array = [ 	new Buff('none', 'none', function(src:BattleCharacter, trg:BattleCharacter):void { }),
											new Buff('burn', 'Burn', function(src:BattleCharacter, trg:BattleCharacter):void { if (Math.random() < 0.5) src.hurt(1); }),
											new Buff('burn2', 'Ignite', function(src:BattleCharacter, trg:BattleCharacter):void { src.hurt(1); }),
											new Buff('freeze', 'Freeze', function(src:BattleCharacter, trg:BattleCharacter):void { src.tempAttackStat = -src.attackStat; }),
											new Buff('freeze2', 'Entomb', function(src:BattleCharacter, trg:BattleCharacter):void { src.tempAttackStat = -src.attackStat; }),
											new Buff('heal', 'Drain', function(src:BattleCharacter, trg:BattleCharacter):void { if (Math.random() < 0.5) src.heal(1); }),
											new Buff('heal2', 'Greater Drain', function(src:BattleCharacter, trg:BattleCharacter):void { src.heal(1); }),
											new Buff('none', 'Pierce', function(src:BattleCharacter, trg:BattleCharacter):void { src.flags = ['true']; }),
											new Buff('none', 'Dispel', function(src:BattleCharacter, trg:BattleCharacter):void { src.tempAttackStat += 2 * trg.buffs.length; trg.buffs = []; }),
											new Buff('none', 'Cascade', function(src:BattleCharacter, trg:BattleCharacter):void { })	];

		public function Weapon(name:String, attack:int=1, defense:int=0, special:Number = 0,
							   buffs:Object = null){
			this.name = name;
			this.attack = attack;
			this.defense = defense;
			this.special = special;
		}
	}
}