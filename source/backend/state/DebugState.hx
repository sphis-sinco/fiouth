package backend.state;

import backend.save.Save;
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

		if (FlxG.keys.justReleased.F3)
			debugToggle = !debugToggle;
	}

	override public function debugWatermarks()
	{
		watermark.text += "\n\nState: " + Type.getClassName(Type.getClass(FlxG.state));
		if (Std.isOfType(FlxG.state, PathState))
		{
			var pathState:PathState = cast FlxG.state;

			watermark.text += "\n * Path: " + pathState.path;
		}

		watermark.text += "\n\nSave slot: " + Save.currentSaveSlot;
	}
}
