package azura.banshee.zebra.node
{
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.Zimage;
	import azura.banshee.zebra.i.ZebraBranchNodeI;
	import azura.banshee.zebra.i.ZebraI;
	import azura.banshee.zebra.i.ZimageOpI;
	import azura.banshee.zebra.zimage.ZimageLargeOp;
	import azura.banshee.zebra.zimage.ZimageTinySprite;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Rectangle;
	
	public class ZimageNode extends ZboxOld implements ZebraBranchNodeI
	{
		private var data:Zimage;
		
		//op
		private var tiny:ZimageTinySprite;		
		private var large:ZimageLargeOp;
		private var op:ZimageOpI;
		
		private var _angle:int;
		
		private var zUp:int;
		
//		private var ret:Function;
		
		public function ZimageNode(parent:ZboxOld)
		{
			super(parent);
			this.sortEnabled=true;
			tiny=new ZimageTinySprite(this);
			large=new ZimageLargeOp(this);
			tiny.visible=false;
		}
		
		public function get boundingBox():Rectangle{
			return data.boundingBox;
		}
		
		override public function clear():void{
			tiny.clear();
			large.clear();
		}
		
		public function load(value:Zebra,ret:Function):void{
			data=value.branch as Zimage;
//			this.ret=ret;
			tiny.clear();
			large.clear();
			tiny.data=data.tinySheet;
			large.data=data.pyramid;
			update(zUp);
			
			ret.call(null,this);
		}
		
		public function show():void{
			
		}
		
		override protected function scaleChange(scaleGlobal:Number):void{
			var zUpNew:int=FastMath.log2(Math.floor(1/scaleGlobal));
			if(zUpNew!=zUp){
				tiny.clear();
				large.clear();
				update(zUpNew);
			}
		}
		
		private function update(value:int):void{
			zUp=value;
			if(!data.useLarge){
				op=tiny;
				tiny.visible=true;
				tiny.zUp=value;
				large.clear();
			}else if(value<large.layerCount){
				op=large;
				large.zUp=value;
				tiny.visible=false;
				tiny.clear();
			}else if((value-large.layerCount)<tiny.layerCount){
				op=tiny;
				tiny.visible=true;
				tiny.zUp=value-large.layerCount;
				large.clear();
			}else{
				op=null;
			}
		}
		
		public function look(viewLocal:Rectangle):void
		{
			op.look(viewLocal);
		}
		
		public function set angle(angle:Number):void
		{
			_angle=angle;
			super.renderer.rotation=angle;
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
	}
}