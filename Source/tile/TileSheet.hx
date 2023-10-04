package tile;

import haxe.exceptions.PosException;
import openfl.geom.Rectangle;
import openfl.display.Tileset;
import openfl.Assets;
import openfl.display.Bitmap;

/**
	Load tiles spritesheet from json file.
**/

@:jsonParse(function (json) return new tile.TileSheet(json.name, json.tile_width, json.tile_height, json.padding))
class TileSheet {
	public var name:String;
    public var tile_width:Int;
	public var tile_height:Int;
	public var padding:Int;

    public var tile_count(get, default ):Int;

    // no need to access?
    public var bitmap(get, default):Bitmap;

	public var description:Map<Int, Any>;

	private var _bitmap:Bitmap;

	public function new(name:String, tile_width:Int, tile_height:Int, padding:Int) {
		this.name = name;
		this.tile_width = tile_width;
		this.tile_height = tile_height;
		this.padding = padding;
	}

	public function test() {
		trace(padding);
	}

	function get_tile_count():Int {
		if (bitmap == null) {
			initBitmap();
		}

			// TODO: check tile_width, tile_height for divsion by zero
		if ((tile_width == 0) || (tile_width == 0))
			throw new haxe.exceptions.PosException("Divitions by 0");
		else {
			return Std.int(bitmap.width/tile_width) * Std.int(bitmap.height/tile_height);
		}
	}

	function get_bitmap():Bitmap {
		(_bitmap == null) ? return initBitmap() : return _bitmap;
	}

	public function initBitmap():Bitmap
	{
		if (_bitmap == null) {
			trace("loading bitmap data "+name);
			var bitmapData = Assets.getBitmapData(name);
			_bitmap = new Bitmap(bitmapData);
			return _bitmap;
		}
		else {
			return _bitmap;
		}
	}

	public function toTileSet()
	{
		trace("Tilesheet::toTileSet : " + tile_count);

		var theTileset = new Tileset(_bitmap.bitmapData);

		for (i in 0...tile_count) {
			
			var x = (i * tile_width) % bitmap.width;
			var y = Std.int((i * tile_width) / bitmap.width) * tile_height;

			theTileset.addRect(new Rectangle(x, y, tile_width, tile_height));
		}

		return theTileset;
	}
}
