package azura.touch
{
	public interface TouchUserI
	{
		function sorter(one:TouchBox,two:TouchBox):int;
		function get intercept():Boolean;
	}
}