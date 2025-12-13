package backend.save;

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
			slot: 1
		}
	}

	public static function save()
	{
		FlxG.save.mergeData(data, true);
		FlxG.save.flush();

		trace('Saved');
	}

	public static function init()
	{
		loadFromSlot(1);
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
		performNullChecksOnSave();

		trace('Save : ' + data);
		save();
	}

	public static function performNullChecksOnSave()
	{
		if (data.version == null)
		{
			trace('Missing version field');
			data.version = getDefault().version;
		}
	}
}
