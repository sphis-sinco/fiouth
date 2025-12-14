package backend.state;

import backend.gameplay.PathState;

class DebugState extends State
{
	public var debugToggle:Bool = false;

	override function resetWatermark()
	{
		super.resetWatermark();

		watermark.text += "\nDebug State";
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.F3)
			debugToggle = !debugToggle;

		resetWatermark();

		if (debugToggle)
		{
			watermark.text += "\n\nState: " + Type.getClassName(Type.getClass(FlxG.state));
			if (Std.isOfType(FlxG.state, PathState))
			{
				var pathState:PathState = cast FlxG.state;

				watermark.text += "\n * Path: " + pathState.path;
			}
		}
	}
}
