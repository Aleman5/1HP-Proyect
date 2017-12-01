package;

import entities.GoGo;
import entities.Player1Mov;
import entities.Player2Mov;
import entities.PlayerThings;
import entities.SomeoneWon;
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
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState
{
	private var player1:Player1Mov;
	private var player2:Player2Mov;
	private var players:FlxTypedGroup<PlayerThings>;
	private var weapon1:Weapon1;
	private var weapon2:Weapon2;
	private var paused:Bool;
	private var pointFollowed:FlxObject;
	private var distBtwPlayers:Float; // Used for camera zoom
	private var cameraZoom:Float; // Used in PointX
	private var maxDist:Int;
	private var counterDeadBlueman:Int;
	private var counterDeadOrangeman:Int;
	
	private var flag1:ThisIsAFlag;
	private var flag2:ThisIsAFlag;
	
	private var loader:FlxOgmoLoader;
	private var tilemap:FlxTilemap;
	private var background:FlxSprite;
	
	private var wpsCollEmitter:FlxEmitter;
	private var wpPlaCollEmitter:FlxEmitter;
	
	private var blueManGo:GoGo;
	private var orangeManGo:GoGo;
	private var someoneWon:Bool;
	private var whoWon:Bool; // False = Blueman Wins ; True = Orangeman Wins
	private var sprBluemanWins:FlxSprite;
	private var bluemanTween:FlxTween;
	private var sprOrangemanWins:FlxSprite;
	private var orangemanTween:FlxTween;
	
	override public function create():Void
	{
		super.create();
		FlxG.worldBounds.set(0, 0, 3200, 480);
		paused = false;
		counterDeadBlueman = 0;
		counterDeadOrangeman = 0;
		
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
		flag1 = new ThisIsAFlag(320, camera.height - 118, player1, player2);
		flag2 = new ThisIsAFlag(FlxG.worldBounds.width - 320, camera.height - 118, player2, player1);
		add(flag1);
		add(flag2);
		add(players);
		add(weapon1);
		add(weapon2);
		
		wpsCollEmitter = new FlxEmitter(player1.x, player1.y - 200 , 12);
		wpsCollEmitter.makeParticles(2, 2, FlxColor.GRAY, 12);
		add(wpsCollEmitter);
		wpsCollEmitter.scale.set(0.5, 0.5, 0.5, 0.5, 1.5, 1.5, 2, 2);
		wpsCollEmitter.lifespan.set(0.2, 0.8);
		wpsCollEmitter.acceleration.set(0, 150, 0, 300);
		
		wpPlaCollEmitter = new FlxEmitter(player1.x, player1.y - 100, 25);
		wpPlaCollEmitter.makeParticles(2, 2, FlxColor.WHITE, 25);
		wpPlaCollEmitter.color.set(FlxColor.RED, FlxColor.ORANGE, FlxColor.PURPLE, FlxColor.BLACK);
		add(wpPlaCollEmitter);
		wpPlaCollEmitter.lifespan.set(0.1, 0.5);
		wpPlaCollEmitter.acceleration.set(0, 100, 0, 200);
		
		someoneWon = false;
		whoWon = false;
		sprBluemanWins = new SomeoneWon(camera.x + camera.width / 2 - 250, camera.y + camera.height / 2 - 100, 1);
		bluemanTween = FlxTween.color(sprBluemanWins, 3, 0xFF0028DD, 0xFF0000FF, {type: FlxTween.PINGPONG});
		sprOrangemanWins = new SomeoneWon(100, 100, 2);
		orangemanTween = FlxTween.color(sprOrangemanWins, 3, 0xFFEEA000, 0xFFFFA500, {type: FlxTween.PINGPONG});
		
		FlxG.sound.playMusic(AssetPaths.theme__wav, 1.1);
		
		cameraMovement();
		
		blueManGo = new GoGo(pointFollowed.x + camera.width / 2 - 90, camera.y + 20, 1, player1, pointFollowed);
		blueManGo.kill();
		orangeManGo = new GoGo(pointFollowed.x - camera.width / 2 + 15, camera.y + 20, 2, player2, pointFollowed);
		orangeManGo.kill();
		add(blueManGo);
		add(orangeManGo);
	}
	function cameraMovement() 
	{
		pointFollowed = new FlxObject((player1.x + ((player2.x - player1.x) / 2)), camera.height * 3 / 4, 1, 1);
		distBtwPlayers = 0;
		cameraZoom = 1;
		maxDist = 420;
		camera.follow(pointFollowed);
		camera.y = 0;
		camera.followLerp = 2;
		camera.setScrollBounds(0, 3200, 0, 480);
		camera.pixelPerfectRender = false;
	}
	override public function update(elapsed:Float):Void
	{
		if(!paused)
			super.update(elapsed);
		if (!someoneWon)
		{
			checkFlag();
			checkChasing();
			pointMovement();
			checkWinner();
		}
		else
		{
			if (whoWon)
			{
				sprOrangemanWins.setPosition(pointFollowed.x - 400, pointFollowed.y - 250);
				add(sprOrangemanWins);
			}
			else
				add(sprBluemanWins);
		}
		collisions();
		resetAndPause();
	}
	function checkWinner() 
	{
		if (player1.get_theFlag())
			if (player1.x < 96)
				someoneWon = true;
		if (player2.get_theFlag())
			if (player2.x > FlxG.worldBounds.width - 96)
			{
				someoneWon = true;
				whoWon = true;
			}
	}
	function pointMovement() 
	{
		if (player1.currentState != States.DIE && player2.currentState != States.DIE)
		{
			if(player1.x <= player2.x) 
				pointX(player1, player2);
			else
				pointX(player2, player1);
		}
		else if (player1.currentState == States.DIE)
			pointX(player2);
		else
			pointX(player1);
	}
	function pointX(p1:PlayerThings, ?p2:PlayerThings = null) 
	{
		if (p2 != null)
		{
			distBtwPlayers = p2.x - p1.x;
			if (p1.followMe || p2.followMe)
			{
				if (distBtwPlayers > maxDist)
				{
					if (p1.followMe || p1.get_theFlag())
						pointFollowed.x = p1.x + maxDist / 2;
					else if (p2.followMe || p2.get_theFlag())
						pointFollowed.x = p2.x - maxDist / 2;
				}
				else
					pointFollowed.x = (p1.x + distBtwPlayers / 2);
			}
			//else
			//	pointFollowed.x = (p1.x + distBtwPlayers / 2);
			
			/*if (distBtwPlayers < 200)
			{
				if (distBtwPlayers > 180)
				{
					cameraZoom = distBtwPlayers / 200;
					
					camera.zoom = 2 - cameraZoom;
				}
				else
					camera.zoom = 1.1;
			}
			else
				camera.zoom = 1;*/
		}
		else
		{
			pointFollowed.x = p1.x;
			//camera.zoom = 1;
		}
	}
	function checkFlag() 
	{
		if (!player2.get_theFlag())
			if (player2.currentState != States.DIE && FlxG.collide(player2, flag1))
			{
				if (!orangeManGo.alive)
					orangeManGo.reset(pointFollowed.x + camera.width / 2 - 100,  camera.y + 30);
				else
					orangeManGo.x = pointFollowed.x + camera.width / 2 - 100;
				
				player2.set_theFlag();
			}
		if (!player1.get_theFlag())
			if (player1.currentState != States.DIE && FlxG.collide(player1, flag2))
			{
				if (!blueManGo.alive)
					blueManGo.reset(pointFollowed.x - camera.width / 2 + 15,  camera.y + 30);
				else
					blueManGo.x = pointFollowed.x - camera.width / 2 + 15;
				
				player1.set_theFlag();
			}
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
		
		if (player1.currentState != States.DIE)
		{
			if (player1.x < pointFollowed.x - camera.width / 2 || player1.x > pointFollowed.x + camera.width / 2)
				player1.currentState = States.DIE;
			
			if (FlxG.overlap(player1, weapon2))
			{
				if (!orangeManGo.alive)
					orangeManGo.reset(pointFollowed.x - camera.width / 2 + 15, camera.y + 30);
				player2.followMe = true;
				camera.shake(0.005, 0.1);
				player1.currentState = States.DIE;
				blooding(player1, weapon2);
			}
		}
		else
		{
			counterDeadBlueman++;
			if (blueManGo.alive)
				blueManGo.kill();
			if (counterDeadBlueman > 49)
			{
				if (!player2.get_theFlag())
				{
					player1.facing = FlxObject.RIGHT;
					if (pointFollowed.x - camera.width * 2 / 5 > 16)
						player1.reset(pointFollowed.x - camera.width * 2 / 5, camera.height - 275);
					else
						player1.reset(32, camera.height - 275);
				}
				else
				{
					player1.facing = FlxObject.LEFT;
					if (pointFollowed.x + camera.width * 2 / 5 < FlxG.worldBounds.width - 16)
						player1.reset(pointFollowed.x + camera.width * 2 / 5, camera.height - 275);
					else
						player1.reset(FlxG.worldBounds.width - 32, camera.height - 275);
				}
				counterDeadBlueman = 0;
			}
		}
		if (player2.currentState != States.DIE)
		{
			if (player2.x < pointFollowed.x - camera.width / 2 || player2.x > pointFollowed.x + camera.width / 2)
				player2.currentState = States.DIE;
			
			if (FlxG.overlap(player2, weapon1))
			{
				if (!blueManGo.alive)
					blueManGo.reset(pointFollowed.x + camera.width / 2 - 90, camera.y + 30);
				player1.followMe = true;
				camera.shake(0.005, 0.1);
				player2.currentState = States.DIE;
				blooding(player2, weapon1);
			}
		}
		else
		{
			counterDeadOrangeman++;
			if (orangeManGo.alive)
				orangeManGo.kill();
			if (counterDeadOrangeman > 49)
			{
				if (!player1.get_theFlag())
				{
					player2.facing = FlxObject.LEFT;
					if (pointFollowed.x + camera.width * 2 / 5 < FlxG.worldBounds.width - 16)
						player2.reset(pointFollowed.x + camera.width * 2 / 5, camera.height - 275);
					else
						player2.reset(FlxG.worldBounds.width - 32, camera.height - 275);
				}
				else
				{
					player2.facing = FlxObject.RIGHT;
					if (pointFollowed.x - camera.width * 2 / 5 > 16)
						player2.reset(pointFollowed.x - camera.width * 2 / 5, camera.height - 275);
					else
						player2.reset(32, camera.height - 275);
				}
				counterDeadOrangeman = 0;
			}
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
				spark(weapon1);
			}
			else
			{
				player2.currentState = States.SWDCONTACT;
				player2.velocity.x = -200;
				player1.currentState = States.SWDCONTACT;
				player1.velocity.x = 200;
				camera.shake(0.005, 0.1);
				spark(weapon2);
			}
		}
	}
	function spark(w:WeaponThings) 
	{
		FlxG.sound.play(AssetPaths.colEspadas__wav);
		wpsCollEmitter.setPosition(w.x + w.width, w.y);
		wpsCollEmitter.start(true);
	}
	function blooding(p:PlayerThings, w:WeaponThings) 
	{
		if (w.facing == FlxObject.RIGHT)
		{
			wpPlaCollEmitter.setPosition(p.x , w.y);
			wpPlaCollEmitter.acceleration.set(-100, 100, -200, 400);
		}
		else
		{
			wpPlaCollEmitter.setPosition(p.x + p.width, w.y);
			wpPlaCollEmitter.acceleration.set(100, 100, 200, 400);
		}
		FlxG.sound.play(AssetPaths.death__wav);
		p.set_theFlag(false);
		wpPlaCollEmitter.start(true);
	}
	function resetAndPause() 
	{
		if (FlxG.keys.justPressed.P)
			paused = !paused;
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.sound.pause();
			var menuState = new MenuState();
			FlxG.switchState(menuState);
		}
	}
}
/* TO DO:

Finish with Trail things --> DONE

Use Camera Shake when a sword collide with the other sword or a Player --> DONE

Posibly implementation of Flicker when Player Revives --> DONT DO

Do the Titlescreren --> DONE

Use FlxTween and FlxEase with the title --> DONE

Make a CTF (Capture the Flag). Just to make an smaller Map --> DONE

Make an SprintAttack --> DONE

Use Particle Emitters when swords collide --> DONE

Correct the weapon's hitbox ♥ --> DONE

Make the camera follow both players instead of one --> DONE

Add the sounds --> DONE

*/
/* BUGS TO SOLVE:

Players Die when match starts, the problem is in the Line 259 isOnScreen() --> DONE

If the player who is running left passes over the "camera range", 
it always survive and the other player (who is on the other side) will die --> DONE

Orangeman wins but it doesnt appear the sprite "OrangeMan Wins"			   --> DONE

*/