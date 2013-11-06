package {
	/**
	 * @author ethanis
	 */
	public class Weapon {
		var attack:int = 1;
		var defense:int = 0;
		var name:String = "";

		var special:Number = 0;
		
		/*
		'buffs' is a dictionary of arrays. each key is a point at which buffs can be applied.
		for example, buffs['equip'] might contain buffs that are applied when equipping this weapon, like 'heal'
		and buffs['hit'] might contain buffs that are applied when hitting an enemy, like 'burn' and 'freeze'.
		*/
		var buffs:Object = { };
		
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
		public static const BUFF_LIST:Array = [ 	new Buff('none', 'none', 0, function(src:BattleCharacter, trg:BattleCharacter):void { }),
													new Buff('burn', 'Burn', 2, function(src:BattleCharacter, trg:BattleCharacter):void { if (Math.random() < 0.5) src.hurt(1); }),
													new Buff('burn', 'Ignite', 2, function(src:BattleCharacter, trg:BattleCharacter):void { src.hurt(1); }),
													new Buff('freeze', 'Freeze', 1, function(src:BattleCharacter, trg:BattleCharacter):void { src.tempAttackStat = -src.attackStat; }),
													new Buff('freeze', 'Entomb', 2, function(src:BattleCharacter, trg:BattleCharacter):void { src.tempAttackStat = -src.attackStat; }),
													new Buff('heal', 'Drain', -1, function(src:BattleCharacter, trg:BattleCharacter):void { if (Math.random() < 0.5) src.heal(1); }),
													new Buff('heal', 'Greater Drain', -1, function(src:BattleCharacter, trg:BattleCharacter):void { src.heal(1); }),
													new Buff('pierce', 'Pierce', -1, function(src:BattleCharacter, trg:BattleCharacter):void { src.flags = ['true']; }),
													new Buff('dispel', 'Dispel', -1, function(src:BattleCharacter, trg:BattleCharacter):void { src.tempAttackStat += 2 * trg.buffs.length; trg.buffs = []; }),
													new Buff('cascade', 'Cascade', -1, function(src:BattleCharacter, trg:BattleCharacter):void { })	];

		public function Weapon(name:String, attack:int=1, defense:int=0, special:Number = 0,
							   buffs:Object = null){
			this.name = name;
			this.attack = attack;
			this.defense = defense;
			this.special = special;
			
			if (buffs) {
				this.buffs = buffs;
			}
		}
		
		public function buffsOfType(type:String):Array {
			return buffs[type];
		}
	}
}