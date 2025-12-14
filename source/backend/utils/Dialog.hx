package backend.utils;

import lime.utils.Assets;

class Dialog
{
	public static function getLines(filename:String):Array<String>
	{
		return Assets.getText('dialogs/$filename.txt'.dataPath()).split('\n');
	}
}
