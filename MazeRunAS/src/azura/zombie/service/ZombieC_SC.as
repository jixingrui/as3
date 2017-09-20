package azura.zombie.service
{
	import azura.common.collections.ZintBuffer;
	import azura.common.data.OutI;
	import azura.ice.service.IceC_SC;
	import azura.ice.service.PathOfPoints;
	import azura.karma.def.KarmaSpace;
	import azura.karma.run.Karma;
	
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import maze.ClientManager;
	
	import org.osflash.signals.Signal;
	
	import zz.karma.Zombie.K_ZombieCS;
	import zz.karma.Zombie.K_ZombieSC;
	import zz.karma.Zombie.ZombieCS.K_CreateNpc;
	import zz.karma.Zombie.ZombieCS.K_EscapeRet;
	import zz.karma.Zombie.ZombieCS.K_FindPathRet;
	import zz.karma.Zombie.ZombieCS.K_IceCS;
	import zz.karma.Zombie.ZombieCS.K_MazeInfo;
	import zz.karma.Zombie.ZombieSC.K_Escape;
	import zz.karma.Zombie.ZombieSC.K_FindPath;
	import zz.karma.Zombie.ZombieSC.K_IceSC;
	
	public class ZombieC_SC extends K_ZombieSC implements OutI
	{
		public var ice:IceC_SC;
		private var tunnel:OutI;
		public var onIceReady:Signal=new Signal();
		public var shell:ClientManager;
		
		public function ZombieC_SC(ksZombie:KarmaSpace,out:OutI)
		{
			super(ksZombie);
			this.tunnel=out;
		}
		
		public function receive(zb:ZintBuffer):void{
			super.fromBytes(zb);
			if(msg.type==T_IceSC){
				var isc:K_IceSC=new K_IceSC(space);
				isc.fromKarma(msg);
				if(ice==null){					
					var ksIce:KarmaSpace=new KarmaSpace();
					ksIce.fromBytes(isc.msg);
					ice=new IceC_SC(ksIce,this);
					ice.shell=shell;
					onIceReady.dispatch();
				}else{
					ice.receive(isc.msg);
				}				
			}else if(msg.type==T_FindPath){
				var fp:K_FindPath=new K_FindPath(space);
				fp.fromKarma(msg);
				var start:Point=new Point();
				var end:Point=new Point();
				start.x=fp.xStart;
				start.y=fp.yStart;
				end.x=fp.xEnd;
				end.y=fp.yEnd;
				var pList:Vector.<Point>=shell.canvas.wayFinder.searchPath(start,end);
				var pop:PathOfPoints=new PathOfPoints();
				if(pList!=null){
					pList.shift();
					pop.path=pList;
				}
				
				//				trace("start",start.x,start.y,"end",end.x,end.y," -> ",pop.toString(),this);
				
				trace("find path task by "+fp.session,this);
				
				var fpr:K_FindPathRet=new K_FindPathRet(space);
				fpr.session=fp.session;
				fpr.path=pop.toBytes();
				sendCS(fpr.toKarma());
			}else if(msg.type==T_Escape){
				var rd:K_Escape=new K_Escape(space);
				rd.fromKarma(msg);
				
				var monster:Point=new Point(rd.xMonster,rd.yMonster);
				var runner:Point=new Point(rd.xRunner,rd.yRunner);
				
				var rPath:Vector.<Point>=shell.canvas.wayFinder.getEscapeRoute(runner,monster);
				var rpp:PathOfPoints=new PathOfPoints();
				rpp.path=rPath;
				
				var rdr:K_EscapeRet=new K_EscapeRet(space);
				rdr.session=rd.session;
				rdr.path=rpp.toBytes();
				//				rdr.angle=shell.canvas.wayFinder.zway.getEscapeRoute(rd.xFrom,rd.yFrom,rd.angle);
				
				//				var s:Point=new Point(rd.xFrom,rd.yFrom);
				//				var dest:Point=FastMath.angle2Xy(rdr.angle,rd.dist);
				//				dest.x+=s.x;
				//				dest.y+=s.y;
				//				dest=shell.canvas.wayFinder.rayCast(s,dest);
				//				
				//				rdr.x=dest.x;
				//				rdr.y=dest.y;
				
				sendCS(rdr.toKarma());
			}
		}
		
		public function newZombie(mc5Zombie:String,xStart:int,yStart:int,angle:int):void{
			//			var f:Form=new Form();
			//			f.skin=mc5Zombie;
			//			f.action="shoot";
			
			var k:K_CreateNpc=new K_CreateNpc(space);
			//			k.shape=mc5Zombie;
			k.startPos.x=xStart;
			k.startPos.y=yStart;
			k.startPos.angle=angle;
			k.shape=mc5Zombie;
			k.aiType=1;
			
			//			k.mapBase=
			sendCS(k.toKarma());
		}
		
		public function uploadMaze(data:ZintBuffer):void{
			var k:K_MazeInfo=new K_MazeInfo(space);
			k.data=data;
			sendCS(k.toKarma());
		}
				
		private function sendCS(k:Karma):void{
			var cs:K_ZombieCS=new K_ZombieCS(space);
			cs.msg=k;
			tunnel.out(cs.toBytes());
		}
		
		public function out(zb:ZintBuffer):void{
			var kcs:K_IceCS=new K_IceCS(space);
			kcs.msg=zb;
			sendCS(kcs.toKarma());
		}
		
	}
}