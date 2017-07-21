package {
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import worlds.GameWorld;
	import core.SlidePenguin;
	import worlds.StartWorld;
	
	public class Main extends Engine {
		
		[Embed(source = "../res/music/happy_0.mp3")] public static const THEME:Class;
		
		private var theme:Sfx = new Sfx(THEME);
		
		public function Main():void {
			super(SlidePenguin.GAME_WIDTH, SlidePenguin.GAME_HEIGHT, 60);
			FP.world = new StartWorld();
			FP.screen.color = 0xFFFFFF;
			theme.loop();
		}
		
	}
	
}