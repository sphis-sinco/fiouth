package frontend.gameplay.scenes.firstchoice_yes;

import backend.MusicMan;
import backend.Sprite;
import backend.gameplay.PathState;

class MeetTheArmy extends PathState
{
	override public function new()
	{
		super(MEET_THE_ARMY);
	}

	public var bluespike:Sprite = new Sprite();
	public var commander:Sprite = new Sprite();
	public var emalf:Sprite = new Sprite();
	public var tistec:Sprite = new Sprite();

	override function create()
	{
		super.create();

		bluespike.loadGraphic('characters/portraits/army/bluespike'.imagePath());
		commander.loadGraphic('characters/portraits/army/commander'.imagePath());
		emalf.loadGraphic('characters/portraits/army/emalf'.imagePath());
		tistec.loadGraphic('characters/portraits/army/tistec'.imagePath());

		for (object in [bluespike, emalf, tistec, commander])
		{
			object.resetScale();

			object.scale.x -= 3;
			object.scale.y -= 3;
			object.updateHitbox();

			object.color = 0x4E4E4E;

			object.screenCenter();

			add(object);
		}

		MusicMan.playMusic('FormalGreeting');

		commander.color = 0xFFFFFF;
		commander.resetScale();
		commander.screenCenter();

		bluespike.x -= bluespike.width * 2;
		tistec.x += tistec.width * 2;
	}
}
