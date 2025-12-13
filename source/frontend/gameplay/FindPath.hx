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
				Save.data.gameplay.path = START;
				return new StartPath(null);

			case FAKE_END:
				trace('CHEATING USER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
				Save.data.gameplay.path = START;
				return new FakeEnd(null);

			default:
				trace('Unknown : going to start scene');

				Save.data.gameplay.path = START;
				return new StartPath(null);
		}
	}
}
