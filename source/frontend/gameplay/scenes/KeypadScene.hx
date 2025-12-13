package frontend.gameplay.scenes;

import frontend.menus.MainMenu;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import backend.Sprite;
import backend.gameplay.PathState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import frontend.objects.ui.Directional;

class KeypadScene extends PathState
{
	public var keycard:Sprite;
	public var keypad:Sprite;

	public var scene:Int = 1;

	public var left:Directional = new Directional(LEFT);
	public var right:Directional = new Directional(RIGHT);

	public var hasKeycard:Bool = false;

	override public function new()
	{
		super(KEYPAD_SCENE);
	}

	override function create()
	{
		super.create();

		keycard = new Sprite();
		keycard.loadGraphic('objects/keycard'.imagePath());
		keypad = new Sprite();
		keypad.loadGraphic('objects/keypad'.imagePath());

		keycard.resetScale();
		keypad.resetScale();

		add(keycard);
		add(keypad);

		keypad.screenCenter();
		keycard.screenCenter();

		left.alpha = 0;
		right.alpha = 0;

		FlxTween.tween(left, {alpha: 1}, 3, {
			ease: FlxEase.sineInOut
		});

		FlxTween.tween(right, {alpha: 1}, 3, {
			ease: FlxEase.sineInOut
		});

		left.screenCenter(Y);
		right.screenCenter(Y);

		left.x = 0;
		right.x = FlxG.width - (right.width);

		add(left);
		add(right);

		left.justReleased = () ->
		{
			if (canSelect)
			scene--;
			if (scene < 0)
				scene = 0;
		}

		right.justReleased = () ->
		{
			if (canSelect)
				scene++;
			if (scene > 2)
				scene = 2;
		}
	}

	public var canSelect:Bool = true;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		left.visible = scene > 0 && canSelect;
		right.visible = scene < 2 && canSelect;

		keycard.visible = hasKeycard && canSelect;
		keypad.visible = false;

		if (scene == 0)
		{
			keypad.visible = true;

			if (FlxG.mouse.overlaps(keypad) && FlxG.mouse.justReleased)
			{
				FlxG.sound.play('keypad_${(hasKeycard) ? 'accepted' : 'denied'}'.soundsPath());
				keypad.loadGraphic('objects/keypad-${(hasKeycard) ? 'accepted' : 'denied'}'.imagePath());

				FlxTimer.wait(.5, () ->
				{
					keypad.loadGraphic('objects/keypad'.imagePath());

					if (hasKeycard)
					{
						hasKeycard = !hasKeycard;
						FlxG.sound.play('transportation'.soundsPath());
						FlxTimer.wait(3.65, () ->
						{
							canSelect = false;

							keypad.visible = false;
							keycard.visible = false;

							version.visible = false;
							FlxG.camera.flash(FlxColor.WHITE, 3, () -> FlxG.switchState(() -> new MainMenu()));
							FlxG.sound.music.fadeOut(3, 0);
						});
					}
				});
			}
		}
		if (scene == 2)
		{
			if (!hasKeycard)
			{
				keycard.visible = true;

				if (FlxG.mouse.overlaps(keycard) && FlxG.mouse.justReleased)
				{
					hasKeycard = !hasKeycard;
					keycard.screenCenter();
					keycard.y = FlxG.height - (keycard.height * 2);
				}
			}
		}
	}
}
