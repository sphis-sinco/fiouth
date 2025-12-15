package frontend.gameplay.scenes.firstchoiceyes;

import flixel.util.FlxColor;
import frontend.objects.ui.Directional;
import backend.utils.Dialog;
import flixel.math.FlxPoint;
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
		return true;

	public var canInteract:Bool = false;

	override function create()
	{
		super.create();

		bluespike.ID = 1;
		emalf.ID = 2;
		tistec.ID = 3;

		leave.screenCenter(X);
		leave.y = (FlxG.height - leave.height);
		leave.justReleased = function()
		{
			if (leave.visible && dialog.text == '')
			{
				FlxG.camera.flash(FlxColor.WHITE, 3, () -> FlxG.switchState(() -> new GiveConfirmation()));
				FlxG.sound.music?.fadeOut(3, 0);
			}
		};
		leave.visible = false;
		add(leave);
	}

	public var selection:Int = 0;

	public var hadInteraction:Bool = false;

	public var leave:Directional = new Directional(DOWN);

	override function startSequence()
	{
		remove(commander);
		commander.destroy();

		enableCursor = true;

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
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		dialog.fieldWidth = FlxG.width;
		dialog.alignment = CENTER;

		selection = 0;
		for (character in [bluespike, emalf, tistec])
		{
			character.color = 0xCECECE;
			if (canInteract && FlxG.mouse.overlaps(character))
			{
				character.color = 0xFFFFFF;
				selection = character.ID;
			}
		}

		if (FlxG.mouse.justReleased && canInteract)
		{
			var offset = FlxPoint.get();

			if (selection > 0)
			{
				canInteract = false;

				for (character in [bluespike, emalf, tistec])
				{
					if (selection == character.ID)
					{
						if (character == bluespike)
							offset.x -= 480;
						if (character == tistec)
							offset.x += 480;

						characterDialogue(character);
					}
				}
			}

			camFollow.setPosition(FlxG.width / 2 + offset.x, FlxG.height / 2 + offset.y);
		}
	}

	override function debugWatermarks()
	{
		super.debugWatermarks();

		watermark.text += '\n\nSelected Character: ' + ['none', 'bluespike', 'emalf', 'tistec'][selection];
	}

	public function characterDialogue(character:Sprite)
	{
		var speed:Float = 1;

		var dialogs = Dialog.getLinesFromPathFolder('temp', path);

		if (character == bluespike)
			dialogs = Dialog.getLinesFromPathFolder('bluespike', path);
		if (character == emalf)
			dialogs = Dialog.getLinesFromPathFolder('emalf', path);
		if (character == tistec)
			dialogs = Dialog.getLinesFromPathFolder('tistec', path);

		var i = 0;
		for (line in dialogs)
		{
			FlxTimer.wait(speed * (i * 2), () ->
			{
				trace(line);
				setDialogueText(line, speed);
			});

			i++;
		}

		FlxTimer.wait(speed * (dialogs.length * 2) + speed, function()
		{
			hadInteraction = true;

			setDialogueText('', speed);
			canInteract = true;
			selection = 0;

			if (!leave.visible)
			{
				leave.alpha = 0;
				leave.visible = true;

				FlxTween.tween(leave, {alpha: 1}, 1, {
					ease: FlxEase.sineInOut
				});
			}
		});
	}

	override function setDialogueTextNoFade(text:String)
	{
		super.setDialogueTextNoFade(text);

		dialog.x = camFollow.x - (FlxG.width / 2);
	}
}
