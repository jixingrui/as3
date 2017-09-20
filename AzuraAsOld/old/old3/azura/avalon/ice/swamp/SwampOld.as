package old.azura.avalon.ice.swamp
{
	import old.azura.avalon.ice.MummyOld;
	
	import old.azura.avalon.ice.GlobalState;
	
	import flash.utils.Dictionary;
	
	public class SwampOld
	{
		public var id_Monster:Dictionary=new Dictionary();
		
		public var idHero:int;
		
		public function init(id:int=0):void{
			idHero=id;
			var m:MummyOld=new MummyOld();
			m.id=id;
			m.x=GlobalState.primePlain.bound/2;
			m.y=GlobalState.primePlain.bound/2;
			var hero:MonsterOld=new MonsterOld(this,m);
			id_Monster[id]=hero;			
		}
		
		public function get hero():MonsterOld{
			return id_Monster[idHero];
		}
				
		public function register(monster:MonsterOld):void{
			id_Monster[monster.id]=monster;
		}
		
		public function getMonster(id:int):MonsterOld{
			return id_Monster[id];
		}
		
		public function remove(id:int):void{
			var m:MonsterOld=id_Monster[id];
			if(m!=null){
				m.clear();
				delete id_Monster[id];
			}
		}
		
		public function clear():void{
			for each(var m:MonsterOld in id_Monster){
				m.clear();
			}
			id_Monster=new Dictionary();
		}
		
		public function tick():void{
			for each(var m:MonsterOld in id_Monster){
				m.tick();
			}
		}
		
	}
}