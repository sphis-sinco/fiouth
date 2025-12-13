package frontend.menus;

import flixel.math.FlxMath;
import flixel.util.FlxColor;
import backend.save.Save;
import flixel.text.FlxText;
import backend.State;

class SettingsMenu extends State
{
	private static var _selection:Int = 0;

	public var selection:Int = 0;

	public var clearSaveText:FlxText;
	public var volumeText:FlxText;
	public var saveSlotText:FlxText;

	override function create()
	{
		super.create();

		selection = _selection;

		clearSaveText = new FlxText(64, 64);
		clearSaveText.size = 16;
		add(clearSaveText);

		volumeText = new FlxText();
		volumeText.size = 16;
		add(volumeText);

		saveSlotText = new FlxText();
		saveSlotText.size = 16;
		add(saveSlotText);

		updateOptionTexts();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ESCAPE)
		{
			_selection = 0;
			FlxG.switchState(() -> new MainMenu());
		}

		if (FlxG.keys.anyJustReleased([UP, W, DOWN, S, ENTER, LEFT, A, RIGHT, D]))
		{
			if (FlxG.keys.anyJustReleased([UP, W]))
				selection--;
			if (FlxG.keys.anyJustReleased([DOWN, S]))
				selection++;

			if (selection < 0)
				selection = 0;
			if (selection > 2)
				selection = 2;
			_selection = selection;

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
		clearSaveText.text = 'Clear Save';
		clearSaveText.color = (selection == 0) ? FlxColor.YELLOW : FlxColor.WHITE;

		saveSlotText.text = 'Save Slot: ${Save.data.slot}';
		saveSlotText.color = (selection == 1) ? FlxColor.YELLOW : FlxColor.WHITE;
		saveSlotText.setPosition(clearSaveText.x, clearSaveText.y + clearSaveText.height);

		if (selection == 1 && changedSaveSlot)
		{
			changedSaveSlot = false;
			FlxG.resetState();
		}

		Save.data.settings.volume = Std.int(FlxMath.bound(Save.data.settings.volume, 0, 100));
		FlxG.sound.volume = Save.data.settings.volume / 100;

		volumeText.text = 'Volume: ${Save.data.settings.volume}%';
		volumeText.color = (selection == 2) ? FlxColor.YELLOW : FlxColor.WHITE;

		volumeText.setPosition(saveSlotText.x, saveSlotText.y + saveSlotText.height);
	}

	var changedSaveSlot:Bool = false;

	public function optionsEnter()
	{
		if (selection == 0)
		{
			Save.data = Save.getDefault();
			Save.save();

			FlxG.resetState();
		}
	}

	public function optionsLeft()
	{
		if (selection == 2)
			Save.data.settings.volume -= 10;
		if (selection == 1)
		{
			changedSaveSlot = true;
			Save.loadFromSlot(Save.data.slot - 1);
		}
	}

	public function optionsRight()
	{
		if (selection == 2)
			Save.data.settings.volume += 10;
		if (selection == 1)
		{
			changedSaveSlot = true;
			Save.loadFromSlot(Save.data.slot + 1);
		}
	}
}
