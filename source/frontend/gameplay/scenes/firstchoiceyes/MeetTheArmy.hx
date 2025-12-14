package frontend.gameplay.scenes.firstchoiceyes;

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

	public var bluespike:Sprite = new Sprite();
	public var commander:Sprite = new Sprite();
	public var emalf:Sprite = new Sprite();
	public var tistec:Sprite = new Sprite();

	public var dialog:FlxText;

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

		dialog = new FlxText();

		dialog.size = 32;
		dialog.screenCenter();
		dialog.y = 32;

		add(dialog);

		if (!FlxG.sound.music?.playing)
			MusicMan.playMusic('FormalGreeting', 1, null, () ->
			{
				FlxG.sound.music.fadeIn(3, 0, 1);
			});
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

	public function setDialogueText(text:String, ?speed:Float = 1, ?formatTag:String)
	{
		FlxTween.cancelTweensOf(dialog);
		FlxTween.tween(dialog, {alpha: 0}, speed / 2, {
			ease: FlxEase.sineInOut,
			onComplete: t ->
			{
				setDialogueTextNoFade(((formatTag != null) ? '<$formatTag>' : '') + text + ((formatTag != null) ? '<$formatTag>' : ''));

				FlxTween.tween(dialog, {alpha: 1}, speed / 2, {
					ease: FlxEase.sineInOut
				});
			}
		});
	}

	public function setDialogueTextNoFade(text:String)
	{
		dialog.text = text;

		playDialogueSound();
		TextTags.apply(dialog);

		dialog.screenCenter(X);
	}

	var dialogue:FlxSound = new FlxSound().loadStream('dialogue'.soundsPath());

	public function playDialogueSound()
		dialogue.play(true);
}
