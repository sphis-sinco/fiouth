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
		FlxG.debugger.visibilityChanged.add(() -> {
			if (!FlxG.debugger.visible)
			{
				if (Std.isOfType(FlxG.state, State))
				{
					var stateState:State = cast FlxG.state;
					stateState.turnOffCursor();
				}
			}
		});

		FlxG.switchState(() -> new MainMenu());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
