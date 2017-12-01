package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/level.oep", "assets/data/level.oep");
			type.set ("assets/data/level.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/level.oel", "assets/data/level.oel");
			type.set ("assets/data/level.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/player1.png", "assets/images/player1.png");
			type.set ("assets/images/player1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tiles.png", "assets/images/tiles.png");
			type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/backGround.png", "assets/images/backGround.png");
			type.set ("assets/images/backGround.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/weaponPlayer1.png", "assets/images/weaponPlayer1.png");
			type.set ("assets/images/weaponPlayer1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/flags.png", "assets/images/flags.png");
			type.set ("assets/images/flags.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player2.png", "assets/images/player2.png");
			type.set ("assets/images/player2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/weaponPlayer2.png", "assets/images/weaponPlayer2.png");
			type.set ("assets/images/weaponPlayer2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/title.png", "assets/images/title.png");
			type.set ("assets/images/title.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/orangemanWins.png", "assets/images/orangemanWins.png");
			type.set ("assets/images/orangemanWins.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/bluemanWins.png", "assets/images/bluemanWins.png");
			type.set ("assets/images/bluemanWins.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/orangemanGo.png", "assets/images/orangemanGo.png");
			type.set ("assets/images/orangemanGo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/bluemanGo.png", "assets/images/bluemanGo.png");
			type.set ("assets/images/bluemanGo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/theme.wav", "assets/sounds/theme.wav");
			type.set ("assets/sounds/theme.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/death.wav", "assets/sounds/death.wav");
			type.set ("assets/sounds/death.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/colEspadas.wav", "assets/sounds/colEspadas.wav");
			type.set ("assets/sounds/colEspadas.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
