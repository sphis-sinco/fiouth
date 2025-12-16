package frontend.gameplay.scenes.firstchoiceno;

import flixel.util.FlxTimer;
import backend.utils.Dialog;
import backend.Sprite;
import backend.gameplay.PathState;

using StringTools;

class SneakPastTheArmy extends PathState
{
	override public function new()
	{
		super(SNEAK_PAST_THE_ARMY);
	}

	override function get_finished():Bool
	{
		return false;
	}

	public var commander:Sprite;

	public var intro_dialog:Array<String>;

	override function create()
	{
		super.create();

		intro_dialog = Dialog.getLinesFromPathFolder('intro_dialog', path);

		commander = new Sprite(0, 0, -Std.int(Sprite.DEFAULT_SCALE / 2));
		commander.loadGraphic('characters/sprites/army/commander_left-angry'.imagePath());
		add(commander);

		commander.screenCenter();

		var time = 0;
		for (dialog in intro_dialog)
		{
			FlxTimer.wait(time, function()
			{
				if (dialog.startsWith('<event>') && dialog.endsWith('<event>'))
					eventFunction(dialog.split('<event>'));
				else
					setDialogueText(dialog, 1);
			});
			time += 2;
		}
	}

	public function eventFunction(event:Array<String>)
	{
		trace(event);
	}
}
