package backend.save;

import haxe.macro.Compiler;
import lime.app.Application;

class Save
{
	public static var data:RawSaveData;

	public static var currentSaveSlot(get, never):Int;

	static function get_currentSaveSlot():Int
	{
		return data?.slot ?? 0;
	}

	public static function getDefault():RawSaveData
	{
		return {
			version: Application.current.meta.get('version'),
			slot: DEFAULT_SAVE
		}
	}

	public static function save()
	{
		FlxG.save.mergeData(data, true);
		FlxG.save.flush();

		trace('Saved');
	}

	public static var DEFAULT_SAVE:Int = 1;

	public static function init()
	{
		if (Compiler.getDefine('SAVE_SLOT') != null && Compiler.getDefine('SAVE_SLOT') != "1")
			loadFromSlot(Std.parseInt(Compiler.getDefine('SAVE_SLOT').split("=")[0]));
		else
			loadFromSlot(DEFAULT_SAVE);
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
	}
}
