package com.loma.game.quest
{
	import com.loma.game.quest.base.QuestBase;
	
	import flash.events.Event;
	
	/**
	 * 救護車任務
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class QuestTrafficLights extends QuestBase
	{
		private var m_trafficLight:RoadEvent;
		
		public function QuestTrafficLights()
		{
			super();
		}
		
		override public function start():void
		{
			m_trafficLight = new RoadEvent();
			game.background.addObject(2, m_trafficLight, 0, 0);
		}
		
		override public function onUpdate():void
		{
		}
		
		override public function check():Boolean
		{			
			return (m_trafficLight.parent == null);
		}
		
		override public function onCompleted():void
		{
			game.dispatchEvent(new Event("QueseComplete"));
		}
		
		override public function end():void
		{			
		}
		
		override public function release():void
		{
			
		}
	}
}