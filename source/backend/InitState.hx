package backend;

import backend.save.Save;
import frontend.menus.MainMenu;

class InitState extends State
{
	override public function create()
	{
		super.create();

		Save.init();

		FlxG.switchState(() -> new MainMenu());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
