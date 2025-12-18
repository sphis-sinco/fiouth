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

	override public function new(directional:DirectionalDirection = LEFT, ?x:Float, ?y:Float, ?scaleOffset:Int = 0)
	{
		super(x, y, -Std.int(Sprite.DEFAULT_SCALE / 2) + scaleOffset);

		loadDirectional(directional);
	}

	public function loadDirectional(directional:DirectionalDirection = LEFT)
	{
		loadGraphic('ui/directionals/$directional'.imagePath());
		updateHitbox();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (CursorController.mouse.overlaps(this))
		{
			if (CursorController.cursor_state == DEFAULT)
				CursorController.cursor_state = POINT;

			if (CursorController.mouse.justPressed && justPressed != null)
				justPressed();
			if (CursorController.mouse.justPressedMiddle && justPressedMiddle != null)
				justPressedMiddle();
			if (CursorController.mouse.justPressedRight && justPressedRight != null)
				justPressedRight();

			if (CursorController.mouse.justReleased && justReleased != null)
				justReleased();
			if (CursorController.mouse.justReleasedMiddle && justReleasedMiddle != null)
				justReleasedMiddle();
			if (CursorController.mouse.justReleasedRight && justReleasedRight != null)
				justReleasedRight();

			if (CursorController.mouse.pressed && pressed != null)
				pressed();
			if (CursorController.mouse.pressedMiddle && pressedMiddle != null)
				pressedMiddle();
			if (CursorController.mouse.pressedRight && pressedRight != null)
				pressedRight();

			if (CursorController.mouse.released && released != null)
				released();
			if (CursorController.mouse.releasedMiddle && releasedMiddle != null)
				releasedMiddle();
			if (CursorController.mouse.releasedRight && releasedRight != null)
				releasedRight();
		}
	}
}
