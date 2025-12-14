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
	{
		watermark.text = Application.current.meta.get('version');
	}

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

		FlxG.mouse.visible = FlxG.mouse.enabled;
	}

	public function turnOffCursor()
		FlxG.mouse.enabled = false;

	public function turnOnCursor()
		FlxG.mouse.enabled = true;
}
