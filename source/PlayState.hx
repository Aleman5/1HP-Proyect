package;

import entities.Player;
import entities.Weapon;
import flixel.FlxState;

class PlayState extends FlxState
{
	private var player:Player;
	private var weapon:Weapon;
	
	override public function create():Void
	{
		super.create();
		player = new Player(camera.width / 2, camera.height / 2);
		weapon = new Weapon(player.x + player.width / 2, player.y + 6, player);
		add(player);
		add(weapon);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}