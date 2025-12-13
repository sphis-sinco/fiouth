package backend;

import lime.utils.Assets;
import flixel.sound.FlxSoundGroup;
import flixel.sound.FlxSound;

class MusicMan
{
	public static function playMusic(track:String, ?volume:Float = 1, ?group:FlxSoundGroup, ?onMusicPlay:Void->Void,
			?onIntroPlay:FlxSound->Void) @:privateAccess
	{
		var intro = (track + '-intro').musicPath();
		var loop = (track + '-loop').musicPath();

		var general = track.musicPath();

		var oneToPlay = '';

		if (!Assets.exists(intro))
			intro = null;
		if (!Assets.exists(general))
			general = null;
		if (!Assets.exists(loop))
			loop = null;

		if (intro == null && general == null && loop == null)
			return;

		var playTracks:Void->Void = function()
		{
			if (general == null && loop != null)
				oneToPlay = loop;
			else
				oneToPlay = general;

			trace('playing : ' + oneToPlay);
			FlxG.sound.playMusic(oneToPlay, volume, true, group);

			if (onMusicPlay != null)
				onMusicPlay();
		};

		if (intro != null)
		{
			trace('playing (intro) : ' + intro);
			var sound = FlxG.sound.play(intro, volume, false, group, false, playTracks);

			if (onIntroPlay != null)
				onIntroPlay(sound);
		}
		else
			playTracks();
	}
}
