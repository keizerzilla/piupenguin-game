package actors {
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	
	public class Background extends Entity {
		
		[Embed(source = "../../res/img/background.png")] public static const BACKGROUND:Class;
		
		private var backdrop:Backdrop = new Backdrop(BACKGROUND);
		
		public function Background() {
			super(0, 0, backdrop);
			layer = 9000;
		}
		
		override public function update():void {
			super.update();
			backdrop.scrollX = 2;
		}
		
	}

}