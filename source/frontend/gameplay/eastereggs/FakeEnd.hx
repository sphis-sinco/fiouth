package frontend.gameplay.eastereggs;

import flixel.sound.FlxSound;
import backend.utils.MusicMan;
import frontend.menus.MainMenu;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import backend.utils.TextTags;
import backend.save.Save;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import backend.gameplay.PathState;

class FakeEnd extends PathState
{
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

		FlxG.sound.music?.stop();

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blk);
		FlxTween.tween(blk, {alpha: 0}, 3);

		Save.data.gameplay.hasBegun = false;

		FlxTimer.wait(3, () ->
		{
			setDialogueText(randomCheaterCheaterLines[FlxG.random.int(0, randomCheaterCheaterLines.length - 1)]);
			MusicMan.playMusic('cheaterCheater', 1, null, () ->
			{
				FlxG.sound.music?.fadeIn(3, 0, 1);
			});
		});
		FlxTimer.wait(20, () ->
		{
			FlxG.sound.play('transportation'.soundsPath());
			FlxTimer.wait(3.65, () ->
			{
				dialog.visible = false;
				FlxG.camera.flash(FlxColor.WHITE, 3);
				FlxG.sound.music?.fadeOut(3, 0, t ->
				{
					FlxG.sound.music?.stop();
					FlxG.switchState(() -> new MainMenu());
				});
			});
		});
	}

	override function setDialogueTextNoFade(text:String)
	{
		super.setDialogueTextNoFade(text);

		dialog.screenCenter();
	}
}
