package frontend.gameplay.paths;

import flixel.util.FlxTimer;
import backend.TextTags;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import backend.gameplay.PathState;

class FirstChoicePath extends PathState
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
		'We will be forgiving if you wish to stay.'
	];

	override function create()
	{
		super.create();

		FlxG.sound.music.fadeOut(3, 0, t ->
		{
			FlxG.sound.playMusic('thereAreNoWrongOptions'.musicPath());
			FlxG.sound.music.fadeIn(3, 0, 1);
		});

		dialog = new FlxText();

		dialog.size = 32;

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
		FlxTween.tween(blk, {alpha: 0}, 6);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustReleased([UP, W, DOWN, S, ENTER]))
		{
			if (FlxG.keys.anyJustReleased([UP, W]))
				selection--;
			if (FlxG.keys.anyJustReleased([DOWN, S]))
				selection++;

			if (selection < 0)
				selection = 0;
			if (selection > 1)
				selection = 1;

			yes.color = FlxColor.WHITE;
			no.color = FlxColor.WHITE;

			if (selection == 0)
				yes.color = FlxColor.YELLOW;
			if (selection == 1)
				no.color = FlxColor.YELLOW;

			if (FlxG.keys.anyJustReleased([ENTER]))
			{
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
							FlxG.sound.music.fadeIn(3, 0, 1, t ->
							{
								setDialogueText('Why did you do that?');
							});
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
		FlxTween.tween(dialog, {alpha: 0}, 1.0, {
			ease: FlxEase.sineInOut,
			onComplete: t ->
			{
				dialog.text = text;
				playDialogueSound();
				dialog.setPosition(FlxG.random.float(80, (FlxG.width - 80) - dialog.width), FlxG.random.float(80, (FlxG.height - 80) - dialog.height));
				TextTags.apply(dialog);

				FlxTween.tween(dialog, {alpha: 1}, 1.0, {
					ease: FlxEase.sineInOut
				});
			}
		});
	}

	public function playDialogueSound()
	{
		FlxG.sound.play('dialogue'.soundsPath());
	}
}
