package com.loma.game.quest
{
	import com.loma.game.car.Ambulance;
	import com.loma.game.quest.base.QuestBase;
	import com.loma.game.quest.define.QuestState;
	import com.loma.game.sound.SoundManager;
	import com.loma.game.string.StringTable;
	import com.loma.game.ui.ViolationDialog;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * 救護車任務
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class QuestEmergency extends QuestBase
	{
		/**
		 *	救護車狀態
		 *  0 : 上未出現在螢幕上
		 * 	1 : 到達位置, 等待玩家讓開道路
		 *  2 : 玩家讓開
		 */		
		private var m_state:int = 0;
		
		private var m_waitCount:int = 0;
		
		private var m_ambulance:Ambulance = new Ambulance();
		
		public function QuestEmergency()
		{
			super();
		}
		
		override public function start():void
		{
			m_ambulance.x = -30;
			m_ambulance.y = 350;
			
			game.addObjToLayer(MotoGame.LAYER_SCENE, m_ambulance);
			
			SoundManager.instance.playAmbulanceSound();			
		}
		
		override public function onUpdate():void
		{
			if(m_state == 0)
			{
				m_ambulance.x += 1;
				if(m_ambulance.x >= 40)
					m_state = 1;
			}
			else if(m_state == 1)
			{
				m_waitCount++;
				if(game.player.y > 400)
					m_state = 2;
				
				if(m_waitCount > 150) // 違規
				{
					m_state = -1;
					onFailed();
				}
			}
			else if(m_state == 2)
			{
				m_ambulance.x = m_ambulance.x + 12;
				
				if(game.player.hitObject.hitTestObject(m_ambulance))
				{
					SoundManager.instance.playCrashSound();
					onFailed();
				}
				
				if(m_ambulance.x > 1000)
					m_state = 3;
			}
			else if(m_state == 3)
			{
				game.gamePause = true;
				QuestManager.instance.start = false;
				game.ui.showViolationUI(ViolationDialog.TYPE_GOOD, StringTable.AMBULANCE_PASS, 50, resume);
			}
		}
		
		private function resume():void
		{
			game.ui.hideViolationUI();
			game.gamePause = false;
			QuestManager.instance.start = true;
			
			game.stage.focus = game.stage;
			SoundManager.instance.stopAmbulanceSound();
			game.addScore(50);
			m_state = 4;
		}
		
		/**
		 *	失敗處理 
		 * 
		 */
		private function onFailed():void
		{
			this.pause = true;
			game.gamePause = true;
			m_state = 4;
			game.ui.showViolationUI(ViolationDialog.TYPE_BAD, StringTable.AMBULANCE, -30, confirm);
		}
		
		private function confirm():void
		{
			this.pause = false;
			game.gamePause = false;
			
			game.ui.hideViolationUI();
						
			game.addScore(-30);
			game.addLife(-1);
			
			game.stage.focus = game.stage;
			SoundManager.instance.stopAmbulanceSound();
			
			game.riderStart();
		}
		
		override public function check():Boolean
		{			
			return m_state == 4;
		}
		
		override public function onCompleted():void
		{
			game.dispatchEvent(new Event("QueseComplete"));
			SoundManager.instance.stopAmbulanceSound();
		}
		
		override public function end():void
		{
			this.state = QuestState.DESTORY;
		}
		
		override public function release():void
		{
			if(m_ambulance.parent)
				m_ambulance.parent.removeChild(m_ambulance);
				
			m_ambulance = null;
			SoundManager.instance.stopAmbulanceSound();
		}
	}
}