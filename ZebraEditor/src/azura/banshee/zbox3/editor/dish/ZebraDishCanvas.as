package azura.banshee.zbox3.editor.dish
{
	import azura.banshee.zbox3.editor.EditorCanvas3;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.Zebra3;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.collections.ZintBuffer;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	import azura.touch.gesture.GmoveI;
	import azura.touch.gesture.GsingleI;
	
	import com.greensock.TweenMax;
	
	import flash.geom.Point;
	
	public class ZebraDishCanvas implements GsingleI,GmoveI,GdragI,MotorI
	{
		public var ec:EditorCanvas3;
		
		private var motor:MotorByFpsFast;
		private var drag_hover:Boolean=true;
		
		public var data:Zdishes;
		private var dishList:Vector.<ZdishC3>;
		
		private var center:Point=new Point();
		
		private var selectedIdx:int;
		
		public function ZebraDishCanvas(){
		}
		
		//====================== life span ===============
		public function activate(ec:EditorCanvas3):void
		{
			this.ec=ec;
			motor=new MotorByFpsFast(this);
			clear();
			ec.space.addGesture(this);
		}
		
		public function deactivate():void{
			motor.clear();
			ec.space.look(0,0);
			ec.space.removeGesture(this);
			dispose();
		}
		
		public function clear():void{
			selectedIdx=-1;
			data=new Zdishes();
			dishList=new Vector.<ZdishC3>();
		}
		
		public function dispose():void{
			for each(var zd:ZdishC3 in dishList){
				zd.zbox.dispose();
			}
		}
		
		//====================== list ===================
		
		public function load(zb:ZintBuffer):void{
			dispose();
			clear();
			data.fromBytes(zb);
			for each(var dish:Zdish in data.dishList){
				var zd:ZdishC3=new ZdishC3(ec.space);
				zd.data=dish;
				ec.space.sortOne(zd.zbox);
				dishList.push(zd);
			}
			updateAll();
		}
		
		public function insertAt(idx:int):Zdish{
			var dish:Zdish=new Zdish(data);
			var zd:ZdishC3=new ZdishC3(ec.space);
			zd.data=dish;
			ec.space.sortOne(zd.zbox);
			dishList.insertAt(idx,zd);
			data.dishList.insertAt(idx,dish);
			
			zd.update();
			return dish;
		}
		
		public function removeAt(idx:int):void{
			var player:ZdishC3=dishList.removeAt(idx) as ZdishC3;
			player.zbox.dispose();
			data.dishList.removeAt(idx);
		}
		
		//==================== display ================
		public function updateAll():void{
			for each(var zd:ZdishC3 in dishList){
				zd.update();
			}
		}
		
		public function update(idx:int):void{
			dishList[idx].update();
		}
		
		public function select(idx:int):void{
//			if(selectedIdx==idx)
//				return;
			
			if(selectedIdx>=0)
				dishList[selectedIdx].showbound=false;
			selectedIdx=idx;
			dishList[idx].showbound=true;
		}
		
		public function lookAt(x:Number,y:Number):void{
			drag_hover=true;
			center.x=x;
			center.y=y;
			look();
		}
		
		private function look():void{
			ec.space.look(center.x,center.y);
			updateAll();
			motor.start(0,0);
		}
		
		//=================== touch ================
		public function handMove(x:Number, y:Number):void
		{
			if(drag_hover)
				return;
			motor.goTo(x,0);
		}
		
		public function singleClick(x:Number, y:Number):Boolean
		{
			if(drag_hover==false){
				drag_hover=true;
				look();
			}else{
				drag_hover=false;
				motor.goTo(x,0);
			}
			return false;
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			drag_hover=true;
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			ec.space.look(center.x-dx,center.y-dy);
			updateAll();
			return false;
		}
		
		public function dragEnd():Boolean
		{
			lookAt(ec.space.xView,ec.space.yView);
			return false;
		}
		
		public function get touchBox():TouchBox
		{
			return null;
		}
		
		public function set touchBox(box:TouchBox):void
		{
		}
		
		//===================== motor ==================
		public function jumpTo(x:Number, y:Number):void
		{
			if(ec==null || drag_hover==true)
				return;
			
			ec.space.look(center.x+x,center.y);
			updateAll();
		}
		
		public function turnTo(angle:int):int
		{
			return 0;
		}
		
		public function go():void
		{
		}
		
		public function stop():void
		{
		}
	}
}