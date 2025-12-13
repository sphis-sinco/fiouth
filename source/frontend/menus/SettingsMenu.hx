package frontend.menus;

import flixel.text.FlxText;
import backend.State;

class SettingsMenu extends State
{
	override function create()
	{
		super.create();

        var wipText:FlxText = new FlxText(2, version.y, 0, "[[Work in Progress]]", 16);
        add(wipText);
        wipText.alpha = version.alpha;

		version.y += wipText.height;
	}
}
