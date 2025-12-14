package frontend.gameplay.scenes.firstchoiceyes;

import haxe.Timer;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import backend.Sprite;
import flixel.tweens.FlxTween;
import frontend.menus.MainMenu;

class ArmyMeetingInteractive extends MeetTheArmy
{
	override public function new()
	{
		super(MEET_THE_ARMY_INTERACTIVE);
	}

	override function get_finished():Bool
		return false;

	public var canInteract:Bool = false;

	override function create()
	{
		super.create();
	}

	override function startSequence()
	{
		remove(commander);
		commander.destroy();

		var i = 3;

		for (character in [bluespike, emalf, tistec])
		{
			i--;
			new FlxTimer().start(3 - (i * 0.5), t ->
			{
				character.color = 0xFFFFFF;

				new FlxTimer().start((1 / FlxG.drawFramerate) * 1, t ->
				{
					character.scale.y += .2;
					character.updateHitbox();
					character.y = FlxG.height - character.height;
				});
				new FlxTimer().start((1 / FlxG.drawFramerate) * 4, t ->
				{
					character.scale.y += ((Sprite.DEFAULT_SCALE - 3) - character.scale.y) * (1 / Std.int(FlxG.drawFramerate / 10));
					character.updateHitbox();
					character.y = FlxG.height - character.height;
				}, Std.int(FlxG.drawFramerate / 5));
			});
		}

		new FlxTimer().start(3, t ->
		{
			canInteract = true;
			enableCursor = true;
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		for (character in [bluespike, emalf, tistec])
		{
			character.color = 0xCECECE;
			if (canInteract && FlxG.mouse.overlaps(character))
				character.color = 0xFFFFFF;
		}
	}
}
