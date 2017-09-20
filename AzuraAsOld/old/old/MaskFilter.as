package azura.banshee.chessboard.loaders.filter {
	import starling.filters.FragmentFilter;
	import starling.textures.Texture;
	
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	
	public class MaskFilter extends FragmentFilter {
		private var mShaderProgram:Program3D;
		private var mMaskTexture:Texture;
		
		public function MaskFilter(maskTexture:Texture) {
			mMaskTexture = maskTexture;
		}
		
		protected override function activate(pass:int, context:Context3D, texture:Texture):void {
			context.setTextureAt(1,mMaskTexture.base);
			context.setProgram(mShaderProgram);
		}
		
		protected override function createPrograms():void {
			var fragmentProgramCode:String =
				"tex ft0, v0, fs0 <2d, clamp, linear, mipnone>	\n" +
				"tex ft1, v0, fs1 <2d, clamp, linear, mipnone>  \n" +
				"mul ft0, ft1, ft0				\n" +
				"mov oc, ft0";
			mShaderProgram = assembleAgal(fragmentProgramCode);
		}
		
		protected override function deactivate(pass:int, context:Context3D, texture:Texture):void {
			context.setTextureAt(1,null);
		}
		
		public override function dispose():void {
			if (mShaderProgram) mShaderProgram.dispose();
			super.dispose();
		}
	}
}