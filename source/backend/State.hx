package backend;

import lime.app.Application;
import flixel.text.FlxText;
import flixel.FlxState;

class State extends FlxState
{
	public var displayVersion:Bool = true;
	public var version:FlxText;

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

		version = new FlxText(2, 2, 0, Application.current.meta.get('version'), 16);
		version.alpha = 0.25;
		version.scrollFactor.set();
		if (displayVersion)
			add(version);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		members.sort((basic1, basic2) ->
		{
			if (basic1 == version)
				return 1;
			if (basic2 == version)
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
