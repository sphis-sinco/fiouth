package frontend.gameplay.scenes;

import frontend.gameplay.scenes.KeypadScene;
import flixel.util.FlxTimer;
import backend.TextTags;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import backend.gameplay.PathState;

class FirstChoiceScene extends PathState
{
	override public function new()
	{
		super(FIRST_CHOICE);
	}

	public var dialog:FlxText;

	public var selection:Int = 0;

	public var yes:FlxText;
	public var no:FlxText;

	public var dialogs:Array<String> = [
		'Pick the right choice for <blue>your<blue> <cyan>people<cyan>.',
		'All decisions, are yours.',
		'There are no wrong answers.',
		'We will be forgiving if you wish to stay.',
		'Remember what <cyan>they<cyan> did to <blue>them<blue>.',
		'Don\'t let <cyan>them<cyan> keep doing it to <blue>others<blue>.',
		'Remember that freedom is <cyan>everyone\'s<cyan> right',
		'It\'s time, <blue>Oaps.<blue>',
		'When <cyan>we\'re<cyan> done, there will be <blue>none<blue> left to rule.'
	];

	override function create()
	{
		super.create();

		FlxG.sound.playMusic('thereAreNoWrongOptions'.musicPath());
		FlxG.sound.music.fadeIn((!pathWasAlreadySet) ? 3 : 1, 0, 1);

		dialog = new FlxText();

		dialog.size = 32;
		dialog.fieldWidth = Std.int('When we\'re done'.length * (dialog.size / 2));

		dialog.screenCenter();

		add(dialog);

		dialog.alpha = 0;
		randomDialog();

		yes = new FlxText();
		no = new FlxText();

		yes.text = 'yes';
		no.text = 'no';

		yes.size = 32;
		no.size = 32;

		yes.screenCenter();
		no.screenCenter();

		yes.y -= yes.height;
		no.y += no.height;

		add(yes);
		add(no);

		FlxTimer.loop(30, l ->
		{
			randomDialog();
		}, 0);

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blk);
		FlxTween.tween(blk, {alpha: 0}, (!pathWasAlreadySet) ? 3 : 1 + 3);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		yes.color = FlxColor.WHITE;
		no.color = FlxColor.WHITE;

		if (selection == 0)
			yes.color = FlxColor.YELLOW;
		if (selection == 1)
			no.color = FlxColor.YELLOW;

		if (FlxG.keys.anyJustReleased([UP, W, DOWN, S, ENTER]))
		{
			var prevSel = selection;

			if (FlxG.keys.anyJustReleased([UP, W]))
				selection--;
			if (FlxG.keys.anyJustReleased([DOWN, S]))
				selection++;

			if (selection < 0)
				selection = 0;
			if (selection > 1)
				selection = 1;

			if (prevSel != selection)
				randomDialog();

			if (FlxG.keys.anyJustReleased([ENTER]))
			{
				FlxTimer.globalManager.clear();

				switch (selection)
				{
					case 0:
						setDialogueText('You have done well.');
					case 1:
						setDialogueText('...');

						FlxTween.tween(yes, {alpha: 0}, 6);
						FlxTween.tween(no, {alpha: 0}, 6);

						FlxG.sound.music.fadeOut(3, 0, t ->
						{
							FlxG.sound.playMusic('butYouPickedTheWorstOption'.musicPath());

							var line = 'Why did you do that?';

							setDialogueTextNoFade(line);

							FlxTimer.wait(2, () ->
							{
								FlxTimer.wait(.01, () -> setDialogueTextNoFade('YOui hva'));
								FlxTimer.wait(.04, () -> setDialogueTextNoFade('YOU HAVE'));
								FlxTimer.wait(.43, () -> setDialogueTextNoFade('FO9irgOTnen YUOR pL'));
								FlxTimer.wait(.5, () -> setDialogueTextNoFade('FORGOTTEN YOUR PLACE'));
								FlxTimer.wait(1, () -> setDialogueTextNoFade('DO NOT TOY WITH ME OAPS.'));
								FlxTimer.wait(2, () -> setDialogueTextNoFade('YOU REMEMBER WHAT WE DID TO THEM.'));
								FlxTimer.wait(4, () -> setDialogueTextNoFade('WOULD YOU LIKE TO REALLY SUFFER THE SAME FATE?'));
								FlxTimer.wait(6, () -> setDialogueTextNoFade('OR MAYBE WE HAVENT HURT YOUR FAMILY ENOUGH'));
								FlxTimer.wait(8, () -> setDialogueTextNoFade('THEY AREN\'T SAFE OAPS.'));
								FlxTimer.wait(10, () -> setDialogueTextNoFade('AND NOW.'));
								FlxTimer.wait(10.01, () -> dialog.screenCenter());
								FlxTimer.wait(13, () -> setDialogueTextNoFade('THEY\'RE DEAD.'));
								FlxTimer.wait(13.01, () -> dialog.screenCenter());
								FlxTimer.wait(13, () ->
								{
									FlxG.sound.play('transportation'.soundsPath());
									FlxTimer.wait(3.65, () ->
									{
										dialog.visible = false;
										version.visible = false;
										FlxG.camera.flash(FlxColor.WHITE, 3, () -> FlxG.switchState(() -> new KeypadScene()));
										FlxG.sound.music.fadeOut(3, 0, t -> FlxG.sound.music.stop());
									});
								});
							});

							FlxG.sound.music.fadeIn(3, 0, 1, t -> {});
						});
				}
			}
		}
	}

	public function randomDialog()
	{
		setDialogueText(dialogs[FlxG.random.int(0, dialogs.length - 1)]);
	}

	public function setDialogueText(text:String)
	{
		FlxTween.cancelTweensOf(dialog);
		FlxTween.tween(dialog, {alpha: 0}, 1.0, {
			ease: FlxEase.sineInOut,
			onComplete: t ->
			{
				setDialogueTextNoFade(text);

				FlxTween.tween(dialog, {alpha: 1}, 1.0, {
					ease: FlxEase.sineInOut
				});
			}
		});
	}

	public function setDialogueTextNoFade(text:String)
	{
		dialog.text = text;
		playDialogueSound();
		var randomPos:Void->Void = () ->
		{
			dialog.setPosition(FlxG.random.float(160, (FlxG.width - 160) - dialog.width), FlxG.random.float(160, (FlxG.height - 160) - dialog.height));
		}

		randomPos();
		while (dialog.overlaps(yes) || dialog.overlaps(no))
			randomPos();
		TextTags.apply(dialog);
	}

	public function playDialogueSound()
	{
		FlxG.sound.play('dialogue'.soundsPath());
	}
}
