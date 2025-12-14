package backend.state;

import backend.gameplay.PathState;

class DebugState extends State
{
	override function resetWatermark()
	{
		super.resetWatermark();

		watermark.text += "\nDebug State";
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.F3)
		{
			resetWatermark();

			watermark.text += "\n\nState: " + Type.getClassName(FlxG.state);
			if (Std.isOfType(FlxG.state, PathState))
			{
				var pathState:PathState = cast FlxG.state;

				watermark.text += "\n * Path: " + pathState.path;
			}
		}
	}
}
