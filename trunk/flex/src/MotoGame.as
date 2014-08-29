package
{
	import com.loma.game.background.GameBackground;
	import com.loma.game.player.Rider;
	import com.loma.game.quest.QuestManager;
	import com.loma.game.ui.GameUI;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
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
		
		private var m_rider:Rider;
		private var m_ui:GameUI;
		private var m_bg:GameBackground;
		
		private var m_life:int = MAX_LIFE;
		
		private var m_speed:int = 0;
		private var m_speedDamping:int = 5;
		private var m_acceleration:int = 8;
		private var m_bGameStart:Boolean = false;
			
		
		public function MotoGame()
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		protected function initialize(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			m_bg = new GameBackground();
			this.addChild(m_bg);
			
			m_rider = new Rider();
			m_rider.state = Rider.STATE_STOP;
			m_rider.y = 250;
			m_rider.x = 30;
			
			m_ui = new GameUI();
			m_ui.gameStartCallback = gameStart;
			this.addChild(m_ui);
			
			QuestManager.instance.ininialize();
			
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
			
			//test
			if(event.keyCode == Keyboard.INSERT)
			{
				m_life++;
				if(m_life > MAX_LIFE)
					m_life = MAX_LIFE;
				m_ui.life = m_life;
			}
			else if(event.keyCode == Keyboard.DELETE)
			{
				m_life--;
				if(m_life < 0)
					m_life = 0;
				m_ui.life = m_life;
			}	
			else if(event.keyCode == Keyboard.I)
			{
				m_bg.addObject(0, new Rider(), 400, 150);
			}
		}
		
		protected function onUpdate(event:Event):void
		{
			if(!m_bGameStart) return;
			
			m_bg.update();
			
			if(m_rider.x > 750)
				m_rider.x = 0;
			if(m_rider.moveDirection == Rider.MOVE_UP)
				m_rider.y -= 3;
			else if(m_rider.moveDirection == Rider.MOVE_DOWN)
				m_rider.y += 3;
		}
		
		public function gameStart():void
		{
			m_bGameStart = true;
			
			m_ui.hideMenu();
			
			this.addChild(m_rider);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		public function gameMenu():void
		{
			m_bGameStart = false;
			m_ui.showMenu();
			
			this.removeChild(m_rider);
			
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.removeEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		public function set gamePause(value:Boolean):void
		{
			
		}
	}
}