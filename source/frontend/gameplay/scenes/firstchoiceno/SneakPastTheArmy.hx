package frontend.gameplay.scenes.firstchoiceno;

import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.sound.FlxSound;
import frontend.objects.Overlay;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import backend.utils.Dialog;
import backend.Sprite;
import backend.gameplay.PathState;

using StringTools;

class SneakPastTheArmy extends PathState
{
	override public function new()
	{
		super(SNEAK_PAST_THE_ARMY);
	}

	override function get_finished():Bool
	{
		return true;
	}

	public var commander:Sprite;
	public var bluespike:Sprite;

	public var intro_dialog:Array<String>;

	public var ventOverlay:Overlay;

	override function create()
	{
		super.create();

		intro_dialog = Dialog.getLinesFromPathFolder('intro_dialog', path);

		commander = new Sprite(0, 0, -Std.int(Sprite.DEFAULT_SCALE / 2));
		commander.loadGraphicAndUpdateHitbox('characters/sprites/army/commander_left-angry'.imagePath());
		add(commander);

		commander.screenCenter();
		commander.x -= commander.width * 2;

		bluespike = new Sprite(0, 0, commander.scaleOffset);
		bluespike.loadGraphicAndUpdateHitbox('characters/sprites/army/bluespike-idle'.imagePath());
		add(bluespike);

		bluespike.screenCenter();

		bluespike.x += bluespike.width * 10;

		var time = 0;
		readDialogueList(intro_dialog);
		time = 2 * (intro_dialog.length);

		FlxTimer.wait(time, function()
		{
			var blk = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromString('0x17181F'));
			add(blk);
			blk.x = blk.width;
			blk.antialiasing = true;

			new FlxSound().loadStream('vent'.soundsPath()).play(false, 0);
			FlxTween.tween(blk, {x: 0}, 3, {
				onComplete: t ->
				{
					FlxG.switchState(() -> new PreventConfirmation());
				}
			});
			FlxTween.tween(ventOverlay, {x: -blk.width}, 3);
			FlxTween.tween(commander, {x: -blk.width + commander.x}, 3);
			FlxTween.tween(bluespike, {x: -blk.width + bluespike.x}, 3);
		});

		ventOverlay = new Overlay();
		ventOverlay.loadGraphicAndUpdateHitbox('overlays/vent'.imagePath());
		ventOverlay.resetScale();
		add(ventOverlay);

		members.remove(dialog);
		members.push(dialog);

		dialog.antialiasing = true; // the vent makes it harder to hear
		dialog.size = 8;
		dialogueFadeEndAlpha = .5;

		camFollow = new FlxObject();
		add(camFollow);
		camFollow.x = FlxG.width / 2;
		camFollow.y = FlxG.height / 2;

		FlxG.camera.follow(camFollow, LOCKON, 1);
	}

	var camFollow:FlxObject;

	override function eventFunction(events:Array<String>)
	{
		super.eventFunction(events);

		if (events.contains('commander_flip_direction'))
			commander.loadGraphicAndUpdateHitbox(commander.graphic.key.replace('_left', '_right'));

		if (events.contains('commander_idle'))
			commander.loadGraphicAndUpdateHitbox(commander.graphic.key.split('-')[0] + '-idle.png');

		if (events.contains('bluespike_move') || events.contains('bluespike_backup'))
		{
			var tick = 0;

			var newX = commander.x + bluespike.width * 6;

			if (events.contains('bluespike_backup'))
				newX = commander.x + bluespike.width * 10;

			FlxTween.tween(bluespike, {x: newX}, 2, {
				onUpdate: function(t:FlxTween)
				{
					tick++;

					if (tick % 10 == 0)
					{
						if (bluespike.graphic.key.endsWith('walk.png'))
							bluespike.loadGraphicAndUpdateHitbox('characters/sprites/army/bluespike-idle'.imagePath());
						else
							bluespike.loadGraphicAndUpdateHitbox('characters/sprites/army/bluespike-walk'.imagePath());
					}
				},
				onComplete: function(t:FlxTween)
				{
					bluespike.loadGraphicAndUpdateHitbox('characters/sprites/army/bluespike-idle'.imagePath());
				}
			});
		}
		if (events.contains('commander_move') || events.contains('commander_leave'))
		{
			var tick = 0;
			FlxTween.tween(commander,
				{x: events.contains('commander_leave') ? (commander.width * (FlxG.width / commander.width)) : commander.x + bluespike.width * 6},
				events.contains('commander_leave') ? 12 : 2, {
					onUpdate: function(t:FlxTween)
					{
						tick++;

						if (tick % 10 == 0)
						{
							if (commander.graphic.key.endsWith('walk.png'))
								commander.loadGraphicAndUpdateHitbox(commander.graphic.key.split('-')[0] + '-idle.png');
							else
								commander.loadGraphicAndUpdateHitbox(commander.graphic.key.split('-')[0] + '-walk.png');
						}
					},
					onComplete: function(t:FlxTween)
					{
						commander.loadGraphicAndUpdateHitbox(commander.graphic.key.split('-')[0] + '-idle.png');

						if (events.contains('commander_leave'))
							commander.visible = false;
					}
				});
		}
	}

	override function setDialogueTextNoFade(text:String)
	{
		super.setDialogueTextNoFade(text);

		dialog.y = 32;
	}

	override function playDialogueSound()
	{
		var dialogueSfx = new FlxSound().loadStream('dialogue_muted'.soundsPath());

		dialogueSfx.volume = 0.7;

		dialogueSfx.play(true);
	}
}
