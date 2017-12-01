package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class SomeoneWon extends FlxSprite 
{
	private var who:Int;

	public function new(?X:Float=0, ?Y:Float=0, _who:Int) 
	{
		super(X, Y);
		who = _who;
		if (who == 1)
			loadGraphic(AssetPaths.bluemanWins__png);
		else if (who == 2)
			loadGraphic(AssetPaths.orangemanWins__png);
	}
	
}