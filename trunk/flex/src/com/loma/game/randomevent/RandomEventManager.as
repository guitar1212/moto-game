package com.loma.game.randomevent
{
	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class RandomEventManager
	{
		private static var m_instance:RandomEventManager = null;
		
		private var m_eventList:Array = [];
		
		private var m_bStart:Boolean = false;
		
		private var m_target:int = 100;
		
		private var m_curCount:int = 0;
		
		public function RandomEventManager()
		{
		}
		
		public static function get instance():RandomEventManager
		{
			if(m_instance == null)
				m_instance = new RandomEventManager();
			
			return m_instance;
		}
		
		public function initialize():void
		{			
		}
		
		public function start():void
		{
			m_bStart = true;
		}
		
		public function update():void
		{
			if(!m_bStart) return;
			
			m_curCount++;
			if(m_curCount >= m_target)
			{
				randomTarget();
			}
			
		}
		
		private function randomTarget():void
		{
			m_target = 70 + Math.random()*30;
		}
	}
}