package frontend.gameplay.paths;

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

	override function create()
	{
		super.create();

		FlxG.sound.playMusic('thereAreNoWrongOptions'.musicPath());
		FlxG.sound.music.fadeIn(3, 0, 1);

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blk);
		FlxTween.tween(blk, {alpha: 0}, 3);

		dialog = new FlxText();

		dialog.size = 32;

		dialog.screenCenter();

		add(dialog);

		dialog.alpha = 0;
		setDialogueText('Pick the right choice for <blue>your<blue> <cyan>people<cyan>.');
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
