package com.loma.game.ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
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