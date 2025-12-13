package frontend.gameplay;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import backend.State;

class GameplayStartingScene extends State
{
	public var welcome:FlxText;

	override function create()
	{
		super.create();

		welcome = new FlxText();

		welcome.text = "Welcome.";
		welcome.size = 128;

		welcome.screenCenter();

		add(welcome);

		welcome.alpha = 0;

		FlxTween.tween(welcome, {alpha: 1}, 1.0, {
			ease: FlxEase.sineInOut
		});

		playDialogueSound();
	}

	public function playDialogueSound()
	{
		FlxG.sound.play('assets/sounds/dialogue.wav', FlxG.random.float(0.3, .6));
	}
}
