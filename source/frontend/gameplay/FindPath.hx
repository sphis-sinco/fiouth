package frontend.gameplay;

import frontend.gameplay.eastereggs.FakeEnd;
import frontend.gameplay.paths.StartPath;
import flixel.FlxState;
import backend.save.Save;
import backend.gameplay.GameplayPaths;

class FindPath
{
	public static function sendToStateBasedOnGameplayPath(path:GameplayPaths):FlxState
	{
		switch (path)
		{
			case START, START_OLD:
				return new StartPath();

			case FAKE_END:
				trace('CHEATING USER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
				return new FakeEnd();

			default:
				trace('Unknown : going to start scene');
				return new StartPath();
		}
	}
}
