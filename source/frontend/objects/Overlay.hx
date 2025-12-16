package frontend.objects;

import backend.Sprite;

class Overlay extends Sprite
{
	override public function new(?x:Float, ?y:Float, ?scaleOffset:Int = 0)
	{
		super(x, y, scaleOffset);

		antialiasing = true;
	}

	override function resetScale()
	{
		var combinedScale = 1 + scaleOffset;

		scale.set((FlxG.width / (this.width * combinedScale)), (FlxG.height / (this.height * combinedScale)));
		updateHitbox();
	}
}
