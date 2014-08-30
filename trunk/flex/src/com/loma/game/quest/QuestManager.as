package com.loma.game.quest
{
	import com.loma.game.quest.define.QuestState;

	/**
	 * 
	 * @long  Aug 29, 2014
	 * 
	 */	
	public class QuestManager
	{
		private static var m_instance:QuestManager = null;
		
		private var m_questList:Array = [];
		
		private var m_game:MotoGame;
		
		public function QuestManager()
		{
		}
		
		public static function get instance():QuestManager
		{
			if(m_instance == null)
				m_instance = new QuestManager();
			
			return m_instance;
		}
		
		public function ininialize(g:MotoGame):void
		{
			m_game = g;
		}
		
		public function get game():MotoGame
		{
			return m_game;
		}
		
		public function addQuest(quest:QuestBase):void
		{
			quest.game = m_game;
			m_questList.push(quest);
			quest.state = QuestState.ADD;
		}
		
		public function removeQuest(quest:QuestBase):void
		{
			var index:int = m_questList.indexOf(quest);		
			if(index > -1)
			{
				//m_questList.splice(
				quest.release();
			}
		}
		
		public function update():void
		{
			var q:QuestBase;
			for(var i:int = 0; i < m_questList.length; i++)
			{
				q = m_questList[i] as QuestBase;
				
				if(q.state == QuestState.ADD)
				{
					q.start();
					q.state = QuestState.DOING;
				}
				else if(q.state == QuestState.DOING)
				{
					q.onUpdate();
					q.check();
				}
				else if(q.state == QuestState.END)
				{
					q.end();
				}
				else if(q.state == QuestState.DESTORY)
				{
					this.removeQuest(q);
					i++;
				}				
			}
		}
	}
}