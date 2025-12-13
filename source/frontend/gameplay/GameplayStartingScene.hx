package frontend.gameplay;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import backend.TextTags;
import backend.save.Save;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import backend.State;

class GameplayStartingScene extends State
{
	public var dialog:FlxText;

	override function create()
	{
		super.create();

		dialog = new FlxText();

		dialog.size = 32;

		dialog.screenCenter();

		add(dialog);

		dialog.alpha = 0;

		FlxTween.tween(dialog, {alpha: 1}, 1.0, {
			ease: FlxEase.sineInOut
		});

		setDialogueText('Welcome.');

		FlxG.sound.playMusic('welcome'.musicPath());
		FlxG.sound.music.fadeIn(3, 0, 1);

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blk);
		FlxTween.tween(blk, {alpha: 0}, 3);

		Save.data.gameplay.hasBegun = true;

		FlxTimer.wait(3, () -> setDialogueText('I\'m glad to finally get in touch'));

		FlxTimer.wait(6, () -> setDialogueText('<cyan>We<cyan> have been watching you'));
		FlxTimer.wait(7, () -> dialog.screenCenter());

		FlxTimer.wait(9, () -> setDialogueText('It\'s time for you to join <blue>your<blue> <cyan>people<cyan> once more.'));
		FlxTimer.wait(10, () -> dialog.screenCenter());

		FlxTimer.wait(12, () -> setDialogueText('You will know what to do.'));

		FlxTimer.wait(16, () -> setDialogueText('If not then lord have mercy upon your soul.'));

		FlxTimer.wait(20, () ->
		{
			FlxG.sound.play('transportation'.soundsPath());
			FlxTimer.wait(20, () ->
			{
				FlxG.camera.flash();
			});
		});
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
