package frontend.gameplay.paths;

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

	override function create()
	{
		super.create();

		FlxG.sound.playMusic('thereAreNoWrongOptions'.musicPath());
		FlxG.sound.music.fadeIn(3, 0, 1);

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blk);
		FlxTween.tween(blk, {alpha: 0}, 3);
	}
}
