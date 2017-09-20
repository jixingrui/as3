package old.azura.banshee.zimage.i {
	import old.azura.banshee.zimage.ZimagePlateOld;
	import azura.banshee.zsheet.Ztexture;
	
	public interface ZrendererI {
		
		function put(x:Number,y:Number,depth:Number):void;
		function set scale(value:Number):void;
		function set rotation(value:Number):void;
		
		function addChild(value:ZrendererI):void;
		function removeChild(value:ZrendererI):void;
		
		function sortChildren():void;
		function enterFrame():void;
		
		function load(piece:Ztexture):void;		
		function unload(piece:Ztexture):void;
		
		function display(piece:Ztexture):void;
		function undisplay(piece:Ztexture):void;
		
		function hide(piece:Ztexture):void;
		function unhide(piece:Ztexture):void;
		
		function clear():void;
	}
}