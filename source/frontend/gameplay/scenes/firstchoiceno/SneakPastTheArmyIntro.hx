package frontend.gameplay.scenes.firstchoiceno;

import flixel.util.FlxTimer;
import backend.utils.Dialog;
import backend.gameplay.PathState;

class SneakPastTheArmyIntro extends PathState
{
	override public function new()
	{
		super(SNEAK_PAST_THE_ARMY_INTRO);
	}

	override function get_finished():Bool
	{
		return true;
	}

	public var intro_dialog:Array<String>;

	override function create()
	{
		super.create();

		intro_dialog = Dialog.getLinesFromPathFolder('intro_dialog', path);

		var time = 0;
		readDialogueList(intro_dialog);
		time = 2 * (intro_dialog.length - 1);

		FlxTimer.wait(time, function()
		{
			FlxG.switchState(() -> new SneakPastTheArmy());
		});
	}
}
