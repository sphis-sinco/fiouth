package frontend.gameplay.scenes.firstchoiceyes;

import flixel.FlxObject;
import backend.gameplay.GameplayPaths;
import flixel.sound.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import backend.utils.TextTags;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import backend.utils.MusicMan;
import backend.Sprite;
import backend.gameplay.PathState;

class MeetTheArmy extends PathState
{
	override public function new(path:GameplayPaths = MEET_THE_ARMY)
	{
		super(path);
	}

	override function get_finished():Bool
		return true;

	public var bluespike:Sprite = new Sprite();
	public var commander:Sprite = new Sprite();
	public var emalf:Sprite = new Sprite();
	public var tistec:Sprite = new Sprite();

	public var camFollow:FlxObject;

	override function setDialogueTextNoFade(text:String)
	{
		super.setDialogueTextNoFade(text);

		dialog.y = 32;
	}

	override function create()
	{
		super.create();

		bluespike.loadGraphic('characters/portraits/army/bluespike'.imagePath());
		commander.loadGraphic('characters/portraits/army/commander'.imagePath());
		emalf.loadGraphic('characters/portraits/army/emalf'.imagePath());
		tistec.loadGraphic('characters/portraits/army/tistec'.imagePath());

		for (object in [bluespike, emalf, tistec, commander])
		{
			object.resetScale();

			object.scale.x -= 3;
			object.scale.y -= 3;
			object.updateHitbox();

			object.color = 0x4E4E4E;

			object.screenCenter();

			object.y = FlxG.height - object.height;

			add(object);
		}

		commander.color = 0xFFFFFF;
		commander.resetScale();
		commander.screenCenter();

		bluespike.x -= bluespike.width * 1.5;
		tistec.x += tistec.width * 1.5;

		if (!FlxG.sound.music?.playing)
			MusicMan.playMusic('FormalGreeting', 1, null, () ->
			{
				FlxG.sound.music?.fadeIn(3, 0, 1);
			});

		camFollow = new FlxObject(FlxG.width / 2, FlxG.height / 2);
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, .1);

		startSequence();
	}

	public function startSequence()
	{
		FlxG.sound.play('pod_open'.soundsPath(), 0.25);
		FlxG.camera.flash(FlxColor.BLACK, 3);

		FlxTimer.wait(0, () -> setDialogueText('You knew what to do.', 1, 'cyan'));
		FlxTimer.wait(4, () -> setDialogueText('And I\'m glad.', 1, 'cyan'));
		FlxTimer.wait(7, () -> setDialogueText('Since you\'ll be with us.', 1, 'cyan'));
		FlxTimer.wait(10, () -> setDialogueText('You might as well get to know us.', 1, 'cyan'));
		FlxTimer.wait(13, () -> setDialogueText('I\'ll leave you four be.', 1, 'cyan'));
		FlxTimer.wait(16, function()
		{
			setDialogueText('', 1, 'cyan');
			FlxTween.tween(commander, {x: -commander.width * 2}, 2, {
				ease: FlxEase.sineInOut,
				onComplete: t ->
				{
					FlxG.switchState(() -> new ArmyMeetingInteractive());
				}
			});
		});
	}
}
