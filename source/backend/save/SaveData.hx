package backend.save;

import backend.gameplay.GameplayPaths;

typedef SaveData =
{
	version:String,
	slot:Dynamic,

	gameplay:
	{
		hasBegun:Null<Bool>, path:GameplayPaths
	},

	settings:
	{
		volume:Null<Int>
	}
}
