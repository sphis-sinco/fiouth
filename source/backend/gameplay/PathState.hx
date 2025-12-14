package backend.gameplay;

import backend.state.State;
import backend.state.DebugState;
import backend.errors.Pettiness;
import backend.save.Save;

#if !debug
class PathState extends State
#else
class PathState extends DebugState
#end
{
	public var path:GameplayPaths;
	public var pathWasAlreadySet:Bool = false;
	public var finished(get, never):Bool;
	function get_finished():Bool
		return false;
	override
	public function new(path:GameplayPaths)
	{
		super();

		if (path == null)
		{
			#if ENABLE_PETTINESS
			throw new Pettiness('put in a gameplay path');
			#end
		}
		else
		{
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

		this.path = path;
	}
	public function newSetPath() {}
	public function alreadySetPath() {}
}
