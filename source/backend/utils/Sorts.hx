package backend.utils;

import frontend.gameplay.FindPath;
import backend.gameplay.PathState;
import backend.gameplay.GameplayPaths;

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

	public static function pathsFinishState(a:GameplayPaths, b:GameplayPaths):Int
	{
		var aClass:PathState = cast FindPath.getStateBasedOnGameplayPath(a);
		var bClass:PathState = cast FindPath.getStateBasedOnGameplayPath(b);

		if (bClass.finished)
			return 1;
		if (aClass.finished)
			return -1;

		return 0;
	}
}
