package frontend.gameplay;

import frontend.gameplay.scenes.firstchoiceno.SneakPastTheArmy;
import frontend.gameplay.scenes.firstchoiceno.PreventConfirmation;
import frontend.gameplay.paths.loyalty_path.LoyaltyPathIntro;
import frontend.gameplay.scenes.firstchoiceyes.GiveConfirmation;
import frontend.gameplay.endings.RememberanceEnding;
import frontend.gameplay.paths.betrayer_path.BetrayerPathIntro;
import frontend.gameplay.scenes.firstchoiceyes.MeetTheArmy;
import frontend.gameplay.scenes.FirstChoiceScene;
import frontend.gameplay.scenes.firstchoiceno.KeypadScene;
import frontend.gameplay.eastereggs.FakeEnd;
import frontend.gameplay.paths.StartPath;
import flixel.FlxState;
import backend.gameplay.GameplayPaths;

class FindPath
{
	public static function sendToStateBasedOnGameplayPath(path:GameplayPaths):FlxState
	{
		switch (path)
		{
			case START: return new StartPath();
			case FIRST_CHOICE: return new FirstChoiceScene();
			case MEET_THE_ARMY: return new MeetTheArmy();
			case GIVE_CONFIRMATION: return new GiveConfirmation();
			case KEYPAD_SCENE: return new KeypadScene();
			case PREVENT_CONFIRMATION: return new PreventConfirmation();
			case SNEAK_PAST_THE_ARMY: return new SneakPastTheArmy();
			case BETRAYAL_PATH_INTRO: return new BetrayerPathIntro();
			case ENDING_REMEMBERANCE: return new RememberanceEnding();
			case LOYALTY_PATH_INTRO: return new LoyaltyPathIntro();
			case ENDING_ONE_WHO_TRIED: return new RememberanceEnding();
			case FAKE_END:
				trace('CHEATING USER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
				return new FakeEnd();
		}
		trace('Unknown : going to start scene');
		return new StartPath();
	}
}
