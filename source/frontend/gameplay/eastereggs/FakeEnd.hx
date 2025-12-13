package frontend.gameplay.eastereggs;

import frontend.menus.MainMenu;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import backend.TextTags;
import backend.save.Save;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import backend.gameplay.PathState;

class FakeEnd extends PathState
{
	public var dialog:FlxText;

	override public function new()
	{
		super(START);
	}

	var randomCheaterCheaterLines:Array<String> = [
		'Cheater Cheater Meater Beater',
		'Cheater Cheater Pussy Eatter',

		'Cheater Cheater Pumpkin Eatter'
	];

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

		FlxG.sound.music.stop();

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blk);
		FlxTween.tween(blk, {alpha: 0}, 3);

		Save.data.gameplay.hasBegun = false;

		FlxTimer.wait(3, () ->
		{
			setDialogueText(randomCheaterCheaterLines[FlxG.random.int(0, randomCheaterCheaterLines.length - 1)]);
			FlxG.sound.playMusic('cheaterCheater'.musicPath());
			FlxG.sound.music.fadeIn(3, 0, 1);
		});

		FlxTimer.wait(20, () ->
		{
			FlxG.sound.play('transportation'.soundsPath());
			FlxTimer.wait(3.65, () ->
			{
				dialog.visible = false;
				FlxG.camera.flash(FlxColor.WHITE, 3);
				FlxG.sound.music.fadeOut(3, 0, t ->
				{
					FlxG.sound.music.stop();
					FlxG.switchState(() -> new MainMenu());
				});
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
				dialog.screenCenter();
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
