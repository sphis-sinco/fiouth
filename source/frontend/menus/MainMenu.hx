package frontend.menus;

import backend.utils.Dialog;
import frontend.debug.PathSelect;
import backend.InitState;
import backend.utils.MusicMan;
import frontend.gameplay.FindPath;
import backend.save.Save;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import backend.state.State;

class MainMenu extends State
{
	public var title:FlxText;

	public var playText:FlxText;
	public var optionsText:FlxText;

	public var selection:Int = 0;

	override public function new()
	{
		super();
	}

	override public function create()
	{
		super.create();

		if (InitState.startingState == 'path-select')
			FlxG.switchState(() -> new PathSelect());

		title = new FlxText();
		title.text = Dialog.getLine('mainmenu/title');
		title.size = 128;

		title.screenCenter();
		title.y -= title.height * 1;

		add(title);

		playText = new FlxText();

		playText.size = 24;
		playText.text = Dialog.getLine('mainmenu/play');
		if (Save.data.gameplay.hasBegun)
			playText.text = Dialog.getLine('mainmenu/continue');

		#if debug playText.text += " [" + Save.data.gameplay.path + "]"; #end

		add(playText);

		optionsText = new FlxText();

		optionsText.size = 24;
		optionsText.text = Dialog.getLine('mainmenu/options');

		add(optionsText);

		playText.screenCenter();
		playText.y += playText.height * 2;

		optionsText.screenCenter(X);
		optionsText.y = playText.y + playText.height * 2;

		updateOptionTexts();

		if (!FlxG.sound.music?.playing)
		{
			MusicMan.playMusic('hello', 1, null, () ->
			{
				FlxG.sound.music?.fadeIn(3, 0, 1);
			});

			var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			add(blk);
			FlxTween.tween(blk, {alpha: 0}, 3);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustReleased([UP, W, DOWN, S, ENTER]))
		{
			if (FlxG.keys.anyJustReleased([UP, W]))
				selection--;
			if (FlxG.keys.anyJustReleased([DOWN, S]))
				selection++;

			if (selection < 0)
				selection = 0;
			if (selection > 1)
				selection = 1;

			updateOptionTexts();

			if (FlxG.keys.anyJustReleased([ENTER]))
			{
				switch (selection)
				{
					case 0:
						var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
						add(blk);
						blk.alpha = 0;
						FlxTween.tween(blk, {alpha: 1}, 3);

						FlxG.sound.music?.fadeOut(3, 0, t ->
						{
							FlxG.sound.music?.stop();
							FlxG.switchState(() -> FindPath.sendToStateBasedOnGameplayPath(Save.data.gameplay.path));
						});
					case 1:
						FlxG.switchState(() -> new SettingsMenu());
				}
			}
		}
	}

	public function updateOptionTexts()
	{
		playText.color = (selection == 0) ? FlxColor.YELLOW : FlxColor.WHITE;
		optionsText.color = (selection == 1) ? FlxColor.YELLOW : FlxColor.WHITE;
	}
}
