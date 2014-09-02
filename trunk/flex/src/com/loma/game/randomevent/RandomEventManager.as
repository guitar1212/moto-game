package com.loma.game.randomevent
{
	import com.loma.game.quest.QuestManager;
	import com.loma.game.quest.QuestObstacles;
	import com.loma.game.quest.base.QuestBase;

	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class RandomEventManager
	{
		private static var m_instance:RandomEventManager = null;
		
		private static const TOTAL_EVENTS:int = 1;
		
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
				m_curCount = 0;
				randomTarget();
				
				randomQuest();
			}
			
		}
		
		private function randomQuest():void
		{
			var randomIdx:int = ~~(Math.random()*(TOTAL_EVENTS - 1) + 0.5);
			var q:QuestBase = null;
			switch(randomIdx)
			{
				case 0:
					q = new QuestObstacles();
					
					break;
				
				default:
					break;
			}
			
			if(q)
				QuestManager.instance.addQuest(q);
		}
		
		private function randomTarget():void
		{
			m_target = 70 + Math.random()*30;
		}
	}
}