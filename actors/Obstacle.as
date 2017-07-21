package actors {
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import core.SlidePenguin;
	import net.flashpunk.graphics.Image;
	
	public class Obstacle extends Entity {
		
		[Embed(source = "../../res/img/tree.png")] public static const TREE_GRAPHICS:Class;
		[Embed(source = "../../res/img/stone.png")] public static const STONE_GRAPHICS:Class;
		
		private var sprite:Image = null;
		
		public function Obstacle(obstacleName:String, xpos:Number):void {
			if (obstacleName == SlidePenguin.ROCK) {
				sprite = new Image(STONE_GRAPHICS);
			} else if (obstacleName == SlidePenguin.TREE) {
				sprite = new Image(TREE_GRAPHICS);
			}
			
			setHitbox(sprite.width, sprite.height);
			name = obstacleName;
			type = SlidePenguin.OBSTACLE;
			
			super(xpos, FP.height + width, sprite);
			
			graphic.scrollX = graphic.scrollY = 0;
		}
		
		override public function update():void {
			super.update();
			y -= SlidePenguin.OBSTACLE_SPEED * FP.elapsed;
			if (y + height < 0) {
				FP.world.remove(this);
			}
		}
		
	}

}