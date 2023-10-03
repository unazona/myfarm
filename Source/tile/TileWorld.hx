package tile;

import motion.easing.Quad;
import motion.Actuate;

import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.Assets;
import openfl.utils.Future;
import openfl.display.Tileset;
import openfl.display.Sprite;

import tile.TileSheet;

class TileWorld extends Sprite {
	private var	tile_sheet:TileSheet;		// Loadable Tilesheet from JSON

	private var tile_set:Tileset;			// Translate Tilesheet into Tileset
	private var tile_map:Tilemap;			// Tilemap

	private var world_width:Int;			// Number of horizontal tiles
	private var world_height:Int;			// Number of vertical tiles

	public function new() {
		super();

		world_width = world_height = 10;

		loadTiles();
	}

	// Load Tiles from local json file (can be loaded remotely)
	public function loadTiles() {
		// Load JSON description of tiles
		var spritesheet:Future<String> = 

		Assets.loadText("assets/spritesheet.json").onComplete(
			function(value)  {
				tile_sheet = tink.Json.parse(value);

				trace("Tilesheet created from JSON : " + tile_sheet);

				// Grab tileset from spritesheet
				tile_set = tile_sheet.toTileSet();

				tile_map = new Tilemap(1000, 1000, tile_set);
				addChild(tile_map);

				initTiles();
			}
		);
	}


	public function initTiles() {
		Assets.loadText("assets/map2.json").onComplete(
			function(value)  {
				var map:Dynamic = tink.Json.parse(value);

				var convert:Array< Array <Int> > = map.map_data;

				for (i in 0...convert.length)
					for (j in 0...convert[i].length)
						paintTile(convert[i][j], i, j);
			});
	}

	public function initTilesFromWork(map:Dynamic) {
		map = tink.Json.parse(map);

		trace("initTilesFromWork : " + map);
		trace("initTilesFromWork data : " + map.map_data);

		var convert:Array< Array <Int> > = map.map_data;

		for (i in 0...convert.length)
			for (j in 0...convert[i].length)
				paintTile(convert[i][j], i, j);
	}
	
//	public var tileset:Tileset;
    // Land : 0-10
    // Rocky land : 11- 16
    // Mud : 17-21
    // Grassmud : 3
	// Water : 101-110


	// chatGPT prompt
	// Describe spritesheet
	
	// My Tilemap is 25x25, json format, map_data contains the map data in double array format
	// Tiles are described as following:
	// Land variant tile values ranging as [11-16]
	// Water variant tile values ranging as [101-110]
	// When generating use all tiles variant
	// Generate 50% land and 50% water

	// Move to TileSheet
    public function addTiles() {
		// #2 : Assign rects
		//bitmap.x = 400;
		// tile_map.addTile(new Tile(32, 0, 0)); // X/y
		//tile_map.addTile(new Tile(33, 32, 0)); // X/y
		//tile_map.addTile(new Tile(30, 0, 32)); // X/y

		for (i in 0...25)
			for (j in 0...25)
			{
				paintTile(Std.int(Math.min(i*j, 50)), i, j);

				//paintTile(1, i, j);
			}
	}

	public function paintTile(id:Int, x:Int, y:Int) {
		var TILE_WIDTH:Int = 32;
		var TILE_WIDTH_HALF:Int = 16;
		var TILE_HEIGHT:Int = 24;
		var TILE_HEIGHT_HALF:Int = 12;

		var wx = x * TILE_WIDTH_HALF - y * TILE_WIDTH_HALF;
		var wy = x * TILE_HEIGHT_HALF + y * TILE_HEIGHT_HALF;

		// Apply camera calculation to start from middle of scren
		wx = Std.int(wx+(tile_map.width/2));

		tile_map.addTile(new Tile(id, wx, wy)); // X/Y	
	}

	// One level zoomInOrOut
	public function zoomInOrOut() {
		var to:Float = 1.5;
		Actuate.tween (this, 1, { scaleX: (tile_map.scaleX < to) ? to : 1, scaleY: (tile_map.scaleY < to) ? to : 1 } ).ease (Quad.easeInOut);
	}

}
