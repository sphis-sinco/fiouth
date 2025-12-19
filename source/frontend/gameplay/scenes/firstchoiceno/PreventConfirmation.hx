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

	public var confirm:Sprite;
	public var deny:Sprite;

	override function create()
	{
		super.create();

		confirm = new Sprite();
		confirm.loadGraphic('objects/confirmationButton/confirm'.imagePath());
		add(confirm);

		deny = new Sprite();
		deny.loadGraphic('objects/confirmationButton/deny'.imagePath());
		add(deny);

		confirm.screenCenter();
		confirm.x -= confirm.width;

		deny.screenCenter();
		deny.x += deny.width;

		var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromString('0x17181F'));
		FlxTween.tween(blk, {x: -blk.width, alpha: 0}, 3);
		new FlxSound().loadStream('vent'.soundsPath()).play(false, 3);
		add(blk);
	}
}
