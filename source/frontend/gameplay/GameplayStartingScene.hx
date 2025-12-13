package frontend.gameplay;

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

		dialog.text = "Welcome.";
		dialog.size = 128;

		dialog.screenCenter();

		add(dialog);

		dialog.alpha = 0;

		FlxTween.tween(dialog, {alpha: 1}, 1.0, {
			ease: FlxEase.sineInOut
		});

		playDialogueSound();

		FlxG.sound.playMusic('welcome'.musicPath());
	}

	public function playDialogueSound()
	{
		FlxG.sound.play('dialogue'.soundsPath());
	}
}
