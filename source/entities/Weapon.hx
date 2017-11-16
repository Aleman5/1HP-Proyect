package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Aleman5
 */
class Weapon extends FlxSprite 
{
	private var player:Player;

	public function new(?X:Float=0, ?Y:Float=0, _player:Player) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.weaponPlayer1__png, true, 21, 3);
		animation.add("idle", [0]);
		animation.add("attacking", [1, 2, 2, 1], 6, false);
		animation.play("idle");
		
		player = _player;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
	}
}