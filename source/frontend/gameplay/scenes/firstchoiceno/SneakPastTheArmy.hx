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

		bluespike.x += bluespike.width * 8;

		readDialogueList(intro_dialog);
	}

	override function eventFunction(events:Array<String>)
	{
		super.eventFunction(events);

		if (events.contains('commander_flip_direction'))
			commander.loadGraphic(commander.graphic.key.replace('_left', '_right'));

		if (events.contains('commander_idle'))
			commander.loadGraphic(commander.graphic.key.split('-')[0] + '-idle.png');

		if (events.contains('bluespike_move') || events.contains('bluespike_backup'))
		{
			var tick = 0;

			var newX = commander.x + bluespike.width * 4;

			if (events.contains('bluespike_backup'))
				newX = commander.x + bluespike.width * 8;

			FlxTween.tween(bluespike, {x: newX}, 2, {
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
				},
				onComplete: function(t:FlxTween)
				{
					bluespike.loadGraphic('characters/sprites/army/bluespike-idle'.imagePath());
				}
			});
		}
		if (events.contains('commander_move') || events.contains('commander_leave'))
		{
			var tick = 0;
			FlxTween.tween(commander, {x: events.contains('commander_leave') ? (commander.width * (FlxG.width / commander.width)): commander.x + bluespike.width * 4}, events.contains('commander_leave') ? 12 : 2, {
				onUpdate: function(t:FlxTween)
				{
					tick++;

					if (tick % 10 == 0)
					{
						if (commander.graphic.key.endsWith('walk.png'))
							commander.loadGraphic(commander.graphic.key.split('-')[0] + '-idle.png');
						else
							commander.loadGraphic(commander.graphic.key.split('-')[0] + '-walk.png');
					}
				},
				onComplete: function(t:FlxTween)
				{
					commander.loadGraphic(commander.graphic.key.split('-')[0] + '-idle.png');

					if (events.contains('commander_leave'))
						commander.visible = false;
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
