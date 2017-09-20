package pano
{
	/**
	 * CameraType クラスは AlternativaTemplate でカメラを定義するのに使用するためのクラスです。
	 * @author clockmaker
	 */ 
	public class CameraType
	{
		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------
		
		/**
		 * 3D オブジェクトの周りに配置するカメラモードを指定します。
		 */
		public static const ORBIT:String = "orbit";
		/**
		 * パノラマビューのカメラモードを指定します。
		 */
		public static const PANORAMA:String = "panorama";
		
		/**
		 * 原点（x:0, y:0, z:0）をターゲットとした Camera3D を定義します。
		 */
		public static var TARGET:String = "target";
		
		/**
		 * ターゲットの存在しない Camera3D を定義します。
		 */
		public static var FREE:String = "free";
	}
}
