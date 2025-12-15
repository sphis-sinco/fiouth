package frontend.objects.ui;

import backend.Sprite;
import flixel.FlxSprite;

enum abstract DirectionalDirection(String)
{
	var LEFT = 'left';
	var DOWN = 'down';
	var UP = 'up';
	var RIGHT = 'right';
}

class Directional extends Sprite
{
	public var justPressed:Void->Void = null;
	public var justPressedMiddle:Void->Void = null;
	public var justPressedRight:Void->Void = null;

	public var justReleased:Void->Void = null;
	public var justReleasedMiddle:Void->Void = null;
	public var justReleasedRight:Void->Void = null;

	public var pressed:Void->Void = null;
	public var pressedMiddle:Void->Void = null;
	public var pressedRight:Void->Void = null;

	public var released:Void->Void = null;
	public var releasedMiddle:Void->Void = null;
	public var releasedRight:Void->Void = null;

	override public function new(directional:DirectionalDirection = LEFT, ?x:Float, ?y:Float)
	{
		super(x, y);

		loadDirectional(directional);
	}

	public function loadDirectional(directional:DirectionalDirection = LEFT)
	{
		loadGraphic('ui/directionals/$directional'.imagePath());
		updateHitbox();
	}

	override function resetScale()
	{
		super.resetScale();

		scale.set(Sprite.DEFAULT_SCALE / 2, Sprite.DEFAULT_SCALE / 2);
		updateHitbox();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(this))
		{
			if (FlxG.mouse.justPressed && justPressed != null)
				justPressed();
			if (FlxG.mouse.justPressedMiddle && justPressedMiddle != null)
				justPressedMiddle();
			if (FlxG.mouse.justPressedRight && justPressedRight != null)
				justPressedRight();

			if (FlxG.mouse.justReleased && justReleased != null)
				justReleased();
			if (FlxG.mouse.justReleasedMiddle && justReleasedMiddle != null)
				justReleasedMiddle();
			if (FlxG.mouse.justReleasedRight && justReleasedRight != null)
				justReleasedRight();

			if (FlxG.mouse.pressed && pressed != null)
				pressed();
			if (FlxG.mouse.pressedMiddle && pressedMiddle != null)
				pressedMiddle();
			if (FlxG.mouse.pressedRight && pressedRight != null)
				pressedRight();

			if (FlxG.mouse.released && released != null)
				released();
			if (FlxG.mouse.releasedMiddle && releasedMiddle != null)
				releasedMiddle();
			if (FlxG.mouse.releasedRight && releasedRight != null)
				releasedRight();
		}
	}
}
