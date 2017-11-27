package entities;

import entities.PlayerThings.States;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;

/**
 * ...
 * @author Aleman5
 */
enum FlagStates { IDLE; STOLED; ONFLOOR; }
 
class ThisIsAFlag extends FlxSprite 
{
	private var currentFlagState:FlagStates;
	private var defenderPlayer:PlayerThings;
	private var attackerPlayer:PlayerThings;
	private var stoled:Bool;
	private var grabed:Bool;
	private var oX:Float;
	private var oY:Float;

	public function new(?X:Float=0, ?Y:Float=0, _player1:PlayerThings, _player2:PlayerThings) 
	{
		super(X, Y);
		currentFlagState = FlagStates.IDLE;
		defenderPlayer = _player1;
		attackerPlayer = _player2;
		stoled = false;
		grabed = false;
		oX = X;
		oY = Y;
		
		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		
		loadGraphic(AssetPaths.flags__png, true, 15, 22);
		width = 4;
		animation.add("p1", [0]);
		animation.add("p2", [1]);
		if		(defenderPlayer.whichPlayer == 1) 	animation.play("p1");
		else if (defenderPlayer.whichPlayer == 2) 	animation.play("p2");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		flagStateMachine();
	}
	function flagStateMachine() 
	{
		switch (currentFlagState) 
		{
			case FlagStates.IDLE:
				if (y != oY)
					y = oY;
				if (x != oX)
					x = oX;
				velocity.x = 0;
				if (facing != FlxObject.RIGHT)
					facing = FlxObject.RIGHT;
				if (FlxG.collide(this, attackerPlayer))
				{
					grabed = true;
					currentFlagState = FlagStates.STOLED;
				}
				
			case FlagStates.STOLED:
				facing = attackerPlayer.facing;
				if (facing == FlxObject.RIGHT)
				{
					x = attackerPlayer.x - 3;
					y = attackerPlayer.y - 3;
				}
				else
				{
					x = attackerPlayer.x + attackerPlayer.width - 1;
					y = attackerPlayer.y - 3;
				}
				if (attackerPlayer.currentState == States.DIE)
					currentFlagState = FlagStates.ONFLOOR;
				
			case FlagStates.ONFLOOR:
				if (y != oY)
					y = oY;
				velocity.x = 0;
				if (attackerPlayer.currentState != States.DIE && FlxG.collide(this, attackerPlayer))
					currentFlagState = FlagStates.STOLED;
				if (defenderPlayer.currentState != States.DIE && FlxG.collide(this, defenderPlayer))
					currentFlagState = FlagStates.IDLE;
		}
	}
}