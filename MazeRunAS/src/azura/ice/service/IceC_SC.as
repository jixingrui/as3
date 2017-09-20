package azura.ice.service
{
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	import azura.common.data.OutI;
	import azura.karma.def.KarmaSpace;
	import azura.karma.run.Karma;
	
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import maze.Char;
	import maze.ClientManager;
	
	import zz.karma.Ice.CS.K_EnterRoom;
	import zz.karma.Ice.CS.K_Move;
	import zz.karma.Ice.CS.K_SendPublic;
	import zz.karma.Ice.K_CS;
	import zz.karma.Ice.K_SC;
	import zz.karma.Ice.SC.K_EnterRoomRet;
	import zz.karma.Ice.SC.K_ReceiveMsg;
	import zz.karma.Ice.SC.K_SeeChange;
	import zz.karma.Ice.SC.K_SeeMove;
	import zz.karma.Ice.SC.K_SeeMoveAlong;
	import zz.karma.Ice.SC.K_SeeNew;
	import zz.karma.Ice.SC.K_SeeStop;
	import zz.karma.Maze.K_Woo;
	
	public class IceC_SC extends K_SC
	{
		public var shell:ClientManager;
		private var out:OutI;
		public function IceC_SC(space:KarmaSpace,out:OutI)
		{
			super(space);
			this.out=out;
		}
		
		public function receive(zb:ZintBuffer):void{
			var char:Char;
			
			super.fromBytes(zb);
			if(msg.type==T_EnterRoomRet){
				var ret:K_EnterRoomRet=new K_EnterRoomRet(space);
				ret.fromKarma(msg);
				shell.idSelf=ret.id;
				//				trace("enter room and obtained id:",ret.id,this);
			}else if(msg.type==T_SeeNew){
				var sn:K_SeeNew=new K_SeeNew(space);
				sn.fromKarma(msg);
				var form:Form=new Form();
				form.fromBytes(sn.form);
				
				char=shell.id_Char[sn.id];
				if(char==null){
					char=shell.newChar(sn.id,form.skin);
					char.id=sn.id;
					if(shell.idSelf==sn.id){
						shell.canvas.hero=char;
						char.isHero=true;
						char.motor.smooth=false;
					}
					char.jumpStart(sn.pos.x,sn.pos.y);
					char.bodyAt(sn.pos.x,sn.pos.y);
					char.actor.zbox.angle=sn.pos.angle;
					char.playMotion(form.action,0);
					//					trace("see new speed = ",form.speed,this);
					char.motor.speed=form.speed;
				}
			}else if(msg.type==T_SeeMoveAlong){
				var sma:K_SeeMoveAlong=new K_SeeMoveAlong(space);
				sma.fromKarma(msg);
				char=shell.id_Char[sma.id];
				if(char==null)
					throw new Error();
				
				var pp:PathOfPoints=new PathOfPoints();
				pp.fromBytes(sma.path);
				
//				if(char.isHero==false){
//					trace("restart path",pp.toString(),this);
//				}
				char.restartPath(pp.path);
			}else if(msg.type==T_SeeMove){
				
				var sm:K_SeeMove=new K_SeeMove(space);
				sm.fromKarma(msg);
				char=shell.id_Char[sm.id];
				if(char==null)
					throw new Error();
				
				//				if(char.motor.going==false){
				//					char.motor.appendPoint(new Point(sm.x,sm.y));
				//				}
//				if(char.isHero==false){
//					var dist:int=FastMath.dist(sm.x,sm.y,char.body.x,char.body.y);
//					trace("dist=",dist,"server",sm.x,",",sm.y,"client",char.body.x,",",char.body.y);
//				}
				//									char.jumpTo(sm.x,sm.y);
			}else if(msg.type==T_SeeStop){
				
				var ss:K_SeeStop=new K_SeeStop(space);
				ss.fromKarma(msg);
				char=shell.id_Char[ss.id];
				if(char==null)
					throw new Error();
				
				//				if(char.motor.going==false){
				//				}
				if(char.isHero==false){
//					trace("stop at",ss.x,ss.y,this);
					//					char.motor.appendPoint(new Point(ss.x,ss.y));
					//					char.restartPoint(new Point(ss.x,ss.y));
					char.jumpTo(ss.x,ss.y);
					char.stopWalking();
				}
				
			}else if(msg.type==T_SeeChange){
//				trace("see change",this);
				var sc:K_SeeChange=new K_SeeChange(space);
				sc.fromKarma(msg);
				var f2:Form=new Form();
				f2.fromBytes(sc.form);
				//				trace("see walker ",sn.id,sn.pos.x,sn.pos.y,sn.pos.angle,form.toString());
				
				char=shell.id_Char[sc.id];
				if(char==null){
					trace("error: char not found ==============",this);
				}
				
				char.actor.zbox.angle=sc.angle;
				
			}else if(msg.type==T_ReceiveMsg){
				var rm:K_ReceiveMsg=new K_ReceiveMsg(space);
				rm.fromKarma(msg);
				var e:SpeakEvent=new SpeakEvent();
				e.fromBytes(rm.msg);
				
				char=shell.id_Char[rm.idFrom];
				if(char==null){
					trace("error: char not found ==============",this);
				}
				
				//				if(e.action=="stand"){
				//					char.motor.stop();
				//				}
				
				char.actor.zbox.angle=e.angle;
				char.playMotion(e.action,0);		
			}
		}
		
		private function sendCS(k:Karma):void{
			var cs:K_CS=new K_CS(space);
			cs.msg=k;
			out.out(cs.toBytes());
		}
		
		//============== send =============
		public function enterRoom(uid:String,target:K_Woo,z:int):void{
			var msg:K_EnterRoom=new K_EnterRoom(space);
			msg.roomUID=uid;
			msg.base=shell.canvas.rmWalk.toBytes();
			msg.initialPos.x=target.x;
			msg.initialPos.y=target.y;
			msg.initialPos.z=z;
			msg.initialPos.angle=target.angle;
			var form:Form=new Form();
			form.skin=shell.mc5Shooter1;
			form.speed=shell.config.speedShooter;
			form.action="stand";
			msg.form=form.toBytes();
			sendCS(msg.toKarma());
		}
		
		public function sendPath(path:Vector.<Point>):void{
			var pp:PathOfPoints=new PathOfPoints();
			pp.path=path;
			
			var move:K_Move=new K_Move(space);
			move.path=pp.toBytes();
			sendCS(move.toKarma());
		}
		
		public function sendPublic(data:ByteArray):void{
			var zb:ZintBuffer=new ZintBuffer(data);
			var sp:K_SendPublic=new K_SendPublic(space);
			sp.msg=zb;
			sendCS(sp.toKarma());
		}
	}
}