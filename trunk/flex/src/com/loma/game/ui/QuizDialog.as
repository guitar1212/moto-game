package com.loma.game.ui
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

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