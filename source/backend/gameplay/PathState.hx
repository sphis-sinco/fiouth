package backend.gameplay;

import backend.errors.Pettiness;
import backend.save.Save;

class PathState extends State
{
	override public function new(path:GameplayPaths)
	{
        super();

		if (path == null)
			throw new Pettiness('put in a gameplay path');

		Save.data.gameplay.path = path;
	}
}
