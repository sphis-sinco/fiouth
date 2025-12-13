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

	public var clearSaveText:FlxText = new FlxText(64, 64, 0, '', 32);
	public var saveSlotText:FlxText = new FlxText(64, 64, 0, '', 32);

	public var volumeText:FlxText = new FlxText(64, 64, 0, '', 32);

	override function create()
	{
		super.create();

		selection = _selection;

		add(clearSaveText);
		add(saveSlotText);

		add(volumeText);

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

		saveSlotText.text = 'Save Slot: ${Save.currentSaveSlot}';
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
			if (Save.currentSaveSlot - 1 < Save.DEFAULT_SLOT)
			{
				if (FlxG.keys.pressed.SHIFT)
					Save.loadFromSlot(Save.globalData.maxSlot);
			}
			else
				Save.loadFromSlot(Save.currentSaveSlot - 1);
		}
	}

	public function optionsRight()
	{
		if (selection == 2)
			Save.data.settings.volume += 10;
		if (selection == 1)
		{
			changedSaveSlot = true;
			if ((Save.currentSaveSlot + 1 > Save.globalData.maxSlot) && !FlxG.keys.pressed.SHIFT)
				Save.loadFromSlot(Save.DEFAULT_SLOT);
			else
				Save.loadFromSlot(Save.currentSaveSlot + 1);
		}
	}
}
