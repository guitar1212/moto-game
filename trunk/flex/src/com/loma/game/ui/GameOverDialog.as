package com.loma.game.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	/**
	 * 
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class GameOverDialog extends Quest4
	{
		private var m_cb:Function = null;
		
		public function GameOverDialog()
		{
			super();
			
			this.btn_brack.addEventListener(MouseEvent.CLICK, onClick);
			
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
			if(event.keyCode == Keyboard.A)					
				onClick(null);				
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(m_cb != null)
				m_cb();
		}
		
		public function set score(value:int):void
		{
			this.txt_score.text = value.toString();
		}
		
		public function set life(value:int):void
		{
			this.LifeBar_mc.gotoAndStop(5 - value + 1);
		}
		
		public function set callback(cb:Function):void
		{
			m_cb = cb;
		}
	}
}