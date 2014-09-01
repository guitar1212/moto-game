package com.loma.game.quest
{
	public class QuestBase implements IQuest
	{
		private var m_type:int;
		private var m_state:int;
		private var m_game:MotoGame;
		private var m_excuteTimes:int; // 此任務的執行次數
		private var m_bCompleted:Boolean = false;
		private var m_bPause:Boolean = false;
		
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
		
		public function set pause(b:Boolean):void
		{
			m_bPause = b;
		}
		
		public function get pause():Boolean
		{
			return m_bPause;
		}
		
		public function set excuteTimes(times:int):void
		{
			m_excuteTimes = times;
		}
		
		public function get excuteTimes():int
		{
			return m_excuteTimes;
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
		
		public function onCompleted():void
		{
			m_bCompleted = true;
		}
		
		public function end():void
		{
		}
		
		public function release():void
		{
		}
		
		public function isCompletetd():Boolean
		{
			return m_bCompleted;
		}
	}
}