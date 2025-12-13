package backend;

import lime.app.Application;
import flixel.text.FlxText;
import flixel.FlxState;

class State extends FlxState
{
	public var displayVersion:Bool = true;
	public var version:FlxText;

	override public function create()
	{
		super.create();

		version = new FlxText(2, 2, 0, Application.current.meta.get('version'), 16);
		version.alpha = 0.25;
		if (displayVersion)
			add(version);

		FlxG.mouse.visible = false;
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
	}
}
