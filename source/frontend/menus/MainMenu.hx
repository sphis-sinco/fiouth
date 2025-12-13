package frontend.menus;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import backend.State;

class MainMenu extends State
{
	public var title:FlxText;

	public var playText:FlxText;

	public var selection:Int = 0;

	override public function create()
	{
		super.create();

		title = new FlxText();
		title.text = "Fiouth";
		title.size = 128;

		title.screenCenter();
		title.y -= title.height * 1;

		add(title);

		playText = new FlxText();
		playText.size = 24;

		add(playText);

		updateOptionTexts();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustReleased([UP, W, DOWN, S]))
		{
			if (FlxG.keys.anyJustReleased([UP, W]))
				selection--;
			if (FlxG.keys.anyJustReleased([DOWN, S]))
				selection++;

			if (selection < 0)
				selection = 0;
			if (selection > 0)
				selection = 0;

			updateOptionTexts();
		}
	}

	public function updateOptionTexts()
	{
		playText.text = "Play";
		playText.color = FlxColor.WHITE;

		if (selection == 0)
		{
			playText.text = "> " + playText.text;
			playText.color = FlxColor.YELLOW;
		}

		playText.screenCenter();
		playText.y += playText.height * 2;
	}
}
