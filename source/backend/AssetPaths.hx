package backend;

using StringTools;

class AssetPaths
{
	public static function assetsPath(path:String):String
	{
		if (!path.startsWith('assets/'))
			path = 'assets/$path';

		return path;
	}

	public static function soundPath(path:String):String return assetsPath('$path.wav');

	public static function soundsPath(path:String):String return soundPath('sounds/$path');
	public static function musicPath(path:String):String return soundPath('music/$path');
    
	public static function imagePath(path:String):String return assetsPath('images/$path.png');
    
	public static function dataPath(path:String):String return assetsPath('data/$path');
}
