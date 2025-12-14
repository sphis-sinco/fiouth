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
			finalPathNoLang += 'assets/';
			if (Language.LANGUAGE != Language.DEFAULT_LANGUAGE)
				finalPath += 'langs/${Language.LANGUAGE}/';

			finalPath += path;
			finalPathNoLang += path;
		}
		else
		{
			var paths = path.split('/');
			var pathsLang = path.split('/');

			if (Language.LANGUAGE != Language.DEFAULT_LANGUAGE)
				pathsLang.insert(1, 'langs/${Language.LANGUAGE}/');

			for (p in pathsLang)
				finalPath += p;
			for (p in paths)
				finalPathNoLang += p;
		}

		// trace(finalPath);
		// trace(finalPathNoLang);

		if (!Assets.exists(finalPath))
			if (Assets.exists(finalPathNoLang))
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
}
