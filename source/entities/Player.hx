package entities;

import flixel.addons.util.FlxFSM;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

/**
 * ...
 * @author Aleman5
 */
class Player extends FlxSprite 
{
	private var emitter:FlxEmitter;
	private var p:FlxParticle;
	//private var states:FlxFSM;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.player1__png, true, 11, 19);
		animation.add("idle", [0, 1, 2, 3], 6);
		animation.play("idle");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		
	}
	
}
