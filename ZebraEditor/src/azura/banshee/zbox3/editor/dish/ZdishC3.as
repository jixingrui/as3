package azura.banshee.zbox3.editor.dish
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.collection.ZboxRect3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.zebra.ZebraC3;
	
	public class ZdishC3 extends Zbox3Container
	{
		public var data:Zdish;
		public var zebrac:ZebraC3;
		
		public var boundRect:ZboxRect3;
		
		public function ZdishC3(parent:Zbox3)
		{
			super(parent);
			zebrac=new ZebraC3(zbox);
		}
		
		public function set showbound(value:Boolean):void{
			if(boundRect!=null){
				boundRect.zbox.dispose();
				boundRect=null;
			}
			
			if(value){
				boundRect=new ZboxRect3(zbox);
				boundRect.paint(0xff00ff00);
				if(data.mc5Zebra!=null && data.mc5Zebra.length>0){
					boundRect.resize(zebrac.zbox.width,zebrac.zbox.height);
					boundRect.zbox.move(-zebrac.zebra.boundingBox.xc,-zebrac.zebra.boundingBox.yc);
				}
				else
					boundRect.resize(100,100);
			}
		}
		
		public function update():void{
			var xv:Number=zbox.space.xView*(1-data.scaleD)+data.x;
			var yv:Number=zbox.space.yView*(1-data.scaleD)*data.host.yFactor+data.y;
			zbox.move(xv,yv);
			zbox.sortValue=data.scaleD;
			Zbox3(zbox.parent).sortOne(zbox);
			
			if(data.mc5Zebra!=null && data.mc5Zebra.length>0){
				//				if(zebrac==null){
				//					zebrac=new ZebraC3(zbox);
				//				}
				zebrac.feedMc5(data.mc5Zebra);
			}
			
		}
	}
}