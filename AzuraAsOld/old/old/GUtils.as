/**
 * Code by rodrigolopezpeker (aka 7interactive™) on 1/15/14 11:12 AM.
 */
package common.loaders {
	import azura.banshee.naga.g2d.GenomeBooter;
	
	import com.genome2d.core.Genome2D;
	import com.genome2d.error.GError;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.GTextureSourceType;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class GUtils {
		
		static public function createTextureFromATF(p_id:String, p_atfData:ByteArray, p_uploadCallback:Function = null):GTexture {
			var atf:String = String.fromCharCode(p_atfData[0], p_atfData[1], p_atfData[2]);
			if (atf != "ATF") throw new GError(GError.INVALID_ATF_DATA);
			var type:int;
			var transparent:Boolean = true;
			var offset:int = p_atfData[6] == 255 ? 12 : 6;
			switch (p_atfData[offset]) {
				case 0:
				case 1:
					type = GTextureSourceType.ATF_BGRA;
					break;
				case 2:
				case 3:
					type = GTextureSourceType.ATF_COMPRESSED;
					transparent = false;
					break;
				case 4:
				case 5:
					type = GTextureSourceType.ATF_COMPRESSEDALPHA;
					break;
			}
			var width:int = Math.pow(2, p_atfData[int(++offset)]);
			var height:int = Math.pow(2, p_atfData[int(++offset)]);
			return new GTexture(p_id, type, p_atfData, new Rectangle(0, 0, width, height), transparent, 0, 0, p_uploadCallback);
		}
		
		static public function createTextureAtlasFromATFAndXML(p_id:String, p_atfData:ByteArray, p_xml:XML, p_uploadCallback:Function = null):GTextureAtlas {
			var atf:String = String.fromCharCode(p_atfData[0], p_atfData[1], p_atfData[2]);
			if (atf != "ATF") throw new GError(GError.INVALID_ATF_DATA);
			var type:int;
			var offset:int = p_atfData[6] == 255 ? 12 : 6;
			var transparent:Boolean = true;
			switch (p_atfData[offset]) {
				case 0:
				case 1:
					type = GTextureSourceType.ATF_BGRA;
					break;
				case 2:
				case 3:
					type = GTextureSourceType.ATF_COMPRESSED;
					transparent = false;
					break;
				case 4:
				case 5:
					type = GTextureSourceType.ATF_COMPRESSEDALPHA;
					break;
				// with older versions
				default:
					throw new Error("Invalid ATF format");
			}
			// ATF V1.0 > index 7 width / 8 height
			// ATF V1.2 > index 13 width / 14 height
			var width:int = Math.pow(2, p_atfData[int(++offset)]);
			var height:int = Math.pow(2, p_atfData[int(++offset)]);
			var textureAtlas:GTextureAtlas = new GTextureAtlas(p_id, type, width, height, p_atfData, transparent, p_uploadCallback);
			for (var i:int = 0; i < p_xml.children().length(); ++i) {
				var node:XML = p_xml.children()[i];
				var region:Rectangle = new Rectangle(int(node.@x), int(node.@y), int(node.@width), int(node.@height));
				var pivotX:Number = (node.@frameX == undefined && node.@frameWidth == undefined) ? 0 : Number(node.@frameWidth - region.width) / 2 + Number(node.@frameX);
				var pivotY:Number = (node.@frameY == undefined && node.@frameHeight == undefined) ? 0 : Number(node.@frameHeight - region.height) / 2 + Number(node.@frameY);
				textureAtlas.addSubTexture(node.@name, region, pivotX, pivotY);
			}
			textureAtlas.invalidate();
			return textureAtlas;
		}
		
//		static public function createSubTexture(p_id:String, region:Rectangle):void{
//			var atlas:GTextureAtlasFactory
//		}
		
		static public function createTextureAtlasFromATF(p_id:String, p_atfData:ByteArray, p_uploadCallback:Function = null):GTextureAtlas {
			var atf:String = String.fromCharCode(p_atfData[0], p_atfData[1], p_atfData[2]);
			if (atf != "ATF") throw new GError(GError.INVALID_ATF_DATA);
			var type:int;
			var offset:int = p_atfData[6] == 255 ? 12 : 6;
			var transparent:Boolean = true;
			switch (p_atfData[offset]) {
				case 0:
				case 1:
					type = GTextureSourceType.ATF_BGRA;
					break;
				case 2:
				case 3:
					type = GTextureSourceType.ATF_COMPRESSED;
					transparent = false;
					break;
				case 4:
				case 5:
					type = GTextureSourceType.ATF_COMPRESSEDALPHA;
					break;
				// with older versions
				default:
					throw new Error("Invalid ATF format");
			}
			// ATF V1.0 > index 7 width / 8 height
			// ATF V1.2 > index 13 width / 14 height
			var width:int = Math.pow(2, p_atfData[int(++offset)]);
			var height:int = Math.pow(2, p_atfData[int(++offset)]);
			var textureAtlas:GTextureAtlas = new GTextureAtlas(p_id, type, width, height, p_atfData, transparent, p_uploadCallback);
			
			textureAtlas.invalidate();
			return textureAtlas;
		}
		
	}
}