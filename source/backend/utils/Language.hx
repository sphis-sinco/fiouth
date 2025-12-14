package backend.utils;

import lime.utils.Assets;

class Language
{
	public static var DEFAULT_LANGUAGE(get, never):String;

	static function get_DEFAULT_LANGUAGE():String
		return LANGUAGES[0] ?? 'en_us';

	public static var LANGUAGE:String = DEFAULT_LANGUAGE;
    
	public static var LANGUAGES(get, never):Array<String>;

	static function get_LANGUAGES():Array<String>
	{
		var langs:Array<String> = [];

		try
		{
			langs = Assets.getText('assets/data/languages.txt').split('\n');
		}
		catch (e)
		{
			trace(e.message);
		}

		if (langs.length < 1)
			langs.push('en_us');

		// trace(langs);
		return langs;
	}
}
