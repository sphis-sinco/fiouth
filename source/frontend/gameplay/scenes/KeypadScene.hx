package frontend.gameplay.scenes;

import backend.gameplay.PathState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import frontend.objects.ui.Directional;
import flixel.FlxSprite;
import backend.State;

class KeypadScene extends PathState
{
	public var keycard:FlxSprite;
	public var keypad:FlxSprite;

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

		keycard = new FlxSprite().loadGraphic('objects/keycard'.imagePath());
		keypad = new FlxSprite().loadGraphic('objects/keypad'.imagePath());

		add(keycard);
		add(keypad);

		keypad.screenCenter();
		keycard.screenCenter();

		keycard.alpha = 0;
		keypad.alpha = 0;

		FlxTween.tween(keycard, {alpha: 1}, 3, {
			ease: FlxEase.sineInOut
		});

		FlxTween.tween(keypad, {alpha: 1}, 3, {
			ease: FlxEase.sineInOut
		});

		left.screenCenter(Y);
		right.screenCenter(Y);

		left.x = left.width * 2;
		right.x = FlxG.width - (right.width * 2);

		left.justReleased = () ->
		{
			scene--;
			if (scene < 0)
				scene = 0;
		}

		right.justReleased = () ->
		{
			scene++;
			if (scene > 2)
				scene = 2;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		left.visible = scene > 0;
		right.visible = scene < 2;

		keycard.visible = hasKeycard;
		keypad.visible = false;

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
