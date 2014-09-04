package com.loma.game.ui
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

	public class FirstQuestionDialog extends Quest1
	{
		private var m_cb:Function = null;
		
		public function FirstQuestionDialog()
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
				
				removeSelf();
			}
			
		}
		
		public function removeSelf():void
		{
			if(this.parent != null)
			{
				this.removeEventListener(MouseEvent.CLICK, onClick);
				this.parent.removeChild(this);
			}
		}
		
		public function setText(text:String):void
		{
			this.txt_info.text = text;
		}
			
	}
}