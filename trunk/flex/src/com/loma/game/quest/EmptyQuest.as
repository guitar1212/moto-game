package com.loma.game.quest
{
	/**
	 * 
	 * @long  Sep 1, 2014
	 * 
	 */	
	public class EmptyQuest extends QuestBase
	{		
		public function EmptyQuest()
		{
			super();
		}
		
		override public function start():void
		{
		}
		
		override public function onUpdate():void
		{
		}
		
		override public function check():Boolean
		{			
			return false;
		}
		
		override public function onCompleted():void
		{
			
		}
		
		override public function end():void
		{			
		}
		
		override public function release():void
		{
			
		}
	}
}