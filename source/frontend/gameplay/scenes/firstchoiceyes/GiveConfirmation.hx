package frontend.gameplay.scenes.firstchoiceyes;

import backend.Sprite;
import backend.gameplay.PathState;

class GiveConfirmation extends PathState
{
	override public function new()
	{
		super(GIVE_CONFIRMATION);
	}

	public var confirm:Sprite;
	public var deny:Sprite;

	override function create()
	{
		super.create();

		confirm = new Sprite();
		confirm.loadGraphic('objects/confirmationButton/confirm'.imagePath());
		add(confirm);

		deny = new Sprite();
		deny.loadGraphic('objects/confirmationButton/deny'.imagePath());
		add(deny);

		confirm.screenCenter();
		confirm.x -= confirm.width;
		
		deny.screenCenter();
		deny.x += deny.width;
	}
}
