package com.loma.game.quest
{
	import com.loma.game.quest.define.QuestState;
	
	import flash.events.Event;
	import com.loma.game.quest.base.QuestBase;

	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class QuestObstacles extends QuestBase
	{
		private var m_obs:EventObject;
		
		private var m_bOK:Boolean = false;
		
		public function QuestObstacles()
		{
			super();
		}
		
		override public function start():void
		{
			createObstacle();
		}
		
		override public function onUpdate():void
		{	
		}
		
		override public function check():Boolean
		{			
			return game.player.hitObject.hitTestObject(m_obs);
		}
		
		override public function onCompleted():void
		{
			game.addScore(-5);
		}
		
		override public function end():void
		{			
			this.state = QuestState.DESTORY;
		}
		
		override public function release():void
		{
			m_obs.removeEventListener(Event.REMOVED, onRemoveObstacle);
			m_obs = null;
		}
		
		
		private function createObstacle():void
		{
			m_obs = new EventObject();
			m_obs.gotoAndStop(1 + ~~(Math.random()*2 + 0.5));
			game.background.addObject(2, m_obs, 0, 0);
			
			m_obs.addEventListener(Event.REMOVED, onRemoveObstacle);
		}
		
		protected function onRemoveObstacle(event:Event):void
		{
			// TODO Auto-generated method stub
			m_bOK = true;
		}
	}
}