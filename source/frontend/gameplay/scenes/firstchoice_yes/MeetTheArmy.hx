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

			object.screenCenter();

			add(object);
		}

		MusicMan.playMusic('FormalGreeting');

		commander.scale.x += 2;
		commander.scale.y += 2;
		commander.updateHitbox();

		object.screenCenter();
	}
}
