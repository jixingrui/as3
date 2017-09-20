package old.azura.avalon.ice.swamp
{
	import old.azura.avalon.ice.MummyOld;
	import azura.common.algorithm.Neck;
	import azura.banshee.zanimal.Animal;
	import old.azura.banshee.naga.AvatarI;
	import old.azura.banshee.naga.Naga;
	import old.azura.banshee.naga.NagaLoader;
	import old.azura.banshee.naga.g2d.AvatarG;
	import azura.gallerid.Gal_Http2Old;
	
	import azura.common.algorithm.mover.WalkerI;
	import azura.common.collections.ZintBuffer;
	import old.azura.avalon.ice.GlobalState;
	
	import flash.geom.Point;
	
	public class MonsterOld implements WalkerI
	{
		//		public static var defaultPerson:String;
		
		[Embed(source="../../../../../assets/barBg.png")]
		public static const BarBg:Class;
		
		[Embed(source="../../../../../assets/barIn.png")]
		public static const BarIn:Class;
		
		private var swamp:SwampOld;
		public var mummy:MummyOld;
		public var avatar:AvatarI;
		
		private var stop_Requested:Boolean;
		private var stop_Working:Boolean;
		private var stop_angle:Number;		
		
		private var currentAction:String;
		
		
		private var stop_func:Function;
		
		private var _n4:Animal;
		
		//		private var loader:NagaLoader;
		
		private var instance:MonsterOld;
		
		public function MonsterOld(swamp:SwampOld,mummy:MummyOld)
		{
			this.swamp=swamp;
			this.mummy=mummy;
			instance=this;
			swamp.register(this);
			
			avatar=new AvatarG();
			
			//			mummy.map=GlobalState.primePlain._base;
			mummy.mover=this;
			avatar.turnTo(mummy.pan);
			
			var tc:Point=Neck.tpToTc(mummy.x,mummy.y,GlobalState.primePlain.bound);
			mummy.jump(tc.x,tc.y);
			
		}
		
		public function get scale():Number{
			return GlobalState.primePlain.scale;
		}
		
		public function get isHero():Boolean{
			return swamp.hero==this;
		}
		
		
		public function get id():int{
			return mummy.id;
		}
		
		public function set n4Md5(value:String):void{
			new Gal_Http2Old(value).load(fileLoaded);
			function fileLoaded(gh:Gal_Http2Old):void{				
				var zb:ZintBuffer=ZintBuffer(gh.value);
				//				var n4v:N4=new N4();
				//				n4v.decode(zb);
				//				n4=n4v;
				zb.uncompress();
				var animal:Animal=Animal.decode(zb);
				n4=animal;
				
				turnTo(mummy.pan);
			}
		}
		public function set n4(value:Animal):void
		{
			_n4 = value;
			
			avatar.source=_n4.getDance("stand");
			avatar.scale=scale/2;
			
			//			new NagaLoader(.load(ready);
			//			function ready(nl:NagaLoader):void{
			//				nl.hold();
			//				avatar.source=nl.value as Naga;
			//				avatar.scale=scale/2;
			//			}
		}
		
		public function refreshSkin():void{
			//			if(mummy.skin.md5N4==null||mummy.skin.md5N4.length!=32)
			//				n4Md5=defaultPerson;
			//			else
			n4Md5=mummy.skin.md5N4;
			avatar.name=mummy.skin.name;
		}
		
		public function tick():void{
			if(mummy!=null)
				mummy.tick();
		}
		
		public function onStop(angle:Number=NaN,func:Function=null):void{
			stop_Requested=true;
			stop_Working=false;
			stop_angle=angle;
			stop_func=func;
		}
		
		public function goAlong(trackTp:Vector.<Point>):void{
			mummy.goAlong(trackTp);
			if(stop_Working){
				stop_Requested=false;
				stop_Working=false;
			}else if(stop_Requested){
				stop_Working=true;
			}
		}
		
		public function jumpTo(x:int, y:int, h:int):void
		{
			avatar.x=x;
			avatar.y=y-h;
			GlobalState.requestSort(false);
		}
		
		public function turnTo(angle:int):int
		{
			mummy.pan=angle;
			return avatar.turnTo(angle);
		}
		
		public function go():void
		{
			if(_n4==null)
				return;
			
			var action:String;
			if(scale<1.5)
				action="run";
			else
				action="walk";
			
			if(currentAction==action)
				return;
			
			currentAction=action;
			avatar.source=_n4.getDance(action);
			avatar.player.play();
			//			new NagaLoader(action).load(ready);
			//			function ready(nl:NagaLoader):void{
			//				nl.hold();
			//				avatar.source=nl.value as Naga;
			//				avatar.player.play();
			//			}
		}
		
		public function stand():void
		{
			if(_n4!=null){
				currentAction="stand";
				
				avatar.source=_n4.getDance(currentAction);
				//				if(loader!=null){
				//					loader.release(10000);
				//				}
				
				//				new NagaLoader(currentAction).load(ready);
				//				function ready(nl:NagaLoader):void{
				//					nl.hold();
				//					avatar.source=nl.value as Naga;
				//					
				//					loader=nl;
				//				}
			}
			
			if(stop_Requested==true){
				stop_Requested=false;
				stop_Working=false;
				
				if(!isNaN(stop_angle))
				{
					//					var me:MonsterEvent=new MonsterEvent(MonsterEvent.TURN);
					//					me.angle=stop_angle;
					//					avatar.dispatchEvent(me);
					//					avatar.turnTo(stop_angle);
				}
				
				if(stop_func!=null)
					stop_func.call();
			}
		}
		
		public function clear():void{
			//			if(loader!=null){
			//				loader.release(3000);
			//			}
			avatar.clear();
		}
	}
}