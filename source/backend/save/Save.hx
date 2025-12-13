package backend.save;

import flixel.util.FlxSave;
import haxe.macro.Compiler;
import lime.app.Application;

class Save
{
	public static var data:SaveData;

	public static var globalData:GlobalData;
	public static var globalSave:FlxSave;

	public static var currentSaveSlot(get, never):Int;

	static function get_currentSaveSlot():Int
	{
		return data?.slot ?? 0;
	}

	public static function getDefault():SaveData
	{
		return {
			version: Application.current.meta.get('version'),
			slot: DEFAULT_SAVE,

			gameplay: {
				hasBegun: false,
				path: START
			}
		}
	}

	public static var DEFAULT_SAVE:Int = 1;

	public static function init()
	{
		var defaultSave = new FlxSave();
		defaultSave.bind('Fiouth/Default', Application.current.meta.get('company'));
		defaultSave.mergeData(getDefault(), true);
		defaultSave.flush();

		globalSave = new FlxSave();
		globalSave.bind('Fiouth/Global', Application.current.meta.get('company'));
		globalData = globalSave.data;
		globalData.testingShit ??= {};
		globalData.testingShit.path = 'end';
		trace('Loaded Global Data: ' + globalData);

		if (Compiler.getDefine('SAVE_SLOT') != null && Compiler.getDefine('SAVE_SLOT') != "1")
			loadFromSlot(Std.parseInt(Compiler.getDefine('SAVE_SLOT').split("=")[0]));
		else
			loadFromSlot(globalData.lastSlot ?? DEFAULT_SAVE);
	}

	public static function loadFromSlot(slot:Int = 1)
	{
		var fakeendEasterEgg:Bool = false;

		FlxG.save.bind('Fiouth/Slot$slot', Application.current.meta.get('company'), (s, exception) ->
		{
			trace('Backup Parsing (${exception.message})');
			trace('Save file data: ' + s);

			fakeendEasterEgg = (s == 'end');

			return getDefault();
		});

		switch (FlxG.save.status)
		{
			case EMPTY:
				trace('Empty Save');
				data = getDefault();
			case LOAD_ERROR(_):
				data = getDefault();
			// loadFromSlot(slot + 1);
			default:
				trace('Status : ' + FlxG.save.status);
				data = FlxG.save.data;
		}

		trace('Loaded Save Data : ' + data);

		if (data == null)
			data = getDefault();

		if (data?.slot == null)
		{
			trace('Missing slot field');
			data.slot = slot;
		}
		performSaveChecks();

		if (fakeendEasterEgg)
			data.gameplay.path = FAKE_END;

		save();
	}

	public static function performSaveChecks()
	{
		if (data.version == null)
		{
			trace('Missing version field');
			data.version = getDefault().version;
		}
		else
		{
			globalData.lastVersion = data.version;
			data.version = getDefault().version;
		}

		if (data.gameplay == null)
		{
			trace('Missing gameplay field');
			data.gameplay = getDefault().gameplay;
		}
		else
		{
			if (data.gameplay.hasBegun == null)
				data.gameplay.hasBegun = getDefault().gameplay.hasBegun;
			if (data.gameplay.path == null)
				data.gameplay.path = getDefault().gameplay.path;
		}
	}

	public static function save()
	{
		globalData.lastSlot = data.slot;

		globalSave.mergeData(globalData, true);
		globalSave.flush();

		if (data != null && FlxG.save.data != null)
			FlxG.save.mergeData(data, true);
		FlxG.save.flush();

		trace('Saved Global Data : ' + globalSave.data);
		trace('Saved Save Data : ' + data);
		trace('Saved');
	}
}
