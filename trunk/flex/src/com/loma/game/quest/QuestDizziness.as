package com.loma.game.quest
{
	import com.loma.game.quest.base.QuestBase;
	
	/**
	 * 暈眩任務
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class QuestDizziness extends QuestBase
	{
		public function QuestDizziness()
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