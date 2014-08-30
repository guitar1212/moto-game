package com.loma.game.quest
{
	/**
	 * 
	 * @long  Aug 29, 2014
	 * 
	 */	
	public class QuestFirst implements IQuest
	{
		private var m_game:MotoGame;
		
		public function QuestFirst()
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
		}
		
		public function get type():int
		{
			return 0;
		}
		
		public function set state(s:int):void
		{
		}
		
		public function get state():int
		{
			return 0;
		}
		
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