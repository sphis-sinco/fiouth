package backend.save;

import backend.gameplay.GameplayPaths;

typedef SaveData =
{
	version:String,
	slot:Null<Int>,

	gameplay:
		{
			hasBegun:Null<Bool>,
			path:GameplayPaths
		},
	
	settings:
	{
		volume:Int
	}
}

