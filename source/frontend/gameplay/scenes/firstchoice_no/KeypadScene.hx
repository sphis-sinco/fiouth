package frontend.gameplay.scenes.firstchoice_no;

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
	public var confirmOrDenyKeypad:Sprite;
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
		confirmOrDenyKeypad = new Sprite();
		confirmOrDenyKeypad.loadGraphic('objects/keypad-${(hasKeycard) ? 'accepted' : 'denied'}'.imagePath());
		confirmOrDenyKeypad.resetScale();
		keycard.resetScale();
		keypad.resetScale();
		add(keycard);
		add(keypad);
		add(confirmOrDenyKeypad);
		keypad.screenCenter();
		keycard.screenCenter();
		confirmOrDenyKeypad.screenCenter();
		left.alpha = 0;
		right.alpha = 0;
		FlxTween.tween(left, {alpha: 1}, 3, {ease: FlxEase.sineInOut});
		FlxTween.tween(right, {alpha: 1}, 3, {ease: FlxEase.sineInOut});
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
		enableCursor = true;
	}

	public var canSelect:Bool = true;
	public var displayRegularKeypad:Bool = true;
	public var displayConfirmDenyKeypad:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		left.visible = scene > 0 && canSelect;
		right.visible = scene < 2 && canSelect;
		keycard.visible = hasKeycard && canSelect;
		keypad.visible = (scene == 0) && displayRegularKeypad;
		confirmOrDenyKeypad.visible = (scene == 0) && displayConfirmDenyKeypad;
		if (scene == 0)
		{
			FlxG.watch.addQuick('canSelect', canSelect);
			FlxG.watch.addQuick('FlxG.mouse.overlaps(keypad)', FlxG.mouse.overlaps(keypad));
			FlxG.watch.addQuick('FlxG.mouse.justReleased', FlxG.mouse.justReleased);
			if (canSelect && FlxG.mouse.overlaps(keypad) && FlxG.mouse.justReleased)
			{
				FlxG.sound.play('keypad_${(hasKeycard) ? 'accepted' : 'denied'}'.soundsPath());
				displayRegularKeypad = false;
				displayConfirmDenyKeypad = true;
				confirmOrDenyKeypad.loadGraphic('objects/keypad-${(hasKeycard) ? 'accepted' : 'denied'}'.imagePath());
				confirmOrDenyKeypad.resetScale();
				FlxTimer.wait(.5, () ->
				{
					displayRegularKeypad = true;
					displayConfirmDenyKeypad = false;
					if (hasKeycard)
					{
						enableCursor = false;
						keycard.visible = false;
						canSelect = false;
						hasKeycard = !hasKeycard;
						FlxG.sound.play('transportation'.soundsPath());
						FlxTimer.wait(3.65, () ->
						{
							displayRegularKeypad = false;
							keypad.visible = false;
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
