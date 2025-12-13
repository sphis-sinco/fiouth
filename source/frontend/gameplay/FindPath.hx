package frontend.gameplay;

import frontend.gameplay.scenes.firstchoice_yes.MeetTheArmy;
import frontend.gameplay.scenes.FirstChoiceScene;
import frontend.gameplay.scenes.firstchoice_no.KeypadScene;
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
			case START:
				return new StartPath();

			case FAKE_END:
				trace('CHEATING USER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
				return new FakeEnd();

			case FIRST_CHOICE:
				return new FirstChoiceScene();

			case MEET_THE_ARMY:
				return new MeetTheArmy();

			case KEYPAD_SCENE:
				return new KeypadScene();

			default:
				trace('Unknown : going to start scene');
				return new StartPath();
		}
	}
}
