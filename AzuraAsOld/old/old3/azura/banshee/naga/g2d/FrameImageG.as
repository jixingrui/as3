package old.azura.banshee.naga.g2d 
{
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.factory.GNodeFactory;
	
	import flash.utils.setTimeout;
	
	import old.azura.banshee.naga.Foot;
	import old.azura.banshee.naga.FootI;
	import old.azura.banshee.naga.Frame;
	
	public class FrameImageG implements FootI 
	{		
		private var foot_:Foot=new Foot();
		private var xOffset:int,yOffset:int;
		
		private var currentFrame_:Frame;
		
		public var sprite:GSprite;
		
		private var scale_:Number=1;
		
		public function FrameImageG()
		{
			sprite = GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
		}
		
		public function get currentFrame():Frame{
			return currentFrame_;
		}
		
		public function set currentFrame(value:Frame):void
		{
			currentFrame_ = value;
			xOffset=value.xCenter;
			yOffset=value.yCenter;
			xFoot=foot_.x;
			yFoot=foot_.y;
		}
		
		public function set scale(value:Number):void
		{
			scale_=value;
			sprite.node.transform.scaleX=value;
			sprite.node.transform.scaleY=value;
		}
		
		public function set xFoot(value:int):void
		{
			foot_.x=value;
			if(sprite.node!=null)
				sprite.node.transform.x=value-xOffset*scale_;
			//			sprite.node.transform.x=-sprite.node.parent.transform.x+200;
		}
		
		public function set yFoot(value:int):void
		{
			foot_.y=value;
			if(sprite.node!=null)
				sprite.node.transform.y=value-yOffset*scale_;
			//			sprite.node.transform.y=-sprite.node.parent.transform.y+200;
			//			trace("FrameImageG: x="+sprite.node.transform.x+" y="+sprite.node.transform.y);
			
			//						if(!scanning)
			//							scan();
		}
		
		//		private static var range:int=1900;
		//		private var i:int=-range,j:int=-range;
		//		private var scanning:Boolean=false;
		//		
		//		private function scan():void{
		//			scanning=true;
		//			
		//			i+=200;
		//			if(i>range){
		//				i=-range;
		//				j+=200;
		//			}
		//			
		//			sprite.node.transform.x=i;
		//			sprite.node.transform.y=j;
		//			trace("move: ============== "+i+","+j);
		//			
		//			if(j<=range)
		//				setTimeout(scan,200);
		//			else{
		//				j=-range;
		//				scanning=false;
		//			}
		//		}
		
		public function set depthFoot(value:int):void
		{
			foot_.depth=value;
//			sprite.node.userData.depth=value;
			//			sprite.node.userData.set("depth",value);
		}
		
		public function hit(x:int,y:int):Boolean{
			return true;
			//			return currentFrame_.hit(x,y);
		}
	}
}