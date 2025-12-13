package frontend.menus;

import flixel.util.FlxColor;
import backend.save.Save;
import flixel.text.FlxText;
import backend.State;

class SettingsMenu extends State
{
	public var selection:Int = 0;

	public var volumeText:FlxText;

	override function create()
	{
		super.create();

		var wipText:FlxText = new FlxText(2, version.y, 0, "[[Work in Progress]]", 16);
		add(wipText);
		wipText.alpha = version.alpha;

		version.y += wipText.height;

		volumeText = new FlxText(64, 64);
		volumeText.size = 16;
		add(volumeText);

		updateOptionTexts();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ESCAPE)
			FlxG.switchState(() -> new MainMenu());

		if (FlxG.keys.anyJustReleased([UP, W, DOWN, S, ENTER, LEFT, A, RIGHT, D]))
		{
			if (FlxG.keys.anyJustReleased([UP, W]))
				selection--;
			if (FlxG.keys.anyJustReleased([DOWN, S]))
				selection++;

			if (selection < 0)
				selection = 0;
			if (selection > 0)
				selection = 0;

			if (FlxG.keys.anyJustReleased([ENTER]))
				optionsEnter();
			if (FlxG.keys.anyJustReleased([LEFT, A]))
				optionsLeft();
			if (FlxG.keys.anyJustReleased([RIGHT, D]))
				optionsRight();

			updateOptionTexts();
		}
	}

	public function updateOptionTexts()
	{
		volumeText.text = 'Volume: ${Save.data.settings.volume}%';
		volumeText.color = (selection == 0) ? FlxColor.YELLOW : FlxColor.WHITE;

		FlxG.sound.volume = Std.int(Save.data.settings.volume / 100);
	}

	public function optionsEnter() {}

	public function optionsLeft()
	{
		if (selection == 0)
			Save.data.settings.volume -= 10;

		if (Save.data.settings.volume < 0)
			Save.data.settings.volume = 100;
	}

	public function optionsRight()
	{
		if (selection == 0)
			Save.data.settings.volume += 10;

		if (Save.data.settings.volume > 100)
			Save.data.settings.volume = 0;
	}
}
