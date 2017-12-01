package entities;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Aleman5
 */
class GoGo extends FlxSprite 
{
	private var who:Int;
	private var p:PlayerThings;
	private var point:FlxObject;

	public function new(?X:Float=0, ?Y:Float=0, _who:Int, _p:PlayerThings, _point:FlxObject) 
	{
		super(X, Y);
		scale.set(2.5, 2.5);
		who = _who;
		p = _p;
		point = _point;
		
		if (who == 1)
			loadGraphic(AssetPaths.bluemanGo__png, true, 30, 30);
		else if (who == 2)
			loadGraphic(AssetPaths.orangemanGo__png, true, 30, 30);
		
		animation.add("1", [0]);
		animation.add("2", [1]);
		animation.play("1");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (who == 1)
		{
			if (p.get_theFlag())
			{
				animation.play("2");
				if (canIMove())
					x = point.x - camera.width / 2 + 25;
			}
			else
			{
				animation.play("1");
				if (canIMove())
					x = point.x + camera.width / 2 - 100;
			}
		}
		else if (who == 2)
		{
			if (p.get_theFlag())
			{
				animation.play("2");
				if (canIMove())
					x = point.x + camera.width / 2 - 100;
			}
			else
			{
				animation.play("1");
				if (canIMove())
					x = point.x - camera.width / 2 + 25;
			}
		}
	}
	function canIMove():Bool
	{
		var move:Bool = true;
		
		if (point.x - camera.width / 2 < 0 || point.x + camera.width / 2 > FlxG.worldBounds.width)
			move = false;
		
		return move;
	}
}