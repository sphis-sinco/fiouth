package backend;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;

class Sprite extends FlxSprite
{
	public static var DEFAULT_SCALE:Float = 6.0;

	public var scaleOffset:Int = 0;

	override public function new(?x:Float, ?y:Float, ?scaleOffset:Int = 0)
	{
		super(x, y);

		this.scaleOffset = scaleOffset;
		resetScale();
	}

	public function resetScale()
	{
		scale.set(DEFAULT_SCALE + scaleOffset, DEFAULT_SCALE + scaleOffset);
		updateHitbox();
	}

	public function loadGraphicAndUpdateHitbox(graphic:FlxGraphicAsset, animated:Bool = false, frameWidth:Int = 0, frameHeight:Int = 0, unique:Bool = false,
			?key:String):FlxSprite
	{
		loadGraphic(graphic, animated, frameWidth, frameHeight, unique, key);
		updateHitbox();

		return this;
	}
}
