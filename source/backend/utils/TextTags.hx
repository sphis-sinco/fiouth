package backend.utils;

import flixel.text.FlxText;

class TextTags
{
	public static function apply(flxtext:FlxText)
	{
		var markups = [
			new FlxTextFormatMarkerPair(new FlxTextFormat(0xFF2222), "<red>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0xFF7722), "<orange>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0xFFFF22), "<yellow>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0x22FF22), "<green>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0x2222FF), "<blue>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0x7722FF), "<purple>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0xFF22FF), "<pink>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0x884422), "<brown>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0x999999), "<gray>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0x999999), "<grey>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0xCCCCCC), "<white>"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0x222222), "<black>"),

			new FlxTextFormatMarkerPair(new FlxTextFormat(0x22FFFF), "<cyan>"),

		];

		flxtext.applyMarkup(flxtext.text, markups);
	}
}
