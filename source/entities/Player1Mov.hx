package entities;
import entities.PlayerThings.States;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Player1Mov extends PlayerThings 
{

	public function new(?X:Float=0, ?Y:Float=0, _whichPlayer:Int) 
	{
		super(X, Y, _whichPlayer);
		
	}
	override function moving() 
	{
		if(velocity.x > 15 || velocity.x < -15)
			velocity.x *= 0.85;
		else
			velocity.x = 0;
		
		if (FlxG.keys.pressed.D)
		{
			facing = FlxObject.RIGHT;
			velocity.x = 130;
		}
		else if (FlxG.keys.pressed.A)
		{
			facing = FlxObject.LEFT;
			velocity.x = -130;
		}
	}
	override function jumping() 
	{
		if (FlxG.keys.justPressed.V)
		{
			velocity.y = -600;
			currentState = States.JUMP;
		}
	}
	override function attacking() 
	{
		if (FlxG.keys.justPressed.B)
			currentState = States.ATTACK;
	}
}