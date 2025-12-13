package backend.save;

typedef SaveData =
{
	version:String,
	slot:Null<Int>,

	?gameplay:
		{
			hasBegun:Null<Bool>,
			path:GameplayPaths
		}
}

