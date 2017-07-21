package actors {
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class GameButton extends Entity {
		
		[Embed(source = "../../res/img/retry_button.png")] public static const RETRY_GRAPHICS:Class;
		[Embed(source = "../../res/img/begin_button.png")] public static const BEGIN_BUTTON:Class;
		
		private var startStamp:Image = new Image(BEGIN_BUTTON);
		private var restartStamp:Image = new Image(RETRY_GRAPHICS);
		
		public function GameButton():void {
			setHitbox(startStamp.width, startStamp.height);
			super(FP.halfWidth - halfWidth, FP.halfHeight - halfHeight, startStamp);
			layer = -100;
			graphic.scrollX = graphic.scrollY = 0;
		}
		
		public function wasClicked():Boolean {
			return collidePoint(x, y, Input.mouseX, Input.mouseY) && Input.mousePressed;
		}
		
		public function setStartStamp():void {
			graphic = startStamp;
			graphic.scrollX = graphic.scrollY = 0;
		}
		
		public function setRestartStamp():void {
			graphic = restartStamp;
			graphic.scrollX = graphic.scrollY = 0;
		}
		
	}

}