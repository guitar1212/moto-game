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
		
		private var m_bStart:Boolean = false;
		
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
				m_questList.splice(index, 1);
				quest.release();
				quest = null;
			}
		}
		
		public function update():void
		{
			var q:QuestBase;
			for(var i:int = 0; i < m_questList.length; i++)
			{
				q = m_questList[i] as QuestBase;
				
				if(q.pause) continue;
				
				if(q.state == QuestState.ADD)
				{
					q.start();
					q.state = QuestState.DOING;
				}
				else if(q.state == QuestState.DOING)
				{
					q.onUpdate();
					if(q.check())
					{
						q.onCompleted();
						q.state = QuestState.COMPLETED;
						if(q.excuteTimes == 1)
						{
							q.state = QuestState.END;
							q.end();
						}
					}
				}
				else if(q.state == QuestState.COMPLETED)
				{
					if(q.excuteTimes == -1)
					{
						q.state = QuestState.DOING; // repeat quest
					}
				}
				else if(q.state == QuestState.END)
				{
					
				}
				else if(q.state == QuestState.DESTORY)
				{
					this.removeQuest(q);
					i++;
				}				
			}
		}

		public function get start():Boolean
		{
			return m_bStart;
		}

		public function set start(value:Boolean):void
		{
			m_bStart = value;
		}
		
		public function release():void
		{
			for(var i:int = 0; i < m_questList.length; i++)
			{
				var q:QuestBase = m_questList[i];
				q.release();
			}
			m_questList.length = 0;
		}

	}
}