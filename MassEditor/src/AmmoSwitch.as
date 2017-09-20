package
{
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.banshee.mass.sdk.MassSwitch;
	import azura.banshee.mass.view.MassTreeNV;
	import azura.banshee.mass.model.MassAction;
	
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class AmmoSwitch extends MassSwitch
	{
		public function AmmoSwitch()
		{
			super(".");
		}
		override public function act(from:MassTreeNV, action:MassAction):Boolean{
			var to:MassTreeNV=from.tree.getBox(action.targetPath);
			
			if(from.model.path=="showAmmo.."){
				var f:TextFormat=new TextFormat();
				f.font="lishu";
				f.size=18;
				f.color=0xff0000;
				var tf:TextField=new TextField();
				tf.text="38/120";
				tf.setTextFormat(f);
				tf.background=false;

				var bd:BitmapData=new BitmapData(tf.textWidth+4,tf.textHeight+4,true,0);
				bd.draw(tf);
				var zb:Zebra2Old=new Zebra2Old();
				zb.fromBitmapData(bd);
				var z:ZebraC2=new ZebraC2(to.zbox);
				z.feed(zb);
				return true;
			}
			
			return false;
		}
	}
}