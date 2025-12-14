package backend.utils;

import backend.gameplay.GameplayPaths;
import lime.utils.Assets;

class Dialog
{
	public static function getLinesFromPrefixPath(filename:String, ?prefix:String = ''):Array<String>
	{
		var path = '$prefix$filename.txt'.dataPath();

		if (!Assets.exists(path))
		{
			trace('Non-existant path: ' + path);
			return ['N / A'];
		}

		return Assets.getText(path).split('\n');
	}

	public static function getLines(filename:String):Array<String>
		return getLinesFromPrefixPath(filename, 'dialogs/');

	public static function getLinesFromPathFolder(filename:String, path:GameplayPaths):Array<String>
		return getLines(path + '/' + filename);

	public static function getLine(filename:String):String
		return getLines(filename)[0];

	public static function getLineFromPathFolder(filename:String, path:GameplayPaths):String
		return getLine(path + '/' + filename);

	public static function getLinesFromPathFolderFromPrefixPath(filename:String, path:GameplayPaths, ?prefix:String = ''):Array<String>
		return getLinesFromPrefixPath(path + '/' + filename, prefix);

	public static function getLineFromPrefixPath(filename:String, ?prefix:String = ''):String
		return getLinesFromPrefixPath(filename, prefix)[0];

	public static function getLineFromPathFolderFromPrefixPath(filename:String, path:GameplayPaths, ?prefix:String = ''):String
		return getLineFromPrefixPath(path + '/' + filename, prefix);
}
