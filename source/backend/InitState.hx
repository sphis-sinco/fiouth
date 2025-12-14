package backend;

import lime.app.Application;
import backend.save.Save;
import frontend.menus.MainMenu;

class InitState extends State
{
	override public function create()
	{
		super.create();
		trace(version.text);

		Save.init();
		Application.current.onExit.add(l -> Save.save());

		FlxG.sound.muteKeys = [];
		FlxG.sound.volumeUpKeys = [];
		FlxG.sound.volumeUpKeys = [];
		FlxG.sound.soundTrayEnabled = false;

		// FlxG.debugger.toggleKeys = [];
		FlxG.debugger.visibilityChanged.add(() ->
		{
			if (!FlxG.debugger.visible)
			{
				if (Std.isOfType(FlxG.state, State))
				{
					var stateState:State = cast FlxG.state;
					stateState.turnOffCursor();
				}
			}
		});

		var startingState:String = '';
		if (Compiler.getDefine('STARTING_STATE') != null && Compiler.getDefine('STARTING_STATE') != "1")
			startingState = Compiler.getDefine('STARTING_STATE').split("=")[0];

		switch (startingState.toLowerCase())
		{
			case 'path-select':
				Save.loadFromSlot('slot_pathSelect');
				FlxG.switchState(() -> new MainMenu());

			default:
				FlxG.switchState(() -> new MainMenu());
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
