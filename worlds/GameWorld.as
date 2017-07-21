package worlds {
	
	import actors.Background;
	import actors.Mountain;
	import actors.Obstacle;
	import actors.Penguin;
	import actors.GameButton;
	import flash.automation.StageCapture;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import core.SlidePenguin;
	
	public class GameWorld extends World {
		
		[Embed(source = "../../res/sfx/ice_breaking.mp3")] public static const ICE_BREAKING:Class;
		
		private const DELAY:Number = 0.7;
		private const OFFSET:Number = 160;
		private const FALL_WIDTH:Number = FP.width - 2 * OFFSET;
		
		private const INITING:uint = 0;
		private const RUNNING:uint = 1;
		private const FAIL:uint = 2;
		
		private var background:Background = new Background();
		private var mountain:Mountain = new Mountain();
		private var penguin:Penguin = new Penguin();
		private var gameButton:GameButton = new GameButton();
		private var state:uint = INITING;
		private var lastSpot:Number = OFFSET;
		private var score:Number = 0;
		private var timer:Number = 0;
		private var scoreText:Text = new Text("0", FP.width - 110, 10);
		private var iceBreakingFX:Sfx = new Sfx(ICE_BREAKING);
		
		public function GameWorld(initialState:uint = RUNNING):void {
			scoreText.color = 0x00FF00;
			scoreText.size = 64;
			state = initialState;
			
			scoreText.scrollX = scoreText.scrollY = 0;
			
			add(background);
			add(mountain);
			add(penguin);
			add(gameButton);
			addGraphic(scoreText);
			
			if (state != INITING) {
				gameButton.visible = false;
				gameButton.collidable = false;
			}
			
			SlidePenguin.OBSTACLE_SPEED = SlidePenguin.OBSTACLE_INITIAL_SPEED;
		}
		
		public function clamp(val:Number, min:Number, max:Number):Number {
			if (val < min) {
				return min;
			} else if (val > max) {
				return max;
			} else {
				return val;
			}
		}
		
		public function deployObstacle():void {
			var xpos:Number = OFFSET + (Math.random() * FALL_WIDTH);
			
			if (Math.abs(xpos - lastSpot) < penguin.width) {
				if (xpos < lastSpot) {
					xpos -= penguin.width;
				} else {
					xpos += penguin.width;
				}
			}
			
			xpos = clamp(xpos, OFFSET, OFFSET + FALL_WIDTH - penguin.width);
			
			if (Math.round(Math.random()) == 1) {
				add(new Obstacle(SlidePenguin.ROCK, xpos));
			} else {
				add(new Obstacle(SlidePenguin.TREE, xpos));
			}
			
			lastSpot = xpos;
		}
		
		public function setState(newState:uint):void {
			state = newState;
		}
		
		public function initingState():void {
			if (gameButton.wasClicked()) {
				setState(RUNNING);
				gameButton.visible = false;
				gameButton.collidable = false;
			}
		}
		
		public function runningState():void {
			penguin.behavior();
			
			var obst:Obstacle = penguin.collide(SlidePenguin.OBSTACLE, penguin.x, penguin.y) as Obstacle;
			if (obst) {
				iceBreakingFX.play();
				penguin.makePenguinSad();
				gameButton.setRestartStamp();
				gameButton.visible = true;
				gameButton.collidable = true;
				setState(FAIL);
			}
			
			timer += FP.elapsed;
			if (timer >= DELAY) {
				timer = 0;
				deployObstacle();
			}
			
			score += 0.1;
			scoreText.text = String(uint(score));
			SlidePenguin.OBSTACLE_SPEED += score / 1200;
		}
		
		public function failState():void {
			if (gameButton.wasClicked()) {
				FP.world = new GameWorld(RUNNING);
			}
		}
		
		override public function update():void {
			super.update();
			
			switch(state) {
				case INITING:
					initingState();
					break;
				case RUNNING:
					runningState();
					break;
				case FAIL:
					failState();
					break;
				default:
					trace("LERO LERO EH O NOME DA MUSICA");
					break;
			}
			
			FP.world.camera.x += 10 * FP.elapsed;
		}
		
	}

}