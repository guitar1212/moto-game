package com.loma.game.ui
{
	import com.loma.util.SimpleButtonSetter;
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class FirstQuestionDialog extends Quest1
	{
		private var m_cb:Function = null;
		
		public function FirstQuestionDialog()
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
				{
					m_cb(true);
					removeSelf();
				}
				else if(event.keyCode == Keyboard.D)
				{
					m_cb(false);
					removeSelf();
				}
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
		
		public function setYesButtonText(text:String):void
		{
			SimpleButtonSetter(this.btn_yes, text);
		}
		
		public function setNoButtonText(text:String):void
		{
			SimpleButtonSetter(this.btn_no, text);
		}
			
	}
}