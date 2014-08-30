package com.loma.game.quest
{
	public class QuestBase implements IQuest
	{
		private var m_type:int;
		private var m_state:int;
		private var m_game:MotoGame;
		
		public function QuestBase()
		{
		}
		
		public function set game(g:MotoGame):void
		{
			m_game = g;
		}
		
		public function get game():MotoGame
		{
			return m_game;
		}
		
		public function set type(t:int):void
		{
			m_type = t;
		}
		
		public function get type():int
		{
			return m_type;
		}
		
		public function set state(s:int):void
		{
			m_state = s;
		}
		
		public function get state():int
		{
			return m_state;
		}
		
		
		//=================================================================================
		//
		//	Override function
		//
		//=================================================================================
		public function start():void
		{
		}
		
		public function onUpdate():void
		{
		}
		
		public function check():Boolean
		{
			return false;
		}
		
		public function end():void
		{
		}
		
		public function release():void
		{
		}
	}
}