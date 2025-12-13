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

		version = new FlxText(10, 10, 0, Application.current.meta.get('version'), 16);
		version.alpha = 0.25;
		if (displayVersion)
			add(version);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
