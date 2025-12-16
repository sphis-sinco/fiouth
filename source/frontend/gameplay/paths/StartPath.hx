package frontend.gameplay.paths;

import backend.utils.Dialog;
import flixel.sound.FlxSound;
import backend.utils.MusicMan;
import frontend.gameplay.scenes.FirstChoiceScene;
import backend.gameplay.PathState;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import backend.utils.TextTags;
import backend.save.Save;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;

class StartPath extends PathState
{
	override public function new()
	{
		super(START);
	}

	override function get_finished():Bool
		return true;

	var lines:Array<String>;

	override function create()
	{
		super.create();

		lines = Dialog.getLines(path);

		setDialogueText('Welcome.');
		MusicMan.playMusic('welcome', 1, null, () ->
		{
			FlxG.sound.music?.fadeIn(3, 0, 1);
		});

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blk);
		FlxTween.tween(blk, {alpha: 0}, 3);

		Save.data.gameplay.hasBegun = true;

		var time = 0;

		// 3, 6, 9, 12, 15, 18, 21
		readDialogueList(lines, 3);

		FlxTimer.wait(time, () ->
		{
			FlxG.sound.play('transportation'.soundsPath());
			FlxTimer.wait(3.65, () ->
			{
				dialog.visible = false;
				FlxG.camera.flash(FlxColor.WHITE, 3, () -> FlxG.switchState(() -> new FirstChoiceScene()));
				FlxG.sound.music?.fadeOut(3, 0);
			});
		});
	}

	override function setDialogueTextNoFade(text:String)
	{
		super.setDialogueTextNoFade(text);

		dialog.setPosition(FlxG.random.float(80, (FlxG.width - 80) - dialog.width), FlxG.random.float(80, (FlxG.height - 80) - dialog.height));
	}
}
