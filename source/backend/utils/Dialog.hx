package backend.utils;

import backend.gameplay.GameplayPaths;
import lime.utils.Assets;

class Dialog
{
	public static function getLines(filename:String):Array<String>
	{
		var path = 'dialogs/$filename.txt'.dataPath();

		if (!Assets.exists(path))
		{
			trace('Non-existant path: ' + path);
			return ['N / A'];
		}

		return Assets.getText(path).split('\n');
	}

	public static function getLinesFromPathFolder(filename:String, path:GameplayPaths):Array<String>
	{
		return getLines(path + '/' + filename);
	}

	public static function getLine(filename:String):String
	{
		return getLines(filename)[0];
	}

	public static function getLineFromPathFolder(filename:String, path:GameplayPaths):String
	{
		return getLine(path + '/' + filename);
	}
}
