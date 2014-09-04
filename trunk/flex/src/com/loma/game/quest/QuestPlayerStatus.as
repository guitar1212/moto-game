package com.loma.game.quest
{
	import com.loma.game.quest.base.QuestBase;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	/**
	 * 
	 * @long  Sep 4, 2014
	 * 
	 */	
	public class QuestPlayerStatus extends QuestBase
	{
		private static const TYPE_CELLPHONE:int = 0;
		private static const TYPE_TIRED:int = 1;
		private static const TYPE_AMOUNT:int = 2;
		
		private var m_eventObj:DisplayObject = null;
		
		private var m_type:int;
		
		private var m_waitCount:int = 100;
		
		private var m_bOK:Boolean = false;
		
		public function QuestPlayerStatus()
		{
			super();
		}
		
		override public function start():void
		{			
			m_type = getTimer()%TYPE_AMOUNT;
			if(m_type == TYPE_CELLPHONE)
				m_eventObj = new EventObject1();
			else if(m_type == TYPE_TIRED)
				m_eventObj = new EventObject2();
			
			m_eventObj.x = 60;
			m_eventObj.y = -185;
							
			m_eventObj.addEventListener(MouseEvent.CLICK, onEventClick);
			game.player.addChild(m_eventObj);
		}
		
		protected function onEventClick(event:MouseEvent):void
		{
			m_bOK = true;
		}
		
		override public function onUpdate():void
		{
			m_waitCount--;
			if(m_waitCount <= 0)
			{
				m_bOK = true;
			}
		}
		
		override public function check():Boolean
		{			
			return m_bOK;
		}
		
		override public function onCompleted():void
		{
			
		}
		
		override public function end():void
		{			
		}
		
		override public function release():void
		{
			game.player.removeChild(m_eventObj);
			m_eventObj.removeEventListener(MouseEvent.CLICK, onEventClick);
			m_eventObj = null;
		}
	}
}