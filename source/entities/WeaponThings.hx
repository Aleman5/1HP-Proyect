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

	public function new(?X:Float=0, ?Y:Float=0, _player:PlayerThings) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.weaponPlayer1__png, true, 24, 3);
		scale.set(2, 2);
		updateHitbox();
		player = _player;
		
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add("idle", [0, 1, 0, 1], 4);
		animation.add("attacking", [2, 3, 3, 2], 8, false);
		animation.play("idle");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		position();
		if (player.animation.name == "attack")
			animation.play("attacking");
		else
			animation.play("idle");
			
		if (animation.name == "idle")
			switch (animation.curAnim.curFrame) 
			{
				case 1:
					y += 1;
				case 2:
					y += 2;
			}
	}
	function position() 
	{
		facing = player.facing;
		if (facing == FlxObject.RIGHT)
		{
			x = player.x + player.width * 3 / 5;
			y = player.y + player.height * 2 / 5;
		}
		else
		{
			x = player.x + player.width * 3 / 5 - width;
			y = player.y + player.height * 2 / 5;
		}
		DwOrUp();
	}
	function DwOrUp() 
	{
		
	}
}