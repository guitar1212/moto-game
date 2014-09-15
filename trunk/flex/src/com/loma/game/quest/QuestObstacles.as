package com.loma.game.quest
{
	import com.loma.game.quest.base.QuestBase;
	import com.loma.game.quest.define.QuestState;
	import com.loma.game.sound.SoundManager;
	
	import flash.events.Event;

	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class QuestObstacles extends QuestBase
	{
		private var m_obs:EventObject;
		
		private var m_bOK:Boolean = false;
		
		private var m_bTouched:Boolean = false;
		
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
			
			if(!m_bTouched && game.player.hitObject.hitTestObject(m_obs))
			{
				m_obs.alpha = 0.25;
				onFailed();
				m_bTouched = true;
				
			}
			if(!m_bOK)
				m_bOK = m_obs.parent == null;
		}
		
		private function onFailed():void
		{
			game.addScore(-30);
			
			game.player.playEffect(1);
			
			m_bOK = true;
			
			SoundManager.instance.playObstaclesSound();
		}
		
		override public function check():Boolean
		{			
			return m_bOK;
		}
		
		override public function onCompleted():void
		{
			game.dispatchEvent(new Event("QueseComplete"));			
		}
		
		override public function end():void
		{			
			this.state = QuestState.DESTORY;
		}
		
		override public function release():void
		{
			if(m_obs.parent)
				m_obs.parent.removeChild(m_obs);
			m_obs = null;
		}
		
		
		private function createObstacle():void
		{
			m_obs = new EventObject();
			m_obs.gotoAndStop(1 + ~~(Math.random()*3 - 0.001));
			game.background.addObject(2, m_obs, 0, 0);			
		}		
	}
}