package worlds {
	
	import actors.Background;
	import actors.GameButton;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class StartWorld extends World {
		
		[Embed(source = "../../res/img/start_panel.png")] public static const START_PANEL:Class;
		
		private var background:Background = new Background();
		private var gameButton:GameButton = new GameButton();
		private var startPanel:Image = new Image(START_PANEL);
		
		public function StartWorld():void {
			gameButton.y = 395;
			startPanel.x = startPanel.y = 0;
			add(background);
			add(gameButton);
			addGraphic(startPanel);
		}
		
		override public function update():void {
			super.update();
			if (gameButton.wasClicked()) {
				FP.world = new GameWorld();
			}
		}
		
	}

}