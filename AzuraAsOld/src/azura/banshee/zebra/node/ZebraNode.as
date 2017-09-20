package azura.banshee.zebra.node
{
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.Zempty;
	import azura.banshee.zebra.Zimage;
	import azura.banshee.zebra.Zmatrix;
	import azura.banshee.zebra.i.ZebraBranchNodeI;
	import azura.banshee.zebra.zimage.ZbitmapSprite;
	import azura.banshee.zebra.zimage.ZemptyOp;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4;
	
	import flash.geom.Rectangle;
	
	public class ZebraNode extends ZboxOld
	{
		private var _zebra:Zebra;
		
		/**
		 * there will always be a branch,unless disposed
		 * branch changes when zebra change
		 */
		private var branch:ZebraBranchNodeI=new ZemptyOp();
		private var branchFuture:ZebraBranchNodeI;
		
		public function ZebraNode(parent:ZboxOld)
		{
			super(parent);
		}
		
		public function get zebra():Zebra
		{
			return _zebra;
		}
		
		public function set zebra(value:Zebra):void
		{
//			trace("set zebra",this);
			
			if(branch==null)
				throw new Error("disposed");
			
			if(value==null)
				_zebra=null;
			else
				_zebra = value.clone();
			
			var _angle:Number=branch.angle;			
			
			if(branchFuture!=null){
				branchFuture.dispose();
				branchFuture=null;
			}
			
			if(_zebra==null){
				branchFuture=new ZemptyOp();
			}else if(_zebra.branch is Zempty){
				branchFuture=new ZemptyOp();
			}else if(_zebra.branch is Zbitmap){
				branchFuture=new ZbitmapSprite(this);			
				_angle=0;
			}else if(_zebra.branch is Zimage){
				branchFuture=new ZimageNode(this);
				_angle=0;
			}else if(_zebra.branch is Zmatrix){
				branchFuture=new ZmatrixNode(this);
			}else{
				throw new Error("ZebraNode: invalid format");
			}
			
			branchFuture.angle=_angle;
			branchFuture.load(value,onLoaded);
			
//			var bb:Rectangle=new Rectangle();
//			bb.x=xGlobal+value.boundingBox.x;
//			bb.y=yGlobal+value.boundingBox.y;
//			bb.width=value.boundingBox.width;
//			bb.height=value.boundingBox.height;
			
//			super.bb=branchFuture.boundingBox;
			
			move(box.pos.x,box.pos.y);
			updateVisual();
		}
		
		public function load(me5:String):void{
			var data:ZintBuffer=Gal4.readSync(me5);
			data.uncompress();
			var zebra:Zebra=new Zebra();
			zebra.fromBytes(data);
			this.zebra=zebra;
		}
		
//		public function get boundingBox():Rectangle{
//			return zebra.boundingBox.
//		}
		
		/**
		 * Happens each time a new zebra loads. If disposed when loading, then cannot fire.
		 * No reporting to parent caller.
		 * 
		 */
		private function onLoaded(loaded:ZebraBranchNodeI):void{
			if(loaded!=branchFuture)
				throw new Error();
			
			branch.dispose();
			branch=branchFuture;
			branchFuture=null;
			branch.show();
//			super.bb=branch.boundingBox;
		}
		
		public function set fps(value:int):void{
			if(branch is ZmatrixNode){
				ZmatrixNode(branch).fps=value;
				if(branchFuture!=null)
					ZmatrixNode(branchFuture).fps=value;
			}
		}
		
		public function set angle(value:Number):void
		{
			branch.angle=value;
			if(branchFuture!=null)
				branchFuture.angle=value;
		}
		
		public function get angle():Number
		{
			return branch.angle;
		}
		
		override public function updateVisual():void
		{
			var vl:Rectangle=space.viewGlobal;
			vl.x-=this.xGlobal;
			vl.y-=this.yGlobal;
			branch.look(vl);
			if(branchFuture!=null)
				branchFuture.look(vl);
		}
		
		override public function clear():void{
			branch=new ZemptyOp();
			branchFuture=null;
			super.clear();
		}
		
		override public function dispose():void{
			branch=null;
			branchFuture=null;
			super.dispose();
		}
	}
}
