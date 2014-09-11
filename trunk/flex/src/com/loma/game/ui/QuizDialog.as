package com.loma.game.ui
{
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	/**
	 * 
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class QuizDialog extends Quest2
	{
		private var m_cb:Function = null;
		
		public function QuizDialog()
		{
			super();
			
			this.addEventListener(MouseEvent.CLICK, onClick);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		protected function onRemove(event:Event):void
		{
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
		}
		
		protected function onAdd(event:Event):void
		{
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
		}
		
		protected function onKeyboardDown(event:KeyboardEvent):void
		{
			if(m_cb != null)
			{
				if(event.keyCode == Keyboard.A)
					m_cb(true);
				else if(event.keyCode == Keyboard.D)
					m_cb(false);
			}
		}
		
		public function set callback(cb:Function):void
		{
			m_cb = cb;
		}
		
		protected function onClick(event:MouseEvent):void
		{
			if(event.target is SimpleButton)
			{
				if(m_cb != null) 
				{
					if(event.target.name == "btn_yes")
						m_cb(true);
					else
						m_cb(false);
				}
			}
			
		}
		
	}
}