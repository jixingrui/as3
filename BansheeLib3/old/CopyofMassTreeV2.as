package azura.banshee.mass.view
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTree;
	import azura.banshee.mass.sdk.MassSdkI2;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.collections.Path;
	import azura.common.ui.alert.Toast;
	
	import flash.utils.Dictionary;
	
	public class MassTreeV2
	{
		public var model:MassTree;
		public var root:MassTreeNV2;
		public var path_MassTreeNV2:Dictionary=new Dictionary();
		
		private var user:MassSdkI2;
		
		public function MassTreeV2(parent:Zbox3,data:MassTree,user:MassSdkI2)
		{
			this.model=data;
			this.user=user;
		}
		
		public function move(x:Number,y:Number):void{
			root.zbox.move(x,y);
		}
		
		public function changeScreenSize(w:int,h:int):void{
			root.zbox.width=w;
			root.zbox.height=h;
			root.zbox.changeViewBubbleDown();
			
			root.updateSize();
		}
		
		public function getBox(path:String):MassTreeNV2{
			return path_MassTreeNV2[path];
		}
		
		public function act(action:MassAction,from:MassTreeNV2):void{
			
			if(action.internal_event_coder==2){
				if(user!=null){
					var processed:Boolean=user.chainAction(from,action);
					if(!processed){
						Toast.show("[c]"+action.message);
					}
				}
				return;
			}else if(action.internal_event_coder==1){
				Toast.show("[e]"+action.message);
			}else if(action.targetPath==""){
				return;
			}
			
			activate(action.targetPath);
		}
		
		public function activate(target:String):void{
			var targetV:MassTreeNV2=path_MassTreeNV2[target];
			if(targetV!=null){
				targetV.spankChildren();
				return;
			}
		
			var path:Path=new Path().fromString(target);
			var parentPath:String=path.getParent().toString();
			var parentV:MassTreeNV2=path_MassTreeNV2[parentPath];
			if(parentV==null || parentV.zbox.isDisposed){
				Toast.show("Error: "+target+" does not have living parent",true);
				return;
			}
			parentV.activate(target);
		}
		
		public function dispose():void{
			root.zbox.dispose();
		}
		
	}
}