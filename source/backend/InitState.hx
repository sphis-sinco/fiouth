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

		FlxG.switchState(() -> new MainMenu());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
