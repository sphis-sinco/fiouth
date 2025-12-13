package dev.scripts;

import sys.io.File;
import haxe.xml.Access;

class MakeVersionTag
{
	static var runCmds:Bool = true;

	public static function main()
	{
		#if DONT_RUN_CMDS
		runCmds = false;
		#end

		trace('runCmds: ' + runCmds);

		var projXML:Access = new Access(Xml.parse(File.getContent('../../Project.xml')).firstElement());
		var version:String = null;

		if (projXML == null)
			throw 'No project XML';

		for (element in projXML.elements)
			if (element.name == 'app' && element.has.version)
				version = element.att.version;

		if (version == null)
			throw 'Null version';
		trace('version: ' + version);

		if (runCmds)
		{
			Sys.command('git tag $version');
			Sys.command('git push origin --tags');
		}
		else
		{
			Sys.println('git tag $version');
			Sys.println('git push origin --tags');
		}
	}
}
