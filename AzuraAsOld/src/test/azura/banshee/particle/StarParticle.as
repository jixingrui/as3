package test.azura.banshee.particle {
	
	import azura.common.algorithm.FastMath;
	
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.IRenderable;
	import com.genome2d.context.GContextCamera;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTexture;
	
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author 
	 */
	public class StarParticle extends GComponent implements IRenderable
	{
		public var width:int=256,height:int=256;
		public var count:int=20;
		
		public var texture:GTexture;
		
		private var starList:Vector.<Star>=new Vector.<Star>();
		
		/**
		 * 	@private
		 */
		public function StarParticle() {
//			super(p_node);
			
			for(var i:int=0;i<count;i++){
				var star:Star=new Star();
				star.x=FastMath.random(-width/2,width/2);
				star.y=FastMath.random(-height/2,height/2);
				star.scale=FastMath.random(1,4)/2;
				starList.push(star);
			}
		}
		
		// TODO add matrix transformations
		public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void {
			if (texture == null) return;
			
			for each(var star:Star in starList){
				node.core.getContext().draw(texture, star.x, star.y, star.scale,star.scale);
			}
		}
		
		public function clear(p_disposeCachedParticles:Boolean = false):void {
			// TODO
		}
		
		public function getBounds(p_target:Rectangle = null):Rectangle {
			// TODO
			return null;
		}
	}
}