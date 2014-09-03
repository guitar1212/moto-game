package com.loma.game.randomevent
{
	import com.loma.game.quest.QuestEmergency;
	import com.loma.game.quest.QuestManager;
	import com.loma.game.quest.QuestObstacles;
	import com.loma.game.quest.QuestQuiz;
	import com.loma.game.quest.base.QuestBase;
	
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class RandomEventManager
	{
		private static var m_instance:RandomEventManager = null;
		
		private static const TOTAL_EVENTS:int = 3;
		
		private var m_bStart:Boolean = false;
		
		private var m_target:int = 100;
		
		private var m_curCount:int = 0;
		
		private var m_game:MotoGame;
		
		private var m_bFinish:Boolean = true;
		
		public function RandomEventManager()
		{
		}
		
		public static function get instance():RandomEventManager
		{
			if(m_instance == null)
				m_instance = new RandomEventManager();
			
			return m_instance;
		}
		
		public function initialize(g:MotoGame):void
		{	
			m_game = g;
			m_game.addEventListener("QueseComplete", onQuestComplete);
		}
		
		protected function onQuestComplete(event:Event):void
		{
			m_bFinish = true;
			trace("QueseComplete");
		}
		
		public function start():void
		{
			m_bStart = true;
		}
		
		public function update():void
		{
			if(!m_bStart) return;
			
			if(!m_bFinish) return;
			
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
				// 路面障礙物
				case 0:
					q = new QuestObstacles();					
					break;
				
				// 問答
				case 1:
					q = new QuestQuiz();
					break;
				
				// 救護車任務
				case 2:
					q = new QuestEmergency();
					break;
				
				case 3:
					break;
				
				case 4:
					break;
				
				default:
					break;
			}
			
			// test
			q = new QuestEmergency();
			
			if(q)
			{
				QuestManager.instance.addQuest(q);
				m_bFinish = false;
			}
		}
		
		private function randomTarget():void
		{
			m_target = 70 + Math.random()*30;
		}
	}
}