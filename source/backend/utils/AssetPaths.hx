package backend.utils;

import lime.utils.Assets;

using StringTools;

class AssetPaths
{
	public static function assetsPath(path:String):String
	{
		var finalPath:String = '';
		var finalPathNoLang:String = '';

		if (!path.startsWith('assets/'))
		{
			finalPath += 'assets/';
			finalPath += 'langs/${Language.LANGUAGE}/';
			finalPath += path;

			finalPathNoLang += 'assets/';
			finalPathNoLang += path;
		}
		else
		{
			var paths = path.split('/');
			var pathsLang = path.split('/');
			pathsLang.insert(1, 'langs/${Language.LANGUAGE}/');

			for (p in pathsLang)
				finalPath += p;
			for (p in paths)
				finalPathNoLang += p;
		}

		#if gimmePaths
		trace('finalPath: ' + finalPath);
		trace('finalPathNoLang: ' + finalPathNoLang);
		#end

		if (!exists(finalPath))
				return finalPathNoLang;
		return finalPath;
	}

	public static function soundPath(path:String):String
		return assetsPath('$path.wav');

	public static function soundsPath(path:String):String
		return soundPath('sounds/$path');

	public static function musicPath(path:String):String
		return soundPath('music/$path');

	public static function imagePath(path:String):String
		return assetsPath('images/$path.png');

	public static function dataPath(path:String):String
		return assetsPath('data/$path');

	public static function exists(path:String):Bool
	{
		#if sys
		return sys.FileSystem.exists(path);
		#end

		return Assets.exists(path) && Assets.getText(path) != null;
	}
}
