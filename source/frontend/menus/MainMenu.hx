package frontend.menus;

import flixel.text.FlxText;
import backend.State;

class MainMenu extends State
{
	public var title:FlxText;

	override public function create()
	{
		super.create();

		title = new FlxText();
		title.text = "Fiouth";

		title.size = 32;
		
		title.screenCenter();
		title.y -= title.height * 4;

		add(title);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
