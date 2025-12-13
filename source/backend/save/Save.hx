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

	public static function loadFromSlot(slot:Int = 1)
	{
		FlxG.save.bind('Fiouth/Slot$slot', Application.current.meta.get('company'));

		switch (FlxG.save.status)
		{
			case EMPTY:
				trace('Empty Save');
				data = getDefault();
			default:
				data = FlxG.save.data;
		}
	}

	public static function getDefault():RawSaveData
	{
		return {
			version: Application.current.meta.get('version'),
			slot: 1
		}
	}

	public static function init()
    {
        loadFromSlot(1);
    }
}
