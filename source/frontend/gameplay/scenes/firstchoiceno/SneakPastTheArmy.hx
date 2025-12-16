package frontend.gameplay.scenes.firstchoiceno;

import flixel.tweens.FlxTween;
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
	public var bluespike:Sprite;

	public var intro_dialog:Array<String>;

	public var playing:Bool = false;

	override function create()
	{
		super.create();

		intro_dialog = Dialog.getLinesFromPathFolder('intro_dialog', path);

		commander = new Sprite(0, 0, -Std.int(Sprite.DEFAULT_SCALE / 2));
		commander.loadGraphic('characters/sprites/army/commander_left-angry'.imagePath());
		add(commander);

		commander.screenCenter();

		bluespike = new Sprite(0, 0, commander.scaleOffset);
		bluespike.loadGraphic('characters/sprites/army/bluespike-idle'.imagePath());
		add(bluespike);

		bluespike.screenCenter();

		bluespike.x += bluespike.width * 4;

		readDialogueList(intro_dialog);
	}

	override function eventFunction(events:Array<String>)
	{
		super.eventFunction(events);

		if (events.contains('bluespike_move'))
		{
			var tick = 0;
			FlxTween.tween(bluespike, {x: commander.x + bluespike.width * 2}, 1, {
				onUpdate: function(t:FlxTween)
				{
					tick++;

					if (tick % 10 == 0)
					{
						if (bluespike.graphic.key.endsWith('walk.png'))
							bluespike.loadGraphic('characters/sprites/army/bluespike-idle'.imagePath());
						else
							bluespike.loadGraphic('characters/sprites/army/bluespike-walk'.imagePath());
					}
				}
			});
		}
	}

	override function setDialogueTextNoFade(text:String)
	{
		super.setDialogueTextNoFade(text);

		dialog.y = 32;
	}
}
