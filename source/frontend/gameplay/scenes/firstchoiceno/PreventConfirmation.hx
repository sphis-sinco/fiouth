package frontend.gameplay.scenes.firstchoiceno;

import flixel.sound.FlxSound;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import backend.gameplay.PathState;

class PreventConfirmation extends PathState
{
	override public function new()
	{
		super(PREVENT_CONFIRMATION);
	}

	override function get_finished():Bool
	{
		return false;
	}

	override function create()
	{
		super.create();

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromString('0x17181F'));
		add(blk);
		FlxTween.tween(blk, {x: -blk.width, alpha: 0}, 3);
		new FlxSound().loadStream('vent'.soundsPath()).play(false, 3);
	}
}
