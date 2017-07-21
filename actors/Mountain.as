package actors {
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.FP;
	import core.SlidePenguin;
	
	public class Mountain extends Entity {
		
		[Embed(source = "../../res/ogmo/scenario.oel", mimeType = "application/octet-stream")] public static const DATA:Class;
		[Embed(source = "../../res/img/mountain.png")] public static const MOUNTATIN_GRAPHICS:Class;
		
		private var mapGrid:Grid = null;
		private var mapImage:Image = null;
		
		public function Mountain():void {
			var mapXML:XML = FP.getXML(DATA);
			
			mapGrid = new Grid(uint(mapXML.@width), uint(mapXML.@height), 16, 16, 0, 0);
			mapGrid.loadFromString(String(mapXML.grid), "", "\n");
			
			/*if (String(mapXML.Tiles).length > 0) {
				var tm:Tilemap = new Tilemap(Assets.TILESHEET, mapGrid.width, mapGrid.height, 16, 16);
				tm.loadFromString(mapXML.Tiles, ",", "\n");
				mapImage = tm;
			}*/
			
			mapImage = new Image(MOUNTATIN_GRAPHICS);
			
			if (mapImage == null) {
				var mi:Image = new Image(mapGrid.data);
				mi.scale = 16;
				mi.color = 0xB0E0E6;
				mapImage = mi;
			}
			
			super(0, 0, mapImage, mapGrid);
			type = name = SlidePenguin.MOUNTAIN;
			graphic.scrollX = graphic.scrollY = 0;
		}
		
	}

}