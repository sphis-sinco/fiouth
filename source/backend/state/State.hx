package backend.state;

import lime.app.Application;
import flixel.text.FlxText;
import flixel.FlxState;

class State extends FlxState
{
	public var displayWatermark:Bool = true;
	public var watermark:FlxText;

	public var enableCursor(default, set):Bool = false;

	function set_enableCursor(value:Bool):Bool
	{
		if (value)
			turnOnCursor();
		else
			turnOffCursor();

		return value;
	}

	override public function new()
	{
		super();
		enableCursor = false;
	}

	override public function create()
	{
		super.create();

		watermark = new FlxText(2, 2, 0, '', 16);
		watermark.alpha = 0.25;
		watermark.scrollFactor.set();
		if (displayWatermark)
			add(watermark);

		resetWatermark();
	}

	public function resetWatermark()
		watermark.text = Global.VERSION;

	public function debugWatermarks() {}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		members.sort((basic1, basic2) ->
		{
			if (basic1 == watermark)
				return 1;
			if (basic2 == watermark)
				return -1;
			return 0;
		});

		CursorController.mouse.visible = CursorController.mouse.enabled;

		resetWatermark();

		if (debugToggle)
			debugWatermarks();

		if (CursorController.cursor_state != DEFAULT)
			CursorController.cursor_state = DEFAULT;
	}

	public var debugToggle:Bool = false;

	public function turnOffCursor()
		CursorController.mouse.enabled = false;

	public function turnOnCursor()
		CursorController.mouse.enabled = true;
}
