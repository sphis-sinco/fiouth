package frontend.gameplay.scenes;

import backend.utils.Dialog;
import flixel.sound.FlxSound;
import frontend.gameplay.scenes.firstchoiceyes.MeetTheArmy;
import backend.utils.MusicMan;
import frontend.gameplay.scenes.firstchoiceno.KeypadScene;
import flixel.util.FlxTimer;
import backend.utils.TextTags;
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

	override function get_finished():Bool
		return true;

	public var selection:Int = 0;

	public var yes:FlxText;
	public var no:FlxText;

	public var dialogs:Array<String>;

	override function create()
	{
		super.create();

		dialogs = Dialog.getLinesFromPathFolder('pre_decision', path);

		MusicMan.playMusic('thereAreNoWrongOptions', 1, null, () ->
		{
			FlxG.sound.music?.fadeIn((!pathWasAlreadySet) ? 3 : 1, 0, 1);
		});

		dialog.fieldWidth = Std.int('When we\'re done'.length * (dialog.size / 2));
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

				FlxTween.tween(yes, {alpha: 0}, 6);
				FlxTween.tween(no, {alpha: 0}, 6);

				FlxG.sound.music?.fadeOut(3, 0, t ->
				{
					switch (selection)
					{
						case 0:
							var time = -3;
							var decision_yes = Dialog.getLinesFromPathFolder('decision_yes', path);
							readDialogueList(decision_yes, 3, -3);
							time = 3 * (decision_yes.length - 1);

							MusicMan.playMusic('toldYou-intro');

							FlxTimer.wait(time, () ->
							{
								FlxG.sound.play('transportation'.soundsPath());
								FlxTimer.wait(3.65, () ->
								{
									dialog.visible = false;
									FlxG.camera.flash(FlxColor.WHITE, 3, () -> FlxG.switchState(() -> new MeetTheArmy()));
									FlxG.sound.music?.fadeOut(3, 0, t -> FlxG.sound.music?.stop());
								});
							});
						case 1:
							var decision_no:Array<String> = Dialog.getLinesFromPathFolder('decision_no', path);
							var crashout_times:Array<String> = Dialog.getLinesFromPathFolder('crashout_times', path);

							setDialogueText(decision_no[0]);

							MusicMan.playMusic('butYouPickedTheWorstOption', 1, null, () ->
							{
								FlxG.sound.music?.fadeIn(3, 0, 1);
							});

							FlxTimer.wait(2, () ->
							{
								decision_no.remove(decision_no[0]);

								var i = 0;
								for (line in decision_no)
								{
									FlxTimer.wait(Std.parseFloat(crashout_times[i]), () -> setDialogueTextNoFade(line));
									i++;
								}

								FlxTimer.wait(Std.parseFloat(crashout_times[crashout_times.length - 1]), () ->
								{
									FlxG.sound.play('transportation'.soundsPath());
									FlxTimer.wait(3.65, () ->
									{
										dialog.visible = false;
										FlxG.camera.flash(FlxColor.WHITE, 3, () -> FlxG.switchState(() -> new KeypadScene()));
										FlxG.sound.music?.fadeOut(3, 0, t -> FlxG.sound.music?.stop());
									});
								});
							});
					}
				});
			}
		}
	}

	public function randomDialog()
	{
		setDialogueText(dialogs[FlxG.random.int(0, dialogs.length - 1)]);
	}

	override function setDialogueTextNoFade(text:String)
	{
		super.setDialogueTextNoFade(text);
		var randomPos:Void->Void = () ->
		{
			dialog.setPosition(FlxG.random.float(160, (FlxG.width - 160) - dialog.width), FlxG.random.float(160, (FlxG.height - 160) - dialog.height));
		}

		randomPos();
		while (dialog.overlaps(yes) || dialog.overlaps(no))
			randomPos();
	}
}
