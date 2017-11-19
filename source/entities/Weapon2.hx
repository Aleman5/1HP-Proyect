package entities;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Weapon2 extends WeaponThings 
{

	public function new(?X:Float=0, ?Y:Float=0, _player:PlayerThings) 
	{
		super(X, Y, _player);
		
	}
	override function DwOrUp() 
	{
		if (FlxG.keys.pressed.DOWN && !FlxG.keys.pressed.UP)
			y += 4;
		else if (FlxG.keys.pressed.UP && !FlxG.keys.pressed.DOWN)
			y -= 4;
	}
}