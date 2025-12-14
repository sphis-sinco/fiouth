package frontend.gameplay.scenes.firstchoiceyes;

import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import backend.Sprite;
import flixel.tweens.FlxTween;

class ArmyMeetingInteractive extends MeetTheArmy
{
	override public function new()
	{
		super(MEET_THE_ARMY_INTERACTIVE);
	}

	public var canInteract:Bool = false;

	override function create()
	{
		super.create();
	}

	override function startSequence()
	{
		remove(commander);
		commander.destroy();

		var i = 0;

		for (character in [bluespike, emalf, tistec])
		{
			i++;
			new FlxTimer().start(3 - (i * 0.5), t ->
			{
				character.color = 0xFFFFFF;
			});
		}

		new FlxTimer().start(3, t ->
		{
			canInteract = true;
			enableCursor = true;
		});
	}
}
