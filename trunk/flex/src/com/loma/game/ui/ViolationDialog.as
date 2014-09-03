package com.loma.game.ui
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class ViolationDialog extends Quest3
	{
		public static const TYPE_BAD:int = 1;
		public static const TYPE_GOOD:int = 2;
		
		private var m_cb:Function = null;
		
		public function ViolationDialog()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function set callback(cb:Function):void
		{
			m_cb = cb;
		}
		
		protected function onMouseClick(event:MouseEvent):void
		{
			if(event.target is SimpleButton)
			{
				if(m_cb != null) m_cb();
			}
			
		}
		public function set type(t:int):void
		{
			txt_title.gotoAndStop(t);
		}
	}
}