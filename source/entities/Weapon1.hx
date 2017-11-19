package entities;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Weapon1 extends WeaponThings 
{

	public function new(?X:Float=0, ?Y:Float=0, _player:PlayerThings) 
	{
		super(X, Y, _player);
		
	}
	override function DwOrUp() 
	{
		if (FlxG.keys.pressed.S && !FlxG.keys.pressed.W)
			y += 4;
		else if (FlxG.keys.pressed.W && !FlxG.keys.pressed.S)
			y -= 4;
	}
}