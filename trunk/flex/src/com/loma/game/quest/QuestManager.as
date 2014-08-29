package com.loma.game.quest
{
	/**
	 * 
	 * @long  Aug 29, 2014
	 * 
	 */	
	public class QuestManager
	{
		private static var m_instance:QuestManager = null;
		
		private var m_questList:Array = [];
		
		public function QuestManager()
		{
		}
		
		public static function get instance():QuestManager
		{
			if(m_instance == null)
				m_instance = new QuestManager();
			
			return m_instance;
		}
		
		public function ininialize():void
		{
			
		}
		
		public function addQuest(quest:IQuest):void
		{
			m_questList.push(quest);
		}
		
		public function removeQuest(quest:IQuest):void
		{
			var index:int = m_questList.indexOf(quest);
			if(index > -1)
			{
				//m_questList.splice(
			}
		}
	}
}