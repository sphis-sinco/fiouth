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
		mouse.cursor.scaleX = 4;
		mouse.cursor.scaleY = 4;
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
		mouse.load('ui/cursors/$cursor_state'.imagePath());
	}
}

enum abstract CursorStates(String)
{
	var DEFAULT = 'default';
	var POINT = 'point';
}
