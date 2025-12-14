package backend.utils;

import backend.gameplay.GameplayPaths;
import lime.utils.Assets;

class Dialog
{
	public static function getLines(filename:String):Array<String>
	{
		return Assets.getText('dialogs/$filename.txt'.dataPath()).split('\n');
	}

	public static function getLinesFromPathFolder(filename:String, path:GameplayPaths):Array<String>
	{
		return getLines(path + '/' + filename);
	}

	public static function getLine(filename:String):String
	{
		return Assets.getText('dialogs/$filename.txt'.dataPath());
	}

	public static function getLineFromPathFolder(filename:String, path:GameplayPaths):String
	{
		return getLine(path + '/' + filename);
	}
}
