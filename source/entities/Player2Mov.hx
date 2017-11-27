package entities;
import entities.PlayerThings.States;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Player2Mov extends PlayerThings 
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
		
		if (FlxG.keys.pressed.RIGHT)
		{
			facing = FlxObject.RIGHT;
			if (!isChasing)
			{
				if (trails.alive)
					trails.kill();
				velocity.x = speed;
			}
			else
			{
				if (!trails.alive)
					trails.reset(x, y);
				velocity.x = speedChasing;
			}
		}
		else if (FlxG.keys.pressed.LEFT)
		{
			facing = FlxObject.LEFT;
			if (!isChasing)
			{
				if (trails.alive)
					trails.kill();
				velocity.x = -speed;
			}
			else
			{
				if (!trails.alive)
					trails.reset(x, y);
				velocity.x = -speedChasing;
			}
		}
	}
	override function jumping() 
	{
		if (FlxG.keys.justPressed.NUMPADONE)
		{
			velocity.y = -600;
			currentState = States.JUMP;
		}
	}
	override function attacking() 
	{
		if (FlxG.keys.justPressed.NUMPADTWO)
			currentState = States.ATTACK;
	}
}