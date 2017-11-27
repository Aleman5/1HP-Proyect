package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

/**
 * ...
 * @author Aleman5
 */
/*typedef EaseInfo =
{
	name:String,
	ease:EaseFunction
}*/
class MenuState extends FlxState 
{
	//private var _easeInfo:Array<EaseInfo>;
	
	private var btnGame:FlxButton;
	private var title:FlxSprite;
	private var tweenazo:FlxTween;
	//private var _currentEase(get, never):EaseFunction;

	override public function create():Void
	{
		//var ping:TweenOptions = { type: FlxTween.PINGPONG, ease: _currentEase };
		
		btnGame = new FlxButton(camera.width / 2 , camera.height / 2, "PLAY", startGame);
		btnGame.x -= btnGame.width / 2;
		title = new FlxSprite(camera.width / 4, camera.height / 4, AssetPaths.title__png);
		title.antialiasing = true;
		tweenazo = FlxTween.color(title, 1, 0x3a74f7FF, 0xf06b00FF);
		
		add(btnGame);
		add(title);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		
	}
	function startGame() 
	{
		var playState = new PlayState();
		FlxG.switchState(playState);
	}
	/*private inline function get__currentEase():EaseFunction
	{
		return _easeInfo[_currentEaseIndex].ease;
	}*/
}