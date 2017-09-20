package old.azura.avalon.ice.plain
{
	import old.azura.avalon.ice.dish.PyramidDish;
	import azura.banshee.zebra.zimage.large.PyramidZimage;
	import azura.gallerid.Gal_Http2Old;
	
	import azura.common.collections.ZintBuffer;
	import azura.common.util.Fork;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	
	public class PlainCarrier extends Plain
	{
		private var user_Layer:Dictionary=new Dictionary();
		
		private var forkCb:Fork;
		
		public var onCbReset:Function;
		
		public function PlainCarrier()
		{
		}
		
		public function add(user:LayerUserI):void{
			var layer:Layer=new Layer(user);
			user_Layer[user]=layer;
		}
		
		public function setDish(user:LayerUserI,dish:PyramidDish):void{
			var layer:Layer=user_Layer[user] as Layer;
			layer.dish=dish;
		}
		
		public function look(xfc:int,yfc:int):void{
			for each(var layer:Layer in user_Layer){
				layer.look(xfc,yfc);
			}
		}
		
		override public function clear():void{
			super.clear();
			
			for each(var layer:Layer in user_Layer){
				layer.clear();
			}
		}
		
		private var onCbReady_:Signal=new Signal();
		public function get onCbReady():Signal{
			return onCbReady_;
		}
		
		public function teleport(md5Cb:String,levelMax:int=0):void{
			
//			clear();
			
			forkCb=new Fork(onCbReady,"base","dish");
			
			function onCbReady():void{
				if(onCbReset!=null)
					onCbReset.call();
//				ready.call();
				onCbReady_.dispatch();
			}
			
//			Gal_Http.load(md5Cb,fileLoaded);
			new Gal_Http2Old(md5Cb).load(fileLoaded);
			function fileLoaded(gh:Gal_Http2Old):void{				
				var cb:ZintBuffer=ZintBuffer(gh.value);
				cb.uncompress();				
				decodeBase(cb.readBytes_());				
				decodeDish(cb.readBytes_());
			}
			function decodeBase(zb:ZintBuffer):void{
				setBase(zb);
				
//				corePath.setBase(zb);
//				corePath.pathReady=onPathCalculated_;
				
				forkCb.ready("base");
			}
			function decodeDish(zb:ZintBuffer):void{
				var dish:PyramidDish=new PyramidDish();
				dish.fromBytes(zb);
				
				for(var u:Object in user_Layer){
					var user:LayerUserI=u as LayerUserI;
//					setDish(user,dish.clone() as PyramidDish);
				}
				
				//				primePlain.setDish(layerFloorMosaic,dish.clone());
				//				primePlain.setDish(layerFloorClear,dish.clone());
				//				primePlain.setDish(layerAss,dish.clone());
				//				primePlain.setDish(layerMiniMap,dish.clone());
				
				forkCb.ready("dish");
			}
			
		}
	}
}