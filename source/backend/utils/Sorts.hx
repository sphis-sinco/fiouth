package backend.utils;

class Sorts
{
    // https://github.com/FunkinCrew/Funkin/blob/main/source/funkin/util/SortUtil.hx
	public static function alphabetically(a:String, b:String):Int
	{
		a = a.toUpperCase();
		b = b.toUpperCase();

		// Sort alphabetically. Yes that's how this works.
		return a == b ? 0 : a > b ? 1 : -1;
	}
}
