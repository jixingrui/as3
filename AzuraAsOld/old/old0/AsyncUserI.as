package common.async
{
	public interface AsyncUserI
	{
		function process(task:AsyncTask):void;
		function ready(value:AsyncBoxI):void;
	}
}