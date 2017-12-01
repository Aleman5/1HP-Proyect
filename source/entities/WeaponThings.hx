package entities;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Aleman5
 */
class WeaponThings extends FlxSprite 
{
	private var player:PlayerThings;
	private var howMuchInX:Float;

	public function new(?X:Float=0, ?Y:Float=0, _player:PlayerThings) 
	{
		super(X, Y);
		player = _player;
		if(player.whichPlayer == 1)
			loadGraphic(AssetPaths.weaponPlayer1__png, true, 24, 3);
		else
			loadGraphic(AssetPaths.weaponPlayer2__png, true, 24, 3);
		scale.set(2, 2);
		updateHitbox();
		height = 1;
		offset.y += 2;
		howMuchInX = offset.x;
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add("idle", [0, 1, 0, 1], 4);
		animation.add("death", [0]);
		animation.add("attacking", [2, 3, 3, 2], 8, false);
		animation.add("sprintattacking", [2, 3], 8, false);
		animation.play("idle");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		position();
		if (player.animation.name == "attack")
			animation.play("attacking");
		else if (player.animation.name == "sprintattack")
			animation.play("sprintattacking");
		else
			animation.play("idle");
		
		width = 30;
		offset.x = howMuchInX;
		switch (animation.curAnim.curIndex) 
		{
			case 0:
				y += 1;
				if (facing == FlxObject.LEFT)
					offset.x = 6;
			case 1:
				y += 2;
				if (facing == FlxObject.LEFT)
					offset.x = 6;
			case 2:
				if (facing == FlxObject.LEFT)
					offset.x = -3;
				width += 9;
			case 3:
				if (facing == FlxObject.LEFT)
					offset.x = -12;
				width += 18;
		}
	}
	function position() 
	{
		if (player.animation.name != "die")
		{
			facing = player.facing;
			y = player.y + player.height * 2 / 5;
			if (facing == FlxObject.RIGHT)
				x = player.x + player.width;
			else
				x = player.x - width;
			
			DwOrUp();
		}
		else
		{
			animation.play("death");
			acceleration.y = 250;
		}
	}
	function DwOrUp() 
	{
		
	}
}