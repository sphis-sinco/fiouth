package backend.gameplay;

import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import backend.utils.TextTags;
import flixel.sound.FlxSound;
#if !debug
import backend.state.State;
#else
import backend.state.DebugState as State;
#end
import backend.errors.Pettiness;
import backend.save.Save;

using StringTools;

class PathState extends State
{
	public var path:GameplayPaths;
	public var pathWasAlreadySet:Bool = false;
	public var finished(get, never):Bool;

	function get_finished():Bool
		return false;

	public var dialog:FlxText;

	public function setDialogueText(text:String, ?speed:Float = 1, ?formatTag:String)
	{
		FlxTween.cancelTweensOf(dialog);
		FlxTween.tween(dialog, {alpha: 0}, speed / 2, {
			ease: FlxEase.sineInOut,
			onComplete: t ->
			{
				setDialogueTextNoFade(((formatTag != null) ? '<$formatTag>' : '') + text + ((formatTag != null) ? '<$formatTag>' : ''));

				FlxTween.tween(dialog, {alpha: 1}, speed / 2, {
					ease: FlxEase.sineInOut
				});
			}
		});
	}

	public function setDialogueTextNoFade(text:String)
	{
		dialog.text = text;

		if (text.trim().length > 0 && text.trim() != null && text.trim() != '')
		{
			playDialogueSound();
			TextTags.apply(dialog);
		}

		dialog.screenCenter(X);
	}

	public function playDialogueSound()
	{
		new FlxSound().loadStream('dialogue'.soundsPath()).play(true);
	}

	public function eventFunction(events:Array<String>)
	{
		for (event in events)
		{
			event = event.trim();

			if (event == '')
				events.remove(event);
		}

		trace(events);

		if (dialog != null)
		{
			if (events.contains('hide_dialog'))
				dialog.alpha = 0;
			if (events.contains('fade_dialog_out'))
			{
				if (events.indexOf('fade_dialog_out_speed') > -1)
					FlxTween.tween(dialog, {alpha: 0}, Std.parseFloat(events[events.indexOf('fade_dialog_out_speed') + 1] ?? '1.0'));
				else
					FlxTween.tween(dialog, {alpha: 0}, 1.0);
			}
		}
	}

	public function readDialogueList(list:Array<String>, additional_time:Int = 2, starting_time:Int = 0, dialogue_speed:Int = 1)
	{
		var time = starting_time;
		for (dialog in list)
		{
			dialog = dialog.trim();

			FlxTimer.wait(time, function()
			{
				if (dialog.startsWith('<event>') && dialog.endsWith('<event>'))
					eventFunction(dialog.split('<event>'));
				else
					setDialogueText(dialog, dialogue_speed);
			});
			time += additional_time;
		}
	}

	override public function new(path:GameplayPaths)
	{
		super();

		if (path == null)
		{
			#if ENABLE_PETTINESS
			throw new Pettiness('put in a gameplay path');
			#end
		}
		else
		{
			if (Save.data.gameplay.path != path)
			{
				Save.data.gameplay.path = path;
				newSetPath();
			}
			else
			{
				pathWasAlreadySet = true;
				alreadySetPath();
			}
		}

		this.path = path;
	}

	override function create()
	{
		super.create();

		dialog = new FlxText();
		dialog.size = 32;
		dialog.screenCenter();
		add(dialog);
		dialog.alpha = 0;
	}

	public function newSetPath() {}

	public function alreadySetPath() {}
}
