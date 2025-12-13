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

	public static function save()
	{
		FlxG.save.mergeData(data, true);
		FlxG.save.flush();

		globalData.lastSlot = data.slot;

		globalSave.mergeData(globalData, true);
		globalSave.flush();

		trace('Saved');
	}

	public static var DEFAULT_SAVE:Int = 1;

	public static function init()
	{
		globalSave = new FlxSave();
		globalSave.bind('Fiouth/Global', Application.current.meta.get('company'));
		globalData = globalSave.data;
		trace('Global : ' + globalData);

		if (Compiler.getDefine('SAVE_SLOT') != null && Compiler.getDefine('SAVE_SLOT') != "1")
			loadFromSlot(Std.parseInt(Compiler.getDefine('SAVE_SLOT').split("=")[0]));
		else
			loadFromSlot(globalData.lastSlot ?? DEFAULT_SAVE);
	}

	public static function loadFromSlot(slot:Int = 1)
	{
		FlxG.save.bind('Fiouth/Slot$slot', Application.current.meta.get('company'));

		switch (FlxG.save.status)
		{
			case EMPTY:
				trace('Empty Save');
				data = getDefault();
			default:
				trace('Status : ' + FlxG.save.status);
				data = FlxG.save.data;
		}

		if (data.slot == null)
		{
			trace('Missing slot field');
			data.slot = slot;
		}
		performSaveChecks();

		trace('Save : ' + data);
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
}
