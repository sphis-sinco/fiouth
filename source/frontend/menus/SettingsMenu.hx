package frontend.menus;

import lime.utils.Assets;
import backend.utils.Language;
import backend.utils.Dialog;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import backend.save.Save;
import flixel.text.FlxText;
import backend.state.State;

using StringTools;

class SettingsMenu extends State
{
	private static var _selection:Int = 0;

	public var selection:Int = 0;

	public var clearSaveText:FlxText = new FlxText(64, 64, 0, '', 32);
	public var saveSlotText:FlxText = new FlxText(64, 64, 0, '', 32);

	public var volumeText:FlxText = new FlxText(64, 64, 0, '', 32);

	public var languageText:FlxText = new FlxText(64, 64, 0, '', 32);

	override function create()
	{
		super.create();

		selection = _selection;

		add(clearSaveText);
		add(saveSlotText);

		add(volumeText);

		add(languageText);

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

			if (selection == 1)
			{
				if (FlxG.keys.anyJustReleased([UP, W]))
					selection--;
				if (FlxG.keys.anyJustReleased([DOWN, S]))
					selection++;
			}

			if (selection < 0)
				selection = 0;
			if (selection > 3)
				selection = 3;
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
		setSettingInfo(clearSaveText, 'clearsave', 0);

		setSettingInfo(saveSlotText, 'saveslot', 1, Save.currentSaveSlot, text ->
		{
			text.setPosition(clearSaveText.x, clearSaveText.y + clearSaveText.height);

			if (selection == 1 && changedSaveSlot)
			{
				changedSaveSlot = false;
				FlxG.resetState();
			}
		});

		setSettingInfo(volumeText, 'volume', 2, Save.data.settings.volume, text ->
		{
			Save.data.settings.volume = Std.int(FlxMath.bound(Save.data.settings.volume, 0, 100));
			FlxG.sound.volume = Save.data.settings.volume / 100;
			text.setPosition(saveSlotText.x, saveSlotText.y + saveSlotText.height);
		});

		setSettingInfo(languageText, 'language', 3, Save.data.settings.language, text ->
		{
			Language.LANGUAGE = Save.data.settings.language;
			text.setPosition(volumeText.x, volumeText.y + volumeText.height);
		});
	}

	public function setSettingInfo(settingText:FlxText, setting:String, selectionID:Int, ?value:Dynamic, ?additionalStuff:FlxText->Void)
	{
		if (additionalStuff != null)
			additionalStuff(settingText);

		settingText.text = Dialog.getLineFromPrefixPath('settings/$setting', 'menus/');
		settingText.color = (selection == selectionID) ? FlxColor.YELLOW : FlxColor.WHITE;

		settingText.text = settingText.text.replace('<$1>', Std.string(value));
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
		if (selection == 1 && Std.isOfType(Save.currentSaveSlot, Int))
		{
			changedSaveSlot = true;
			if (Save.currentSaveSlot - 1 < Save.DEFAULT_SLOT)
			{
				if (FlxG.keys.pressed.SHIFT)
					Save.loadFromIntSlot(Save.globalData.maxSlot);
			}
			else
				Save.loadFromIntSlot(Std.int(Save.currentSaveSlot) - 1);
		}
		if (selection == 3)
			if (!(Language.LANGUAGES.indexOf(Save.data.settings.language) - 1 < 0))
				Save.data.settings.language = Language.LANGUAGES[Language.LANGUAGES.indexOf(Save.data.settings.language) - 1];
	}

	public function optionsRight()
	{
		if (selection == 2)
			Save.data.settings.volume += 10;
		if (selection == 1 && Std.isOfType(Save.currentSaveSlot, Int))
		{
			changedSaveSlot = true;
			if ((Save.currentSaveSlot + 1 > Save.globalData.maxSlot) && !FlxG.keys.pressed.SHIFT)
				Save.loadFromIntSlot(Save.DEFAULT_SLOT);
			else
				Save.loadFromIntSlot(Std.int(Save.currentSaveSlot) + 1);
		}
		if (selection == 3)
			if (Language.LANGUAGES.indexOf(Save.data.settings.language) + 1 < Language.LANGUAGES.length)
				Save.data.settings.language = Language.LANGUAGES[Language.LANGUAGES.indexOf(Save.data.settings.language) + 1];
	}
}
