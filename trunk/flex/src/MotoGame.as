package
{
	import com.loma.game.background.GameBackground;
	import com.loma.game.player.Rider;
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
			
		
		public function MotoGame()
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		protected function initialize(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.addEventListener(Event.ENTER_FRAME, onUpdate);
			
			m_bg = new GameBackground();
			this.addChild(m_bg);
			
			m_rider = this.addChild(new Rider()) as Rider
			m_rider.state = Rider.STATE_MOVE;
			m_rider.y = 250;
			
			m_ui = new GameUI();
			this.addChild(m_ui);
			
			
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
				
		}
		
		protected function onUpdate(event:Event):void
		{
			m_bg.update();
			
			if(m_rider.x > 750)
				m_rider.x = 0;
			if(m_rider.moveDirection == Rider.MOVE_UP)
				m_rider.y -= 3;
			else if(m_rider.moveDirection == Rider.MOVE_DOWN)
				m_rider.y += 3;
			
		}
	}
}