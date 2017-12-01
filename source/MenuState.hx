package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;

/**
 * ...
 * @author Aleman5
 */
class MenuState extends FlxState 
{
	private var btnGame:FlxButton;
	private var title:FlxSprite;
	private var tweenazo:FlxTween;

	override public function create():Void
	{
		btnGame = new FlxButton(camera.width / 2 , camera.height / 2, "PLAY", startGame);
		btnGame.x -= btnGame.width / 2;
		title = new FlxSprite(camera.width / 2, camera.height / 4, AssetPaths.title__png);
		title.x -= title.width / 2;
		title.antialiasing = true;
		tweenazo = FlxTween.color(title, 3, FlxColor.BLUE, FlxColor.ORANGE, {type: FlxTween.PINGPONG});
		
		add(btnGame);
		add(title);
	}
	function startGame() 
	{
		var playState = new PlayState();
		FlxG.switchState(playState);
	}
}