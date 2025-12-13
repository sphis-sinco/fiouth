package frontend.gameplay;

import flixel.FlxState;
import backend.save.Save;
import backend.GameplayPaths;

class FindPath
{
	public static function sendToStateBasedOnGameplayPath(path:GameplayPaths):FlxState
	{
		switch (path)
		{
			case START, START_OLD:
				Save.data.gameplay.path = START;
				return new GameplayStartingScene();

			default:
				trace('Unknown : going to start scene');

				Save.data.gameplay.path = START;
				return new GameplayStartingScene();
		}
	}
}
