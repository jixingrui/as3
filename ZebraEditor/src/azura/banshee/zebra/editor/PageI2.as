package azura.banshee.zebra.editor
{
	import azura.banshee.zbox2.editor.EditorCanvas;

	public interface PageI2
	{
		function activate(ec:EditorCanvas):void;
		function deactivate():void;
	}
}