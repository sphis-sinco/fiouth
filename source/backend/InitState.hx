package backend;

import backend.plugins.CursorController;
import frontend.debug.Preloading;
import lime.utils.Assets;
import backend.state.State;
import backend.gameplay.PathState;
import haxe.macro.Compiler;
import lime.app.Application;
import backend.save.Save;
import frontend.menus.MainMenu;
import frontend.debug.PathSelect;

class InitState extends State
{
	public static var startingState:String = '';

	override public function create()
	{
		super.create();
		trace(watermark.text);

		Save.init();
		Application.current.onExit.add(l -> Save.save());

		flixelSetup();

		if (Compiler.getDefine('STARTING_STATE') != null && Compiler.getDefine('STARTING_STATE') != '1')
			startingState = Compiler.getDefine('STARTING_STATE').split('=')[0];
		startingState = startingState.toLowerCase();

		switch (startingState.toLowerCase())
		{
			case 'path-select':
				Save.loadFromSlot('debug');
				FlxG.switchState(() -> new PathSelect());

			case 'preloading':
				Save.loadFromSlot('debug');
				FlxG.switchState(() -> new Preloading());

			default:
				FlxG.switchState(() -> new MainMenu());
		}
	}

	function flixelSetup()
	{
		FlxG.sound.muteKeys = [];
		FlxG.sound.volumeUpKeys = [];
		FlxG.sound.volumeUpKeys = [];
		FlxG.sound.soundTrayEnabled = false;

		// FlxG.debugger.toggleKeys = [];
		FlxG.debugger.visibilityChanged.add(() ->
		{
			if (!FlxG.debugger.visible)
			{
				if (Std.isOfType(FlxG.state, State))
				{
					var stateState:State = cast FlxG.state;
					stateState.turnOffCursor();
				}
			}
		});

		flixelSignals();
		flixelPlugins();
	}

	function flixelPlugins()
	{
		FlxG.plugins.addPlugin(new CursorController());
	}

	function flixelSignals()
	{
		if (Compiler.getDefine('PATH_IN_TITLE') == '1')
			FlxG.signals.preStateCreate.add(_state ->
			{
				Application.current.window.title = 'Fiouth';

				if (Std.isOfType(_state, PathState))
				{
					var pathState:PathState = cast _state;

					Application.current.window.title = 'Fiouth | ${pathState.path}';
				}
			});

		FlxG.signals.postUpdate.add(() ->
		{
			if (Std.isOfType(FlxG.state, PathState))
			{
				var pathState:PathState = cast FlxG.state;

				if (!pathState.finished && FlxG.keys.justReleased.ESCAPE)
					FlxG.switchState(() -> new MainMenu());
			}
		});
	}
}
