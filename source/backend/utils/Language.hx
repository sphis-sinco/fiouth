package backend.utils;

import lime.utils.Assets;

class Language
{
	public static var DEFAULT_LANGUAGE(get, never):String;

	static function get_DEFAULT_LANGUAGE():String
		return LANGUAGES[0] ?? 'en-us';

	public static var LANGUAGE:String = DEFAULT_LANGUAGE+'_';

	public static var LANGUAGES(get, never):Array<String>;

	static function get_LANGUAGES():Array<String>
	{
		try
		{
			return Assets.getText('assets/data/languages.txt').split('\n');
		}
		catch (e)
		{
			return ['en-us'];
		}
	}
}
