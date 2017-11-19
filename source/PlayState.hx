package;

import entities.Player1Mov;
import entities.Player2Mov;
import entities.PlayerThings;
import entities.Weapon1;
import entities.Weapon2;
import entities.WeaponThings;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;


class PlayState extends FlxState
{
	private var player1:Player1Mov;
	private var player2:Player2Mov;
	private var players:FlxTypedGroup<PlayerThings>;
	private var weapon1:Weapon1;
	private var weapon2:Weapon2;
	private var paused:Bool;
	
	private var loader:FlxOgmoLoader;
	private var tilemap:FlxTilemap;
	private var background:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		FlxG.worldBounds.set(0, 0, 3200, 480);
		players = new FlxTypedGroup();
		player1 = new Player1Mov(1550, camera.height / 2, 1);
		player2 = new Player2Mov(1650, camera.height / 2, 2);
		players.add(player1);
		players.add(player2);
		weapon1 = new Weapon1(player1.x + player1.width / 2, player1.y + 6, player1);
		weapon2 = new Weapon2(player2.x + player2.width / 2, player2.y + 6, player2);
		paused = false;
		
		loader = new FlxOgmoLoader(AssetPaths.level__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 32, "map");
		background = new FlxSprite(200, 0, AssetPaths.backGround__png);
		background.scrollFactor.set(.5, 0);
		
		tilemap.setTileProperties(0, FlxObject.NONE);
		for (i in 1...3) 
			tilemap.setTileProperties(i, FlxObject.ANY);
		add(background);
		add(tilemap);
		add(players);
		add(weapon1);
		add(weapon2);
		
		camera.follow(player1);
		camera.followLerp = 2;
		camera.setScrollBounds(0, 3200, 0, 480);
		camera.pixelPerfectRender = false;
	}
	override public function update(elapsed:Float):Void
	{
		if(!paused)
			super.update(elapsed);
		collisions();
		resetAndPause();
	}
	function resetAndPause() 
	{
		if (FlxG.keys.justPressed.P)
			paused = !paused;
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();
	}
	function collisions() 
	{
		FlxG.collide(players, tilemap);
		if (FlxG.pixelPerfectOverlap(player1, weapon2))
			player1.currentState = States.DIE;
		if (FlxG.pixelPerfectOverlap(player2, weapon1))
			player2.currentState = States.DIE;
		if (FlxG.pixelPerfectOverlap(weapon1, weapon2, 2))
		{
			if (player1.facing == FlxObject.RIGHT)
			{
				player1.currentState = States.SWDCONTACT;
				player1.velocity.x = -200;
				player2.currentState = States.SWDCONTACT;
				player2.velocity.x = 200;
			}
			else
			{
				player2.currentState = States.SWDCONTACT;
				player2.velocity.x = -200;
				player1.currentState = States.SWDCONTACT;
				player1.velocity.x = 200;
			}
		}
	}
}