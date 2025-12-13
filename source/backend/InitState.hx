package backend;

import frontend.menus.MainMenu;

class InitState extends State
{
	override public function create()
	{
		super.create();

		FlxG.switchState(() -> new MainMenu());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
