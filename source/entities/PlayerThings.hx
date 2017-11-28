package entities;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.addons.effects.FlxTrail;

/**
 * ...
 * @author Aleman5
 */
enum States{ IDLE; ATTACK; SPRINTATTACK; RUN; JUMP; DIE; SWDCONTACT; }
class PlayerThings extends FlxSprite 
{
	public var currentState:States;
	public var whichPlayer:Int;
	private var timeToRevive:Int;
	private var speed:Float;
	private var speedChasing:Float;
	public var isChasing(default, set):Bool;
	public var trails(default, set):FlxTrail;
	private var touchingFloorTimer:Int; // Used in States.SPRINTATTACK
	@:isVar public var theFlag(get, set):Bool;
	
	public function new(?X:Float=0, ?Y:Float=0, _whichPlayer:Int) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.player1__png, true, 11, 19);
		scale.set(2, 2);
		updateHitbox();
		width = 6;
		offset.x += 8;
		acceleration.y = 2000;
		currentState = States.IDLE;
		whichPlayer = _whichPlayer;
		timeToRevive = 0;
		speed = 130;
		speedChasing = 165;
		isChasing = false;
		touchingFloorTimer = 0;
		theFlag = false;
		trails = new FlxTrail(this, null, 6, 6);
		trails.kill();
		FlxG.state.add(trails);
		
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		
		animation.add("idle", [0, 1, 2, 3], 6);
		animation.add("attack", [4, 5, 5, 4], 8, false);
		
		animation.add("presprintattack", [12]);
		animation.add("goingupsprintattack", [13]);
		animation.add("idlesprintattack", [14]);
		animation.add("goingdownsprintattack", [15]);
		animation.add("onfloorsprintattack", [18]);
		
		animation.add("run", [6, 7, 8, 9, 10], 10);
		animation.add("jump", [16, 17], 15);
		animation.add("die", [18, 19, 20, 21], 8, false);
		animation.play("idle");
	}
	override public function update(elapsed:Float):Void 
	{
		stateMachine();
		super.update(elapsed);
	}
	function stateMachine()
	{
		switch (currentState) 
		{
			case States.IDLE:
				animation.play("idle");
				moving();
				jumping();
				attacking();
				if (velocity.x != 0) currentState = States.RUN;
				
			case States.RUN:
				animation.play("run");
				moving();
				jumping();
				attacking();
				sprintAttacking();
				if (velocity.x == 0) currentState = States.IDLE;
				
			case States.JUMP:
				animation.play("jump");
				moving();
				sprintAttacking();
				if (isTouching(FlxObject.FLOOR)) currentState = States.IDLE;
				
			case States.ATTACK:
				velocity.x = 0;
				if (animation.name != "attack")
					animation.play("attack");
				if (animation.name == "attack" && animation.finished)
					currentState = States.IDLE;
					
			case States.SPRINTATTACK:
				switch (animation.name) 
				{
					case "presprintattack":
						velocity.y = -175;
						if (!isTouching(FlxObject.FLOOR))
							animation.play("goingupsprintattack");
						
					case "goingupsprintattack":
						if (velocity.y > -20)
							animation.play("idlesprintattack");
						if (isTouching(FlxObject.FLOOR))
							animation.play("onfloorsprintattack");
						
					case "idlesprintattack":
						if (velocity.y > 20)
							animation.play("goingdownsprintattack");
						if (isTouching(FlxObject.FLOOR))
							animation.play("onfloorsprintattack");
						
					case "goingdownsprintattack":
						if (isTouching(FlxObject.FLOOR))
							animation.play("onfloorsprintattack");
						
					case "onfloorsprintattack":
						touchingFloorTimer++;
						velocity.x *= 0.7;
						if (touchingFloorTimer > 15)
						{
							touchingFloorTimer = 0;
							currentState = States.IDLE;
						}
				}
				
			case States.DIE:
				if (animation.name != "die")
					animation.play("die");
				velocity.set(0, 0);
				timeToRevive++;
				if (timeToRevive > 50)
					plsRevive();
				
			case States.SWDCONTACT:
				velocity.x *= 0.9;
				if (velocity.x > -15 && velocity.x < 15)
					currentState = States.IDLE;
				
		}
	}
	override public function reset(X:Float, Y:Float):Void 
	{
		acceleration.y = 2000;
		currentState = States.IDLE;
		timeToRevive = 0;
		trails.reset(x, y);
		trails.kill();
		super.reset(X, Y);
	}
	function attacking() 		{ }
	function sprintAttacking()  { }
	function jumping()   		{ }
	function moving()	 		{ }
	function plsRevive() 		{ }
	
	public function set_trails(value:FlxTrail):FlxTrail 
	{
		return trails = value;
	}
	public function set_isChasing(value:Bool):Bool 
	{
		return isChasing = value;
	}
	public function set_theFlag(?value:Bool = true):Bool 
	{
		return theFlag = value;
	}
	public function get_theFlag():Bool
	{
		return theFlag;
	}
}
