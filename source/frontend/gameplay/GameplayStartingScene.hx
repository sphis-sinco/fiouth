package frontend.gameplay;

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
		Save.data.gameplay.hasBegun = true;

		FlxTimer.wait(3, () ->
		{
			setDialogueText('I\'m glad to finally get in touch');
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
