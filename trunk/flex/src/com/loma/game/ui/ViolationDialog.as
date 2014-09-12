package com.loma.game.ui
{
	import com.loma.game.string.StringTable;
	import com.loma.util.SimpleButtonSetter;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

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
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
			SimpleButtonSetter(this.btn_yes, StringTable.BTN_VIOLATION);
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
				if(m_cb != null) m_cb();
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
			Icon_police.gotoAndStop(t);
		}
		
		public function get type():int
		{
			return txt_title.currentFrame;
		}
		
		public function set score(value:int):void
		{
			var color:uint;
			if(value > 0)
			{
				color = 0x542B01;
				txt_score.text = "+" + value.toString();
			}
			else 
			{
				color = 0x990000;
				txt_score.text = value.toString();
			}
			
			if(value == 0)
				txt_score.visible = false;
			else
				txt_score.visible = true;
			
			txt_score.textColor = color;
			
		}
	}
}