package backend;

import flixel.sound.FlxSoundGroup;
import flixel.sound.FlxSound;

class MusicMan
{
	public static function playMusic(track:String, ?volume:Float = 1, ?group:FlxSoundGroup, ?onMusicPlay:Void->Void) @:privateAccess
	{
		var intro:FlxSound = new FlxSound().loadStream((track + '-intro').musicPath());
		var loop:FlxSound = new FlxSound().loadStream((track + '-loop').musicPath());

		var general:FlxSound = new FlxSound().loadStream(track.musicPath());

		if (intro == null && loop == null && general == null)
			return;

		var playTracks:Void->Void = function()
		{
			if (general == null && loop != null)
				FlxG.sound.playMusic(loop._sound, volume, false, group);
			else
				FlxG.sound.playMusic(general._sound, volume, false, group);

            if (onMusicPlay != null)
                onMusicPlay();
		};

		if (intro != null)
			FlxG.sound.play(intro._sound, volume, false, group, false, playTracks);
		else
            playTracks();

	}
}
