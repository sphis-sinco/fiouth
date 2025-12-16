package frontend.objects;

import backend.Sprite;

class Overlay extends Sprite
{
	override function resetScale()
	{
		var combinedScale = Sprite.DEFAULT_SCALE + scaleOffset;

		scale.set((FlxG.width / combinedScale), (FlxG.height / combinedScale));
		updateHitbox();
	}
}
