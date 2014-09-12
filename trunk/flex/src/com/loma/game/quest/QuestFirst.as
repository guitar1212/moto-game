package com.loma.game.quest
{
	import com.loma.game.player.Rider;
	import com.loma.game.quest.base.QuestBase;
	import com.loma.game.quest.define.QuestState;
	import com.loma.game.randomevent.RandomEventManager;
	import com.loma.game.sound.SoundManager;
	import com.loma.game.string.StringTable;
	import com.loma.game.ui.FirstQuestionDialog;
	import com.loma.game.ui.ViolationDialog;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * 遊戲開始的第一個任務
	 * 詢問是否要戴安全帽
	 * 答錯扣血  答對加分
	 * 
	 * @long  Aug 29, 2014
	 * 
	 */	
	public class QuestFirst extends QuestBase
	{
		
		private var m_bOK:Boolean = false;
		private var m_bRight:Boolean = false;
		
		private var m_hatAni:HatAmi;
		
		public function QuestFirst()
		{
			excuteTimes = 1; 
		}
		
		override public function start():void
		{
			// 暫停遊戲進行
			game.gamePause = true;
			
			// 設置騎士為NO戴安全帽狀態
			game.player.state = Rider.STATE_START;
			
			// show ui
			var alert:FirstQuestionDialog = new FirstQuestionDialog();			
			alert.callback = onAlertMouseClick;
			alert.setYesButtonText(StringTable.HELMET_YES);
			alert.setNoButtonText(StringTable.HELMET_NO);
			game.addObjToLayer(MotoGame.LAYER_UI, alert);
		}
		
		protected function onAlertMouseClick(value:Boolean):void
		{			
			// 取消
			if(!value)
			{
				game.ui.showViolationUI(ViolationDialog.TYPE_BAD, StringTable.HELMET, 0, OK);
				m_bRight = false;
			}
			// 確定
			else 
			{		
				//m_bOK = true;
				m_bRight = true;
				
				m_hatAni = new HatAmi();
				m_hatAni.gotoAndPlay(1);				
				game.addObjToLayer(MotoGame.LAYER_UI, m_hatAni);				
			}
		}
		
		private function OK():void
		{
			game.ui.hideViolationUI();
			m_bOK = true;
		}
		
				
		override public function onUpdate():void
		{
			if(m_hatAni)
			{
				if(m_hatAni.currentFrame == m_hatAni.totalFrames)
				{
					m_hatAni.stop();
					game.removeObjFormLayer(MotoGame.LAYER_UI, m_hatAni);
					m_hatAni = null;
					m_bOK = true;
					
					game.player.state = Rider.STATE_STOP;
				}
			}
		}
		
		override public function check():Boolean
		{
			if(m_bOK)
			{
				this.state = QuestState.END;				
			}
			return m_bOK;
		}
		
		override public function end():void
		{
			this.state = QuestState.DESTORY;
			
			game.gamePause = false;
			//game.removeObjFormLayer(MotoGame.LAYER_UI, u);
			
			if(m_bRight)
			{
				game.addScore(50);
				SoundManager.instance.playAddScoreSound();
			}
			else
				game.addLife(-1);
			
			game.stage.focus = game.stage;
			
			// add quest
			var q:QuestSpeedLimit = new QuestSpeedLimit();
			q.speedLimit = 60;
			QuestManager.instance.addQuest(q);
			
			var qc:QuestOtherCars = new QuestOtherCars();
			QuestManager.instance.addQuest(qc);
			
			var qn:QuestNoTouch = new QuestNoTouch();
			QuestManager.instance.addQuest(qn);
			
			RandomEventManager.instance.start();
		}
		
		protected function onHatAniComplete(event:Event):void
		{
			game.removeObjFormLayer(MotoGame.LAYER_UI, event.target as HatAmi);
			//game.gamePause = false;
		}
		
		override public function release():void
		{
			
		}
	}
}