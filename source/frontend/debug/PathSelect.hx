package frontend.debug;

import backend.utils.Sorts;
import backend.gameplay.GameplayPaths;
import backend.State;

class PathSelect extends State
{
	public var paths:Array<GameplayPaths>[
		START,
		FIRST_CHOICE,
		MEET_THE_ARMY,
		MEET_THE_ARMY_INTERACTIVE,
		GIVE_CONFIRMATION,
		KEYPAD_SCENE,
		SNEAK_PAST_THE_ARMY,
		PREVENT_CONFIRMATION,
		BETRAYAL_PATH_INTRO,
		LOYALTY_PATH_INTRO,
		ENDING_REMEMBERANCE,
		ENDING_ONE_WHO_TRIED,
		FAKE_END;
	];

	override function create()
	{
		super.create();

        paths.sort(Sorts.alphabetically);
	}
}
