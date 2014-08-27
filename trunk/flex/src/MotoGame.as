package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import player.Rider;
	
	/**
	 * 
	 * @long  Aug 26, 2014
	 * 
	 */	
	[SWF(backgroundColor="#aa0000", frameRate="30", width="700", height="500")]
	public class MotoGame extends Sprite
	{
		
		private var m_rider:Rider;
		
		public function MotoGame()
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		protected function initialize(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.addEventListener(Event.ENTER_FRAME, onUpdate);
			
			var r1:Rider = this.addChild(new Rider()) as Rider;
			r1.state = Rider.STATE_STOP;
			
			var r2:Rider = this.addChild(new Rider()) as Rider
			r2.state = Rider.STATE_START;
			r2.y = 150;
			
			m_rider = this.addChild(new Rider()) as Rider
			m_rider.state = Rider.STATE_MOVE;
			m_rider.y = 300;
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
		}
		
		protected function onUpdate(event:Event):void
		{
			m_rider.x += 5;
			if(m_rider.x > 750)
				m_rider.x = 0;
			if(m_rider.moveDirection == Rider.MOVE_UP)
				m_rider.y -= 3;
			else if(m_rider.moveDirection == Rider.MOVE_DOWN)
				m_rider.y += 3;
			
		}
	}
}