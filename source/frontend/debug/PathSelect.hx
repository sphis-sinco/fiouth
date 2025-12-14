package frontend.debug;

import backend.gameplay.PathState;
import frontend.gameplay.FindPath;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import backend.utils.Sorts;
import backend.gameplay.GameplayPaths;
import backend.state.DebugState;
import frontend.menus.SettingsMenu;

class PathSelect extends DebugState
{
	public var paths:Array<GameplayPaths> = [
		START,
		FIRST_CHOICE,
		MEET_THE_ARMY,
		MEET_THE_ARMY_INTERACTIVE,
		GIVE_CONFIRMATION,
		KEYPAD_SCENE,
		SNEAK_PAST_THE_ARMY,
		PREVENT_CONFIRMATION,
		BETRAYAL_PATH_INTRO,
		LOYALTY_PATH_INTRO,
		ENDING_REMEMBERANCE,
		ENDING_ONE_WHO_TRIED,
		FAKE_END
	];

	public var pathSelections:FlxTypedGroup<FlxText>;

	public var camFollow:FlxObject;

	var selected:Int = 0;

	override function create()
	{
		super.create();

		FlxG.sound.music.stop();

		paths.sort(Sorts.pathsFinishState);

		pathSelections = new FlxTypedGroup<FlxText>();
		add(pathSelections);

		var i = 0;
		for (path in paths)
		{
			var sel:FlxText = new FlxText();
			sel.size = 16;

			sel.text = path;

			var pathClass:PathState = cast FindPath.getStateBasedOnGameplayPath(path);

			if (pathClass.path == new PathState(null).path)
				sel.text += ' (NULL)';
			else
			{
				if (!pathClass.finished)
					sel.text += ' (UNFINISHED)';
			}
			
			sel.ID = i;
			sel.alignment = CENTER;
			sel.fieldWidth = FlxG.width;
			sel.x = -(FlxG.width / 2);

			pathSelections.add(sel);
			i++;
		}

		camFollow = new FlxObject();
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.5);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ESCAPE)
			FlxG.switchState(() -> new SettingsMenu());

		if (FlxG.keys.anyJustReleased([UP, W, DOWN, S, ENTER]))
		{
			if (FlxG.keys.anyJustReleased([UP, W]))
				selected--;
			if (FlxG.keys.anyJustReleased([DOWN, S]))
				selected++;

			if (selected < 0)
				selected = 0;
			if (selected >= pathSelections.members.length)
				selected = pathSelections.members.length - 1;

			if (FlxG.keys.anyJustReleased([ENTER]))
				FlxG.switchState(() -> FindPath.sendToStateBasedOnGameplayPath(paths[selected]));
		}

		for (sel in pathSelections.members)
		{
			sel.color = FlxColor.WHITE;
			if (sel.ID > 0)
				sel.y = pathSelections.members[sel.ID - 1].y + pathSelections.members[sel.ID - 1].height + 16;
			if (sel.ID == selected)
			{
				sel.color = FlxColor.YELLOW;

				camFollow.y = sel.y;
			}
		}
	}
}
