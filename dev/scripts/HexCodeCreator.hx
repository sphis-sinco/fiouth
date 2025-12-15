package dev.scripts;

import sys.FileSystem;
import sys.io.File;

using StringTools;

class HexCodeCreator
{
	public static function main()
	{
		var letters:Array<String> = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'];

		var l1:String = letters[0];
		var l2:String = letters[0];
		var l3:String = letters[0];
		var l4:String = letters[0];
		var l5:String = letters[0];
		var l6:String = letters[0];
		var l7:String = letters[0];
		var l8:String = letters[0];

		var generatedHex = function()
		{
			return '0x$l1$l2$l3$l4$l5$l6$l7$l8';
		}

		var listOfHexCodes:String = '';

		if (FileSystem.exists('listOfHexCodes.txt'))
		{
            trace('existing list');
			listOfHexCodes = File.getContent('listOfHexCodes.txt');
		}
		var startTime:Float = Date.now().getTime();

		while (generatedHex() != '0xFFFFFFFF')
		{
			if (letters[letters.indexOf(l8) + 1] == null)
			{
				l8 = letters[0];
				if (letters[letters.indexOf(l7) + 1] == null)
				{
					l7 = letters[0];
					if (letters[letters.indexOf(l6) + 1] == null)
					{
						l6 = letters[0];
						if (letters[letters.indexOf(l5) + 1] == null)
						{
							l5 = letters[0];
							if (letters[letters.indexOf(l4) + 1] == null)
							{
								l4 = letters[0];
								if (letters[letters.indexOf(l3) + 1] == null)
								{
									l3 = letters[0];
									if (letters[letters.indexOf(l2) + 1] == null)
									{
										l2 = letters[0];
										if (letters[letters.indexOf(l1) + 1] == null)
										{
											l1 = letters[0];
										}
										else
											l1 = letters[letters.indexOf(l1) + 1];
									}
									else
										l2 = letters[letters.indexOf(l2) + 1];
								}
								else
									l3 = letters[letters.indexOf(l3) + 1];
							}
							else
								l4 = letters[letters.indexOf(l4) + 1];
						}
						else
							l5 = letters[letters.indexOf(l5) + 1];
					}
					else
						l6 = letters[letters.indexOf(l6) + 1];
				}
				else
					l7 = letters[letters.indexOf(l7) + 1];
			}
			else
				l8 = letters[letters.indexOf(l8) + 1];

			var createdLine = 'new FlxTextFormatMarkerPair(new FlxTextFormat(' + generatedHex() + '), "<' + generatedHex() + '>"),' + '\n';
			if (!listOfHexCodes.contains(createdLine))
			{
				listOfHexCodes += createdLine;
				File.saveContent('listOfHexCodes.txt', listOfHexCodes);
				Sys.println(generatedHex() + ' (${listOfHexCodes.split('\n').length})');
			}
		}
		// listOfHexCodes.push(generatedHex());

		trace('Time Taken: ' + (((Date.now().getTime() - startTime) / 1000) / 60) + 'm');
	}
}
