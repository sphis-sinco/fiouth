package frontend.menus;

import flixel.text.FlxText;
import backend.State;

class MainMenu extends State
{
	public var title:FlxText;

	public var playText:FlxText;

	override public function create()
	{
		super.create();

		title = new FlxText();
		title.text = "Fiouth";
		title.size = 64;

		title.screenCenter();
		title.y -= title.height * 2;

		add(title);

		playText = new FlxText();
		playText.text = "Play";
		playText.size = 24;

		playText.screenCenter();
		playText.y += playText.height * 2;

		add(playText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
