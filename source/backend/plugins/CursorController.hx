package backend.plugins;

import openfl.display.BitmapData;
import flixel.input.mouse.FlxMouse;
import flixel.FlxBasic;

class CursorController extends FlxBasic
{
	override public function new()
	{
		super();

		updateCursor();
	}

	public static var mouse(get, never):FlxMouse;

	static function get_mouse():FlxMouse
	{
		return FlxG.mouse;
	}

	public static var cursor_state(default, set):CursorStates;

	static function set_cursor_state(value:CursorStates):CursorStates
	{
		return value;

		updateCursor();
	}

	public static function updateCursor()
	{
		mouse.cursor.bitmapData = BitmapData.loadFromFile('ui/cursors/default'.imagePath()).value;
	}
}

enum abstract CursorStates(String)
{
	var DEFAULT = 'default';
}
