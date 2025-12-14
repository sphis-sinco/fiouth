package backend.save;

import flixel.math.FlxMath;
import flixel.util.FlxSave;
import haxe.macro.Compiler;
import lime.app.Application;

class Save
{
	public static var data:SaveData;

	public static var globalData:GlobalData;
	public static var globalSave:FlxSave;

	public static var currentSaveSlot(get, never):Dynamic;

	static function get_currentSaveSlot():Dynamic
	{
		return data?.slot ?? DEFAULT_SLOT;
	}

	public static function getDefault():SaveData
	{
		return {
			version: Application.current.meta.get('version'),
			slot: currentSaveSlot,

			gameplay: {
				hasBegun: false,
				path: START
			},

			settings: {
				volume: 100
			}
		}
	}

	public static var DEFAULT_SLOT:Dynamic = 1;

	public static function init()
	{
		globalSave = new FlxSave();
		globalSave.bind('slot_Global', SAVEPATH);
		globalSave.mergeDataFrom('Fiouth/Global', Application.current.meta.get('company'));
		globalData = globalSave.data;
		globalData.testingShit ??= {};

		// globalData.testingShit.path = 'end';

		trace('Loaded Global Data: ' + globalData);

		var lastValidSlot:Int = 0;
		var continueCheckingSlots = true;
		var saveObject = new FlxSave();
		while (continueCheckingSlots)
		{
			lastValidSlot++;
			saveObject.bind('slot$lastValidSlot', SAVEPATH);
			if ((saveObject.isEmpty() || saveObject.data.slot != lastValidSlot) || lastValidSlot > globalData.maxSlot)
			{
				continueCheckingSlots = false;
				globalData.maxSlot = lastValidSlot - 1;
				trace('globalData.maxSlot: ' + globalData.maxSlot);
			}
		}

		globalData.lastSlot = Std.int(FlxMath.bound(globalData.lastSlot, DEFAULT_SLOT, globalData?.maxSlot ?? FlxMath.MAX_VALUE_INT));

		if (Compiler.getDefine('SAVE_SLOT') != null && Compiler.getDefine('SAVE_SLOT') != "1")
			loadFromIntSlot(Std.parseInt(Compiler.getDefine('SAVE_SLOT').split("=")[0]));
		else
			loadFromIntSlot(globalData.lastSlot ?? DEFAULT_SLOT);
	}

	public static var SAVEPATH(get, never):String;

	static function get_SAVEPATH():String
		return Application.current.meta.get('company') + '/fiouth';

	public static function loadFromIntSlot(slot:Int = 1)
	{
		slot = Std.int(FlxMath.bound(slot, DEFAULT_SLOT, FlxMath.MAX_VALUE_INT));

		if (data != null)
		{
			globalData.lastSlot = currentSaveSlot;
			if (currentSaveSlot > globalData.maxSlot)
				globalData.maxSlot = currentSaveSlot;
		}

		loadFromSlot('slot$slot');
	}

	public static function loadFromSlot(slot:Dynamic)
	{
		var fakeendEasterEgg:Bool = false;
		var usedBackupParser:Bool = false;

		if (data != null)
		{
			if (slot == currentSaveSlot)
				return;

			globalData.lastDynamicSlot = data.slot;
		}

		FlxG.save.bind(slot, SAVEPATH, (s, exception) ->
		{
			usedBackupParser = true;

			trace('Backup Parsing (${exception.message})');
			trace('Save file data: ' + s);

			fakeendEasterEgg = (s == 'end');

			var backupData = getDefault();
			backupData.slot = slot;
			return backupData;
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

		if (!usedBackupParser)
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
		globalData.lastVersion = data?.version;
		data.version = getDefault().version;

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

		if (data.settings == null)
		{
			trace('Missing settings field');
			data.settings = getDefault().settings;
		}
		else
		{
			if (data.settings.volume == null)
				data.settings.volume = getDefault().settings.volume;
		}
	}

	public static function save()
	{
		globalSave.mergeData(globalData, true);
		globalSave.flush();

		if (data != null && FlxG.save.data != null)
			FlxG.save.mergeData(data, true);
		FlxG.save.flush();

		trace('Saved Global Data : ' + globalSave.data);
		trace('Saved Save Data : ' + data);
		trace('Saved Slot: ' + currentSaveSlot);
	}
}
