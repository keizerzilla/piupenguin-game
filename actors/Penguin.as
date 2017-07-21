package actors {
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import core.SlidePenguin;
	import net.flashpunk.utils.Ease;
	
	public class Penguin extends Entity {
		
		[Embed(source = "../../res/img/penguin.png")] public const PENGUIN_GRAPHICS:Class;
		[Embed(source = "../../res/img/penguin_down.png")] public const PENGUIN_DOWN_GRAPHICS:Class;
		[Embed(source = "../../res/img/ice_particles.png")] public const PARTICLES:Class;
		
		private const SPEED:Number = 360;
		
		private var emitter:Emitter = new Emitter(PARTICLES, 36, 36);
		private var sprite:Image = new Image(PENGUIN_GRAPHICS);
		private var dx:Number = 0;
		
		public function Penguin():void {
			Input.define(SlidePenguin.LEFT, Key.LEFT, Key.A);
			Input.define(SlidePenguin.RIGHT, Key.RIGHT, Key.D);
			
			emitter.newType(SlidePenguin.ICE_PARTICLE, [0, 1, 2, 3]);
			emitter.setAlpha(SlidePenguin.ICE_PARTICLE, 1, 0, Ease.quadIn);
			emitter.setMotion(SlidePenguin.ICE_PARTICLE, 0, sprite.height + 10, 1, 180, 0, 0, Ease.circIn);
			
			emitter.newType(SlidePenguin.FAINT_PARTICLE, [0, 1, 2, 3]);
			emitter.setAlpha(SlidePenguin.FAINT_PARTICLE, 1, 0, Ease.quadIn);
			emitter.setMotion(SlidePenguin.FAINT_PARTICLE, 0, sprite.height, 1.2, 360, 0, 1, Ease.circInOut);
			
			setHitbox(sprite.width, sprite.height);
			
			type = name = SlidePenguin.PENGUIN;
			layer = -100;
			
			super(FP.halfWidth - sprite.width / 2, 30, new Graphiclist(emitter, sprite));
			
			graphic.scrollX = graphic.scrollY = 0;
		}
		
		public function behavior():void {
			if (Input.check(SlidePenguin.LEFT)) {
				dx = -1 * SPEED * FP.elapsed;
			} else if (Input.check(SlidePenguin.RIGHT)) {
				dx = SPEED * FP.elapsed;
			} else {
				dx *= 0.85;
			}
			
			moveBy(dx, 0, SlidePenguin.MOUNTAIN);
			emitter.emit(SlidePenguin.ICE_PARTICLE, sprite.x, sprite.y + sprite.height / 2);
		}
		
		public function makePenguinSad():void {
			graphic = new Image(PENGUIN_DOWN_GRAPHICS);
			graphic.scrollX = graphic.scrollY = 0;
		}
		
	}

}