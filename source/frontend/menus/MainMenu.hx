package frontend.menus;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import backend.State;

class MainMenu extends State
{
	public var title:FlxText;

	public var playText:FlxText;
	public var optionsText:FlxText;

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
		playText.text = "Play";
		
		add(playText);

		optionsText = new FlxText();
		
		optionsText.size = 24;
		optionsText.text = "Options";

		add(optionsText);

		

		playText.screenCenter();
		playText.y += playText.height * 2;

		optionsText.screenCenter(X);
		optionsText.y = playText.y + playText.height * 2;

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
			if (selection > 1)
				selection = 1;

			updateOptionTexts();
		}
	}

	public function updateOptionTexts()
	{
		playText.color = (selection == 0) ? FlxColor.YELLOW : FlxColor.WHITE;
		optionsText.color = (selection == 1) ? FlxColor.YELLOW : FlxColor.WHITE;

		optionsText.alpha = 0.5;
	}
}
