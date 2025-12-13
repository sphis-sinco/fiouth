package backend;

import flixel.FlxSprite;

class Sprite extends FlxSprite
{
	public static var DEFAULT_SCALE:Float = 6.0;

	override public function new(?x:Float, ?y:Float)
	{
		super(x, y);

		resetScale();
	}

	public function resetScale()
	{
		scale.set(DEFAULT_SCALE, DEFAULT_SCALE);
		updateHitbox();
	}
}
