package
{
	import com.loma.game.background.GameBackground;
	import com.loma.game.oil.OilManager;
	import com.loma.game.player.Rider;
	import com.loma.game.quest.QuestFirst;
	import com.loma.game.quest.QuestManager;
	import com.loma.game.quest.QuestObstacles;
	import com.loma.game.quiz.QuizManager;
	import com.loma.game.randomevent.RandomEventManager;
	import com.loma.game.sound.SoundManager;
	import com.loma.game.ui.GameUI;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	/**
	 * 
	 * @long  Aug 26, 2014
	 * 
	 */	
	[SWF(backgroundColor="#1355ff", frameRate="30", width="700", height="500")]
	public class MotoGame extends Sprite
	{
		public static const MAX_LIFE:int = 5;
		
		public static const MAX_SPEED:int = 100;
		
		public static const LAYER_BACKGROUND:int = 0;
		public static const LAYER_SCENE:int = 1;
		public static const LAYER_UI:int = 2;
		public static const MAX_LAYER:int = 3;
		
		public static const UNIT_OIL_FRAMES:int = 300;
		
		private var m_rider:Rider;
		private var m_ui:GameUI;
		private var m_bg:GameBackground;
		
		private var m_life:int = MAX_LIFE;
		
		private var m_speed:Number = 0;
		
		private var m_score:int = 0;
		
		private var m_bGameStart:Boolean = false;
		
		private var m_debugText:TextField = new TextField();
		
		private var m_bBackward:Boolean;
		private var m_bForward:Boolean;
		
		
		public function MotoGame()
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);			
		}
		
		
		protected function initialize(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			initLayer();
			
			m_bg = new GameBackground();
			this.addObjToLayer(LAYER_BACKGROUND, m_bg);
			
			m_rider = new Rider();
			
			m_ui = new GameUI();
			m_ui.gameStartCallback = gameStart;
			this.addObjToLayer(LAYER_UI, m_ui);
			
			m_debugText.x = 10;
			m_debugText.y = 10;
			m_debugText.autoSize = TextFieldAutoSize.LEFT;
			this.addObjToLayer(LAYER_UI, m_debugText);
			
			QuestManager.instance.ininialize(this);
			QuestManager.instance.start = true;
			
			RandomEventManager.instance.initialize(this);
			
			OilManager.instance.initialize(this, 3*60); // 設定遊戲時間為3分鐘
			
			SoundManager.instance.playMenuBGM();
		}
		
		private function initLayer():void
		{
			// TODO Auto Generated method stub
			for(var i:int = 0; i < MAX_LAYER; i++)
				this.addChild(new Sprite());
		}
		
		public function get ui():GameUI
		{
			return m_ui;
		}
		
		public function get player():Rider
		{
			return m_rider;
		}
		
		public function get background():GameBackground
		{
			return m_bg;
		}
		
		private function getLayer(index:int):Sprite
		{
			return this.getChildAt(index) as Sprite;
		}
		
		public function addObjToLayer(layerIdx:int, obj:DisplayObject):void			
		{
			var layer:Sprite = getLayer(layerIdx);
			if(layer)
			{
				layer.addChild(obj);
			}
		}
		
		public function removeObjFormLayer(layerIdx:int, obj:DisplayObject):void
		{
			var layer:Sprite = getLayer(layerIdx);
			if(layer)
			{
				layer.removeChild(obj);
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.W || event.keyCode == Keyboard.UP)
			{
				m_rider.moveDirection = Rider.MOVE_UP;
			}
			else if(event.keyCode == Keyboard.S || event.keyCode == Keyboard.DOWN)
			{
				m_rider.moveDirection = Rider.MOVE_DOWN;
			}
			
			if(event.keyCode == Keyboard.A || event.keyCode == Keyboard.LEFT)
			{
				m_bBackward = true;				
			}
			else if(event.keyCode == Keyboard.D || event.keyCode == Keyboard.RIGHT)
			{
				m_bForward = true;
			}
			
			//test
			if(event.keyCode == Keyboard.INSERT)
			{
				var q:QuestObstacles = new QuestObstacles();
				QuestManager.instance.addQuest(q);
			}
			else if(event.keyCode == Keyboard.DELETE)
			{
				QuizManager.instance.reGeneration();	
				
			}	
			else if(event.keyCode == Keyboard.I)
			{
				m_bg.addObject(0, new Rider(), 400, 150);
			}
			else if(event.keyCode == Keyboard.ESCAPE)
			{
				this.gameOver();
			}
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.W || event.keyCode == Keyboard.UP)
			{
				m_rider.moveDirection = Rider.MOVE_NONE;
			}
			else if(event.keyCode == Keyboard.S || event.keyCode == Keyboard.DOWN)
			{
				m_rider.moveDirection = Rider.MOVE_NONE;
			}			
			
			if(event.keyCode == Keyboard.A || event.keyCode == Keyboard.LEFT)
			{
				m_bBackward = false;
			}
			else if(event.keyCode == Keyboard.D || event.keyCode == Keyboard.RIGHT)
			{
				m_bForward = false;
			}
		}
		
		protected function onUpdate(event:Event):void
		{
			QuestManager.instance.update();
			
			if(!m_bGameStart) return;
			
			updateSpeed();
			
			updateBackground();
			
			updateRider();
			
			updateOil();
			
			RandomEventManager.instance.update();
			
			depthSort();
			
			checkGameOver();
			
			m_debugText.text = "Rider x = " + m_rider.x + ", y = " + m_rider.y + 
							   "\nstageX = " + stage.mouseX + ". stageY = " + stage.mouseY;
		}
		
		private function checkGameOver():void
		{			
			if(m_life <= 0)
				gameOver();
		}
		
		private function depthSort():void
		{
			var scene:Sprite = getLayer(MotoGame.LAYER_SCENE);
			var i:int = 0, j:int = 0, len:int = scene.numChildren;
			
			// bubble sort
			for(i = 0; i < len; i++)
			{
				var bSwapped:Boolean = false;
				for(j = 0; j < len - i - 1; j++)
				{
					var c1:DisplayObject = scene.getChildAt(j);
					var c2:DisplayObject = scene.getChildAt(j + 1);
					
					if(c1.y > c2.y)
					{
						scene.swapChildren(c1, c2);
						bSwapped = true;
					}
				}
				if(!bSwapped)
					break;
			}
			
			
		}
		
		private function updateSpeed():void
		{
			var dS:Number;
			if(m_speed < 30)
				dS = 0.45;
			else if(m_speed < 40)
				dS = 0.4;
			else if(m_speed < 50)
				dS = 0.35;
			else
				dS = 0.2;
						
			if(isForward())
			{
				m_speed += dS;
			}
			else if(isBackward())
			{
				m_speed -= 2;
			}
			else if(!m_bForward && !m_bBackward)
			{
				m_speed -= 0.5;
			}
			else
			{
				
			}
			
			if(m_speed > MAX_SPEED)
				m_speed = MAX_SPEED;
			else if(m_speed < 0)
				m_speed = 0;
			
			m_ui.speed = m_speed;
		}
		
		private function updateBackground():void
		{
			if(m_speed <= 0)
				m_rider.state = Rider.STATE_STOP;
			
			if(m_rider.state != Rider.STATE_MOVE)
				return;
			
			m_bg.moveSpeed = m_speed;
			m_bg.update();
		}
		
		private function updateRider():void
		{
			if(m_speed > 0)
				m_rider.state = Rider.STATE_MOVE;
			
			// 控制煞車燈
			if(isBackward())
				m_rider.isBreak = true;
			else
				m_rider.isBreak = false;
			
			if(m_rider.state == Rider.STATE_STOP)
				return;
			
			if(m_rider.moveDirection == Rider.MOVE_UP)
				m_rider.y -= 5;
			else if(m_rider.moveDirection == Rider.MOVE_DOWN)
				m_rider.y += 5;
			
			if(isForward() && m_speed > 50)
			{
				m_rider.x += 3;
				//m_rider.transform.matrix = new Matrix(1, 0, 0.15, 1, m_rider.x, m_rider.y);				
			}
			else
			{
				m_rider.x -= 3;
				//m_rider.transform.matrix = new Matrix(1, 0, 0, 1, m_rider.x, m_rider.y);
			}
			
			m_rider.x = clamp(m_rider.x, Rider.MIN_X, Rider.MAX_X);
		}
		
		private function updateOil():void
		{
			OilManager.instance.update();
		}
		
		
		
		public function gameStart():void
		{
			m_bGameStart = true;
			
			m_ui.hideMenu();
			m_ui.initialize();
			
			this.life = MAX_LIFE;
			
			this.score = 0
			
			riderStart();
			this.addObjToLayer(LAYER_SCENE, m_rider);	
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.addEventListener(Event.ENTER_FRAME, onUpdate);
			
			// add first quest
			QuestManager.instance.addQuest(new QuestFirst());
			
			OilManager.instance.initialize(this, 3*60);
			
			SoundManager.instance.playBGM();
			SoundManager.instance.stopMenuBGM();
		}
		
		public function gameMenu():void
		{
			m_bGameStart = false;
			m_ui.showMenu();
			
			this.removeObjFormLayer(LAYER_SCENE, m_rider);
			
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.removeEventListener(Event.ENTER_FRAME, onUpdate);
			
			QuestManager.instance.release();
			RandomEventManager.instance.clean();
			
			SoundManager.instance.stopBGM();
			SoundManager.instance.playMenuBGM();
		}
		
		public function gameOver():void
		{
			this.gamePause = true;
			QuestManager.instance.release();		
			
			ui.showGameOverUI(m_score, m_life, gameMenu);			 
		}
		
		public function riderStart():void
		{
			m_rider.state = Rider.STATE_STOP;
			m_rider.y = 400;
			m_rider.x = Rider.MIN_X;
			//m_rider.transform.matrix = new Matrix(1, 0, 0, 1, m_rider.x, m_rider.y);
			
			m_speed = 0;
			
			/*m_bForward = false;
			m_bBackward = false;*/
			
			updateSpeed();
		}
		
		public function set gamePause(value:Boolean):void
		{
			m_bGameStart = !value;
		}
		
		public function set score(value:int):void
		{
			this.m_score = value;
			this.ui.score = value;
		}
		
		public function addScore(value:int):void
		{
			m_score += value;
			this.ui.score = m_score;
		}
		
		public function get currentSpeed():Number
		{
			return m_speed;
		}

		public function get life():int
		{
			return m_life;
		}

		public function set life(value:int):void
		{	
			m_life = clamp(value, 0, MAX_LIFE);
			
			ui.life = m_life;
		}
		
		public function addLife(value:int):void
		{
			life = (m_life + value);
		}
		
		private function clamp(value:int, min:int, max:int):int
		{
			if(value < min)
				value = min;
			else if(value > max)
				value = max;
			
			return value;
		}
		
		private function isForward():Boolean
		{
			return (m_bForward && !m_bBackward);
		}
		
		private function isBackward():Boolean
		{
			return (!m_bForward && m_bBackward);
		}

	}
}