package backend.gameplay;

import backend.errors.Pettiness;
import backend.save.Save;

class PathState extends State
{
	public var pathWasAlreadySet:Bool = false;

	override public function new(path:GameplayPaths)
	{
		super();

		if (path == null)
			throw new Pettiness('put in a gameplay path');

		if (Save.data.gameplay.path != path)
		{
			Save.data.gameplay.path = path;
			newSetPath();
		}
		else
		{
			pathWasAlreadySet = true;
			alreadySetPath();
		}
	}

	public function newSetPath() {}

	public function alreadySetPath() {}
}
