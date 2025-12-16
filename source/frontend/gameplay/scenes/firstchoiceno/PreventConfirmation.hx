package frontend.gameplay.scenes.firstchoiceno;

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

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0x17181F);
		add(blk);
		blk.x = blk.width;
		FlxTween.tween(blk, {x: -blk.width}, 3);
	}
}
