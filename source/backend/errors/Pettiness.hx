package backend.errors;

import haxe.PosInfos;
import haxe.exceptions.PosException;

class Pettiness extends PosException
{
	override public function new(message:String, ?pos:PosInfos)
	{
		super(message, null, pos);
	}

	override function toString():String
	{
		return 'Pettiness (${posInfos.fileName}:${posInfos.lineNumber}): $message';
	}
}
