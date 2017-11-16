package;

import entities.Player;
import flixel.FlxState;

class PlayState extends FlxState
{
	private var player:Player;
	
	override public function create():Void
	{
		super.create();
		player = new Player(camera.width / 2, camera.height / 2);
		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}