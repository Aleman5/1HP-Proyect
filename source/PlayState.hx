package;

import entities.Player1Mov;
import entities.Player2Mov;
import entities.PlayerThings;
import entities.ThisIsAFlag;
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
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class PlayState extends FlxState
{
	private var player1:Player1Mov;
	private var player2:Player2Mov;
	private var players:FlxTypedGroup<PlayerThings>;
	private var weapon1:Weapon1;
	private var weapon2:Weapon2;
	private var paused:Bool;
	
	private var flag1:ThisIsAFlag;
	private var flag2:ThisIsAFlag;
	
	private var loader:FlxOgmoLoader;
	private var tilemap:FlxTilemap;
	private var background:FlxSprite;
	
	private var emitter:FlxEmitter;
	private var p:FlxParticle;
	
	override public function create():Void
	{
		super.create();
		FlxG.worldBounds.set(0, 0, 3200, 480);
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
		
		players = new FlxTypedGroup();
		player1 = new Player1Mov(1550, camera.height / 2, 1);
		player2 = new Player2Mov(1650, camera.height / 2, 2);
		players.add(player1);
		players.add(player2);
		weapon1 = new Weapon1(player1.x + player1.width / 2, player1.y + 6, player1);
		weapon2 = new Weapon2(player2.x + player2.width / 2, player2.y + 6, player2);
		flag1 = new ThisIsAFlag(32, camera.height - 118, player1, player2);
		flag2 = new ThisIsAFlag(camera.width - 47, camera.height - 118, player2, player1);
		add(flag1);
		add(flag2);
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
		checkChasing();
		collisions();
		resetAndPause();
	}
	function checkChasing() 
	{
		if (player1.facing == FlxObject.LEFT && player2.facing == FlxObject.LEFT)
		{
			player2.set_isChasing(false);
			
			if (player2.x < player1.x)
			{
				if (player2.velocity.x < 0 && player1.velocity.x < 0)
					player1.set_isChasing(true);
				else
					player1.set_isChasing(false);
			}
			else
				player1.set_isChasing(false);
		}
		else if (player1.facing == FlxObject.RIGHT && player2.facing == FlxObject.RIGHT)
		{
			player1.set_isChasing(false);
			
			if (player1.x > player2.x)
			{
				if (player1.velocity.x > 0 && player2.velocity.x > 0)
					player2.set_isChasing(true);
				else
					player2.set_isChasing(false);
			}
			else
				player2.set_isChasing(false);
		}
	}
	function collisions() 
	{
		FlxG.collide(players, tilemap);
		if(player1.currentState != States.DIE)
			if (FlxG.overlap(player1, weapon2))
			{
				camera.shake(0.005, 0.1);
				player1.currentState = States.DIE;
			}
		if(player2.currentState != States.DIE)
			if (FlxG.overlap(player2, weapon1))
			{
				camera.shake(0.005, 0.1);
				player2.currentState = States.DIE;
			}
		if (FlxG.overlap(weapon1, weapon2))
		{
			if (player1.facing == FlxObject.RIGHT)
			{
				player1.currentState = States.SWDCONTACT;
				player1.velocity.x = -200;
				player2.currentState = States.SWDCONTACT;
				player2.velocity.x = 200;
				camera.shake(0.005, 0.1);
			}
			else
			{
				player2.currentState = States.SWDCONTACT;
				player2.velocity.x = -200;
				player1.currentState = States.SWDCONTACT;
				player1.velocity.x = 200;
				camera.shake(0.005, 0.1);
			}
		}
	}
	function resetAndPause() 
	{
		if (FlxG.keys.justPressed.P)
			paused = !paused;
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();
		if (FlxG.keys.justPressed.ESCAPE)
		{
			var menuState = new MenuState();
			FlxG.switchState(menuState);
		}
	}
}

/*
TO DO:

Finish with Trail things --> DONE

Use Camera Shake when a sword collide with the other sword or a Player --> DONE

Posibly implementation of Flicker when Player Revives --> WAITING

Do the Titlescreren --> DONE

Use FlxTween and FlxEase with the title --> STAND BY

Make a CTF (Capture the Flag). Just to make an smaller Map --> DOING

Add the sounds --> WAITING
*/